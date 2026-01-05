## Quick orientation — what this repo is

This is an Astro + Starlight static site that hosts course material for CS 362 (lectures, assignments, practicalities). Key developer concerns are: content pages (MDX), site styling (Tailwind + Starlight), PDF export tooling (custom Puppeteer scripts), and a few standalone data-processing scripts (R) that operate on CSVs in `data/`.

## What to modify / where to look
- Content pages: `src/content/docs/*` (subfolders: `lectures/`, `assignments/`, `practicalities/`, `overview/`, `about/`). MDX pages use Starlight frontmatter (title, template, hero, etc.). See `src/content/docs/index.mdx` for an example.
- Frontmatter schema: `src/content/config.ts` (uses `docsSchema()` — follow that structure when adding new docs pages).
- Styling: `src/styles/global.css` and Tailwind config in project root. Starlight integration is in `astro.config.mjs`.
- Site config: `astro.config.mjs` (mermaid integration, starlight options, sitemaps, sidebar auto-generate)
- Server / debug config: `.vscode/launch.json` (launch uses `./node_modules/.bin/astro dev`).

## Development / build workflows (explicit)
- Install dependencies: `bun install` (project README prefers Bun); `npm`/`pnpm` work too.
- Run dev server: `bun run dev` (or `npm run dev`) → local server (default Astro port here is 4321 in the README).
- Build for production: `bun run build` (runs `astro check && astro build`).
- Preview build: `bun run preview`.

## PDF generation & printing
- There is a custom PDF workflow using Puppeteer in `/pdf`. Scripts:
  - `pdf/print.js` — puppeteer script that waits for mermaid diagrams, isolates main content and produces a PDF.
  - `pdf/generate-individual-pdfs.sh` and `pdf/generate-combined-pdf.sh` — helper shells that call `node print.js <url> <output>`.
- Note: `print.js` expects a renderable site. For local PDFs you can either:
  1) run the dev server (`bun run dev`), then change script URLs to `http://localhost:4321/...`, or
  2) run against the deployed site (project uses `https://cs362.alexulbrich.com/` by default).

## Data processing & grading scripts
- CSV and grade data live in `data/` and are processed by R-scripts in `scripts/`.
  - `scripts/calculate-peer-review-grade.R` reads Qualtrics CSVs, computes peer evaluation scores, and writes `data/CS_362_001_S2025_Peer_Review_Grades.csv` and merged gradebook CSV outputs.
  - Run: `Rscript scripts/calculate-peer-review-grade.R` from repo root (requires R + the listed R packages).

## Patterns / important conventions
- Content = MDX via Astro+Starlight; prefer placing new pages in the correct subfolder so Starlight’s `sidebar` autogeneration (set in `astro.config.mjs`) picks them up.
- When adding visual diagrams rely on Mermaid (configured in `astro.config.mjs`) and PDF scripts wait for `.mermaid` nodes to render.
- Keep PDF header/footer styling in `pdf/print.js` instead of in MDX pages (print script isolates content and injects header/footer templates).

## Debugging & local development tips
- If editors need a quick dev configuration, `.vscode/launch.json` contains a ready-to-run node-terminal config for the dev server.
- Puppeteer PDF issues are often rendering-timeouts — the `print.js` waits for mermaid SVGs and uses a 30s timeout; increase if diagrams are large.

## Integration points / deploy notes
- Vercel rewrites are configured in `vercel.json` (used for analytics/proxying plausible endpoints).
- No GitHub Actions found in the repo — CI may be handled elsewhere; prefer small, reversible changes.

## If you modify content or code
- When changing MDX frontmatter, follow `docsSchema()` shape from `src/content/config.ts`.
- For PDF or print changes, update `pdf/print.js` and re-run the shell scripts (`chmod +x pdf/*.sh` then run).
- For R scripts: ensure `data/` filenames match expected names in scripts or update the script accordingly.

If anything in the instructions above is unclear or incomplete, point me to a file or workflow you'd want added and I'll update this with precise steps. ✅
