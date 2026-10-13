# Plantilla Docker - Python (Backend)

Plantilla minimalista y multipropósito para Python en Docker. No incluye frameworks, ORMs ni transportes predefinidos.

## Requisitos previos

Crear la red externa de Docker definida en `.env` (si aún no existe):

```bash
docker network create template-network
```

## Uso en desarrollo

1. Iniciar los contenedores:
   ```bash
   docker compose up -d
   ```

2. Crear tu archivo `main.py` y opcionalmente `requirements.txt` en `./volume/app/src/`.

3. El contenedor ejecutará automáticamente `main.py` (e instalará `requirements.txt` si existe).

## Uso en producción

Construir y levantar en modo producción:

```bash
docker compose -f docker-compose.prod.yml up -d --build
```
