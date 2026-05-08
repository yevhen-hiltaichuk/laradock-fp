FROM python:3.9-slim

# System dependencies + Node.js + Chromium (for Pyppeteer)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    make \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    libffi-dev \
    libev-dev \
    libevent-dev \
    chromium \
    nodejs \
    npm \
    locales \
    && printf 'en_US.UTF-8 UTF-8\nen_US ISO-8859-1\nen_AU.UTF-8 UTF-8\nen_AU ISO-8859-1\n' >> /etc/locale.gen \
    && locale-gen \
    && npm install -g sass \
    && rm -rf /var/lib/apt/lists/*

# Tell Pyppeteer to use system Chromium instead of downloading its own.
# PYPPETEER_CHROMIUM_REVISION must be a valid integer string — empty value
# crashes pyppeteer 0.2.5 at import time (chromium_downloader.py line 39).
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium \
    PYPPETEER_EXECUTABLE_PATH=/usr/bin/chromium \
    PYPPETEER_CHROMIUM_REVISION=588429 \
    PYPPETEER_SKIP_CHROMIUM_DOWNLOAD=1

# pyppeteer 0.2.5 hard-codes the bundled chrome path and ignores PYPPETEER_EXECUTABLE_PATH.
# Symlink the expected location to the system Chromium so launch() works on aarch64
# (Apple Silicon hosts) — the bundled revision is x86_64-only and crashes with
# "rosetta error" inside an ARM container.
RUN mkdir -p /root/.local/share/pyppeteer/local-chromium/588429/chrome-linux \
 && ln -s /usr/bin/chromium /root/.local/share/pyppeteer/local-chromium/588429/chrome-linux/chrome

# Python dependencies (skip gevent/greenlet — unused in codebase, fails to compile)
COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip wheel && pip install "setuptools<71" \
    && grep -v -E '^(gevent|greenlet|websockets|typing-extensions)' /tmp/requirements.txt > /tmp/requirements_filtered.txt \
    && pip install --no-cache-dir -r /tmp/requirements_filtered.txt slowapi "typing_extensions>=4.0" "qrcode[pil]" \
    && rm /tmp/requirements.txt /tmp/requirements_filtered.txt

WORKDIR /var/www/fieldpulse-pdf-generator

EXPOSE 8000 6001
