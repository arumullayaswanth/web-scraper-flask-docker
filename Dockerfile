# ---- Build Stage ----
FROM node:18-slim AS build-stage

# Install necessary dependencies for Puppeteer
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    ca-certificates \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libx11-xcb1 \
    libnss3 \
    lsb-release \
    xdg-utils \
    && rm -rf /var/lib/apt/lists/*

# Set environment variable to skip Chromium download by Puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

# Set the working directory
WORKDIR /app

# Copy package.json and install dependencies (including puppeteer)
COPY package.json package-lock.json ./
RUN npm install

# Copy the scraper script into the container
COPY scrape.js ./

# ---- Final Stage (Python) ----
FROM python:3.10-slim AS server-stage

# Set the working directory for the Python Flask server
WORKDIR /app

# Copy the server files
COPY server.py ./
COPY requirements.txt ./

# Install Flask dependencies
RUN pip install -r requirements.txt

# Copy the scraped data from the build stage
COPY --from=build-stage /app/scraped_data.json ./

# Expose port 5000 for the Flask server
EXPOSE 5000

# Command to run the Flask app
CMD ["python", "server.py"]
