const puppeteer = require('puppeteer');
const fs = require('fs');

const url = process.env.SCRAPE_URL || 'https://portfolioyaswanth.netlify.app/';
(async () => {
    const browser = await puppeteer.launch({
        headless: true,
        args: ['--no-sandbox', '--disable-setuid-sandbox']
    });

    const page = await browser.newPage();
    await page.goto(url);

    const data = await page.evaluate(() => {
        const title = document.title;
        const firstHeading = document.querySelector('h1')?.innerText || 'No Heading';
        const paragraph = document.querySelector('p')?.innerText || 'No Paragraph';
        return { title, firstHeading, paragraph };
    });

    fs.writeFileSync('scraped_data.json', JSON.stringify(data, null, 2));
    await browser.close();
})();

