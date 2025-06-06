import puppeteer from "puppeteer";

async function printToPDF(url, outputPath) {
  const browser = await puppeteer.launch({
    headless: "new",
  });

  const page = await browser.newPage();

  await page.goto(url, {
    waitUntil: "networkidle2",
  });

  // Wait for Mermaid diagrams to render
  await page.waitForFunction(
    () => {
      // Check if Mermaid has initialized
      const mermaidDivs = document.querySelectorAll(".mermaid");
      if (mermaidDivs.length === 0) return true;

      return Array.from(mermaidDivs).every((div) => {
        return div.querySelector("svg") !== null;
      });
    },
    {
      timeout: 30000, // 30 seconds timeout
    }
  );

  // Isolate main content and remove footer within it
  await page.evaluate(() => {
    const mainContent =
      document.querySelector("main") ||
      document.querySelector(".content") ||
      document.querySelector('[role="main"]');

    if (mainContent) {
      // Remove any footer elements within main content
      const footer = mainContent.querySelector("footer");
      if (footer) {
        footer.remove();
      }

      // Replace body content with cleaned main content
      document.body.innerHTML = "";
      document.body.appendChild(mainContent.cloneNode(true));

      // Basic styling
      document.body.style.margin = "0";
      document.body.style.padding = "20px";
    }
  });

  // Print to PDF
  await page.pdf({
    path: outputPath,
    format: "Letter",
    printBackground: true,
    margin: {
      top: "100px",
      bottom: "100px",
      left: "20px",
      right: "20px",
    },
  });

  await browser.close();
  console.log(`PDF saved to ${outputPath}`);
}

(async () => {
  // Get command-line arguments
  const args = process.argv.slice(2); // Skip node and script path

  // Check if required arguments are provided
  if (args.length < 2) {
    console.error("Usage: node script.js <url> <output-file>");
    console.error("Example: node script.js https://example.com output.pdf");
    process.exit(1);
  }

  const [url, outputPath] = args;

  try {
    await printToPDF(url, outputPath);
  } catch (error) {
    console.error("Error generating PDF:", error);
    process.exit(1);
  }
})();
