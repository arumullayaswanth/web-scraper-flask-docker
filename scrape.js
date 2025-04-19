const puppeteer = require('puppeteer');
const fs = require('fs');

const url = process.env.SCRAPE_URL || 'https://arumullayaswanth.github.io/Netflix-Projrct/index.html';

async function scrape() {
    const browser = await puppeteer.launch({ headless: true, args: ['--no-sandbox', '--disable-setuid-sandbox'] });
    const page = await browser.newPage();
    await page.goto(url);

    const data = await page.evaluate(() => {
        const title = document.title;
        const firstHeading = document.querySelector('h1') ? document.querySelector('h1').innerText : 'No Heading Found';
        const firstParagraph = document.querySelector('p') ? document.querySelector('p').innerText : 'No Paragraph Found';

        return {
            title,
            firstHeading,
            firstParagraph
        };
    });

    fs.writeFileSync('scraped_data.json', JSON.stringify(data, null, 2));

    await browser.close();
}

scrape();
