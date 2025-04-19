// scrape.js
const puppeteer = require('puppeteer');
const fs = require('fs');

const url = process.env.SCRAPE_URL || 'https://arumullayaswanth.github.io/Netflix-Projrct/';


(async () => {
  const browser = await puppeteer.launch({
    headless: true,
    executablePath: '/usr/bin/chromium',
    args: ['--no-sandbox', '--disable-setuid-sandbox']
  });

  const page = await browser.newPage();
  await page.goto(url);

  const data = await page.evaluate(() => {
    const title = document.title;
    const firstHeading = document.querySelector('h1')?.innerText || 'No heading';
    return { title, firstHeading };
  });

  fs.writeFileSync('scraped_data.json', JSON.stringify(data, null, 2));
  await browser.close();
})();
