import fs from "fs";
import path from "path";
import { PDFDocument, rgb, StandardFonts } from "pdf-lib";

// TODO: move the lists in the bash script and call this script with arguments

async function combinePDFs() {
  const lectureTopics = [
    "introduction",
    "git-and-github",
    "testing-fundamentals",
    "unit-testing",
    "test-driven-development",
    "ui-integration-testing",
    "test-doubles",
    "end-to-end-testing",
    "git-and-github-collaboration",
    "ci-cd",
    "coverage",
    "maintainability",
    "reliability-testing",
  ];

  const assignments = [
    "git-and-github",
    "unit-tests",
    "integration-tests",
    "end-to-end-tests",
    "project",
  ];

  const practicalities = ["peer-evaluation"];

  // Create new PDF document
  const mergedPdf = await PDFDocument.create();

  // Add metadata
  mergedPdf.setTitle("CS362 Complete Course Materials");
  mergedPdf.setAuthor("Alex Ulbrich");
  mergedPdf.setSubject("Software Engineering II");
  mergedPdf.setCreationDate(new Date());

  // Function to add PDF with section header
  async function addPDFSection(filename, sectionTitle) {
    try {
      if (!fs.existsSync(filename)) {
        console.log(`Skipping ${filename} - file not found`);
        return;
      }

      const pdfBytes = fs.readFileSync(filename);
      const pdf = await PDFDocument.load(pdfBytes);
      const pages = await mergedPdf.copyPages(pdf, pdf.getPageIndices());

      // Add all pages from the PDF
      pages.forEach((page) => mergedPdf.addPage(page));

      console.log(`Added: ${sectionTitle} (${pages.length} pages)`);
    } catch (error) {
      console.error(`Error adding ${filename}:`, error.message);
    }
  }

  // Add lecture notes
  for (const topic of lectureTopics) {
    await addPDFSection(
      `./temp/lecture-notes-${topic}.pdf`,
      `Lecture: ${topic.replace(/-/g, " ").replace(/\b\w/g, (l) => l.toUpperCase())}`
    );
  }

  // Add assignments
  for (const topic of assignments) {
    await addPDFSection(
      `./temp/assignment-${topic}.pdf`,
      `Assignment: ${topic.replace(/-/g, " ").replace(/\b\w/g, (l) => l.toUpperCase())}`
    );
  }

  // Add practicalities
  for (const topic of practicalities) {
    await addPDFSection(
      `./temp/practicalities-${topic}.pdf`,
      `Practicalities: ${topic.replace(/-/g, " ").replace(/\b\w/g, (l) => l.toUpperCase())}`
    );
  }

  // Add headers and footers to all pages
  const pages = mergedPdf.getPages();
  const font = await mergedPdf.embedFont(StandardFonts.Helvetica);
  const totalPages = pages.length;

  pages.forEach((page, index) => {
    const { width, height } = page.getSize();

    // Header
    page.drawText("CS362 Software Engineering II", {
      x: 40,
      y: height - 30,
      size: 10,
      font,
      color: rgb(0.3, 0.3, 0.3),
    });

    const dateText = `Generated: ${new Date().toLocaleDateString()}`;
    const dateTextWidth = font.widthOfTextAtSize(dateText, 10);
    page.drawText(dateText, {
      x: width - dateTextWidth - 40,
      y: height - 30,
      size: 10,
      font,
      color: rgb(0.3, 0.3, 0.3),
    });

    // Footer
    page.drawText(
      "© 2025 Alexander Ulbrich. Adapted from Robin Hess. Licensed under CC BY-SA 4.0.",
      {
        x: 40,
        y: 20,
        size: 10,
        font,
        color: rgb(0.3, 0.3, 0.3),
      }
    );

    const pageText = `Page ${index + 1} of ${totalPages}`;
    const pageTextWidth = font.widthOfTextAtSize(pageText, 10);
    page.drawText(pageText, {
      x: width - pageTextWidth - 40,
      y: 20,
      size: 10,
      font,
      color: rgb(0.3, 0.3, 0.3),
    });
  });

  // Save the merged PDF
  const pdfBytes = await mergedPdf.save();
  fs.writeFileSync("cs362-complete-course-materials.pdf", pdfBytes);

  console.log(`\nCombined PDF created: cs362-complete-course-materials.pdf`);
  console.log(`Total pages: ${totalPages}`);
}

// Run the function
combinePDFs().catch(console.error);
