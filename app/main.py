from fastapi import FastAPI, Request, Form
from fastapi.responses import HTMLResponse
from fastapi.templating import Jinja2Templates
from fastapi.staticfiles import StaticFiles
from prometheus_fastapi_instrumentator import Instrumentator
import random, time

from app import store_data

app = FastAPI(title="Mini Store", version="0.1.0")

# setup templates & static files
templates = Jinja2Templates(directory="app/templates")
app.mount("/static", StaticFiles(directory="app/static"), name="static")

# Prometheus metrics
Instrumentator().instrument(app).expose(app)

# Custom business metrics
from prometheus_client import Counter, Gauge

ORDERS_TOTAL = Counter("mini_store_orders_total", "Total number of orders placed")
INVENTORY_GAUGE = Gauge("mini_store_inventory_stock", "Current stock per product", ["product"])

@app.on_event("startup")
def init_metrics():
    for p in store_data.PRODUCTS.values():
        INVENTORY_GAUGE.labels(product=p["name"]).set(p["stock"])

@app.get("/", response_class=HTMLResponse)
def index(request: Request):
    products = store_data.list_products()
    return templates.TemplateResponse("index.html", {"request": request, "products": products})

@app.post("/order", response_class=HTMLResponse)
def create_order(request: Request, product_id: int = Form(...), quantity: int = Form(...)):
    time.sleep(random.uniform(0.05, 0.25))  # simulate latency
    order = store_data.create_order(product_id, quantity)
    if not order:
        msg = "Order failed! Not enough stock or product not found."
    else:
        msg = f"✅ Order #{order['id']} created successfully!"
        ORDERS_TOTAL.inc()
        for p in store_data.PRODUCTS.values():
            INVENTORY_GAUGE.labels(product=p["name"]).set(p["stock"])
    products = store_data.list_products()
    return templates.TemplateResponse("index.html", {"request": request, "products": products, "message": msg})

@app.get("/healthz")
def health():
    return {"status": "ok"}
