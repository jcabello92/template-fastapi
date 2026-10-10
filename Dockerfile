# --- FASE 1: BASE ---
FROM python:3.15.0rc3-slim AS base
WORKDIR /app
RUN apt-get update && apt-get install -y gcc libpq-dev && rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir fastapi uvicorn

# --- FASE 2: DESARROLLO (dev) ---
FROM base AS dev
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
CMD ["sh", "-c", "if [ -f main.py ]; then uvicorn main:app --host 0.0.0.0 --port 8000 --reload; else echo 'Proyecto no inicializado. Manteniendo contenedor vivo...' && tail -f /dev/null; fi"]

# --- FASE 3: PRODUCCIÓN (prod) ---
FROM base AS prod
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
COPY ./volume/app/src .
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]