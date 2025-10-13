FROM python:3.12-slim

RUN useradd -m appuser

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY app/ /app/app/

EXPOSE 8000

USER appuser

# 9️⃣ Start the FastAPI app using Uvicorn (the ASGI web server)
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
