# ---- Scraper Stage ----
FROM node:18-slim AS scraper

RUN apt-get update && apt-get install -y \
    chromium \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libgdk-pixbuf2.0-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    --no-install-recommends && apt-get clean

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

WORKDIR /app
COPY package.json ./
RUN npm install
COPY scrape.js ./
ENV SCRAPE_URL=https://example.com
RUN node scrape.js

# ---- Server Stage ----
FROM python:3.10-slim AS server

WORKDIR /app

COPY --from=scraper /app/scraped_data.json ./scraped_data.json
COPY server.py .
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000
CMD ["python", "server.py"]
