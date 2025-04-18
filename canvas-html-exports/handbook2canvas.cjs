const puppeteer = require("puppeteer");
const juice = require("juice");
const fs = require("fs");

// ai-assisted draft script to get the html and inline css from the <main> content for Canvas import
// this is not working properly yet (if ever)

(async () => {
  // Launch headless browser
  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  // Navigate to the target web page
  const url = "https://cs362.alexulbrich.com/lectures/git-and-github/"; // Replace with your target URL
  await page.goto(url, { waitUntil: "networkidle2" });

  // Extract all stylesheets content
  const stylesheets = await page.evaluate(() => {
    const styles = [];
    // Get inline styles
    document.querySelectorAll("style").forEach((style) => {
      styles.push(style.innerHTML);
    });

    // Get external stylesheets
    const links = Array.from(
      document.querySelectorAll('link[rel="stylesheet"]')
    );
    return {
      inlineStyles: styles.join("\n"),
      externalStylesheets: links.map((link) => link.href),
    };
  });

  // Extract just the main content HTML
  const mainContent = await page.evaluate(() => {
    const main = document.querySelector("main");
    return main ? main.outerHTML : "<div>No main content found</div>";
  });

  // Fetch external stylesheets content
  let externalCss = "";
  for (const stylesheetUrl of stylesheets.externalStylesheets) {
    try {
      // Navigate to stylesheet URL to get its content
      await page.goto(stylesheetUrl, { waitUntil: "networkidle2" });
      const cssContent = await page.evaluate(() => document.body.innerText);
      externalCss += cssContent + "\n";
    } catch (error) {
      console.warn(`Failed to fetch stylesheet: ${stylesheetUrl}`, error);
    }
  }

  // Combine all CSS
  const allCss = stylesheets.inlineStyles + "\n" + externalCss;

  // Create a simple HTML wrapper with our collected styles
  const wrappedContent = `
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="UTF-8">
      <style>${allCss}</style>
    </head>
    <body>
      ${mainContent}
    </body>
    </html>
  `;

  // Inline CSS using juice
  const inlinedHtml = juice(wrappedContent, {
    preserveMediaQueries: true,
    applyStyleTags: true,
    inlinePseudoElements: true,
  });

  // Extract just the main content with inlined styles
  const finalContent = await (async () => {
    const tempBrowser = await puppeteer.launch();
    const tempPage = await tempBrowser.newPage();
    await tempPage.setContent(inlinedHtml);
    const extractedMain = await tempPage.evaluate(() => {
      const main = document.querySelector("main");
      return main ? main.outerHTML : document.body.innerHTML;
    });
    await tempBrowser.close();
    return extractedMain;
  })();

  // Save the inlined HTML to a file
  fs.writeFileSync("output-main.html", finalContent);
  console.log("Main content with inline styles saved to output-main.html");

  // Close the browser
  await browser.close();
})();
