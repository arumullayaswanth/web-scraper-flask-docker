
## 🔨 Build the Docker Image

You can customize the URL you want to scrape using the `--build-arg` flag.

```bash
docker build -t scraper-flask --build-arg SCRAPE_URL="https://example.com" .
```

✅ This will:
- Build a Node.js environment
- Scrape the provided URL
- Store the scraped output in `scraped_data.json`
- Move that data into a lightweight Python Flask server

---

## 🚀 Run the Container

```bash
docker run -p 5000:5000 scraper-flask
```

✅ Flask will start and serve your data.

---

## 🌐 Access the Scraped Data

Open your browser and go to:

```
http://localhost:5000
```

You will see:

```json
{
  "title": "Example Domain",
  "firstHeading": "Example Domain"
}
```

---

## 🔁 Scrape Another URL

To scrape a different site:

```bash
docker build -t scraper-flask --build-arg SCRAPE_URL="https://wikipedia.org" .
docker run -p 5000:5000 scraper-flask
```

Then go to:

```
http://86.845.86:5000
```

---

## 🧹 Cleanup

To remove all containers and images (optional):

```bash
docker ps -a             # List running containers
docker rm <container_id> # Remove container
docker rmi scraper-flask # Remove image
```


