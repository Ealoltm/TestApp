# app/store_data.py
from random import randint

# pretend inventory
PRODUCTS = {
    1: {"id": 1, "name": "Coffee", "price": 3.5, "stock": 50},
    2: {"id": 2, "name": "Tea", "price": 2.8, "stock": 40},
    3: {"id": 3, "name": "Cookie", "price": 1.5, "stock": 100},
}

ORDERS = []

def list_products():
    return list(PRODUCTS.values())

def get_product(pid: int):
    return PRODUCTS.get(pid)

def create_order(pid: int, quantity: int):
    product = PRODUCTS.get(pid)
    if not product or product["stock"] < quantity:
        return None
    product["stock"] -= quantity
    order = {"id": len(ORDERS) + 1, "product_id": pid, "quantity": quantity, "total": product["price"] * quantity}
    ORDERS.append(order)
    return order

def random_inventory_change():
    """simulate background fluctuation"""
    pid = randint(1, len(PRODUCTS))
    PRODUCTS[pid]["stock"] += randint(-2, 5)
