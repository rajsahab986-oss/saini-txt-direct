FROM python:3.12-slim

WORKDIR /app
COPY . .

RUN apt-get update && apt-get install -y \
    ffmpeg \
    aria2 \
    gcc \
    g++ \
    make \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# pkg_resources FIX
RUN pip install --upgrade pip setuptools wheel

RUN pip install -r sainibots.txt

CMD ["sh", "-c", "gunicorn app:app --bind 0.0.0.0:${PORT:-8000} & python3 modules/main.py"]
