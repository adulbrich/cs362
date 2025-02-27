# Course Name

This template:

- uses Astro Starlight to organize course materials
- uses ExpressiveCode for code snippets
- uses Tailwind for styling
- has a Latex and a Mermaid components for Latex and flowcharts respectively
- integrates with Plausible Analytics
- supports Svelte islands for reactivity
- is configured to be deployed on Vercel
- has scripts to generate PDFs for the different pages
- hides flowcharts when printing (to be improved)

Search for `TODO` to find things that needs editing.

## PDFs

To generate the documentation in PDF format, use [starlight-to-pdf](https://github.com/Linkerin/starlight-to-pdf).

Here's the command to generate one large PDF.

```bash
npx starlight-to-pdf <TODO site url> --footer ./footer.html --header ./header.html --filename <TODO file name> --no-contents --margins '2cm 1cm 2cm 1cm'
```

To generate lecture notes in separate files (one per page), use the corresponding bash script:

```bash
chmod +x ./pdf/generate-lecture-notes.sh
./pdf/generate-lecture-notes.sh
```

## 🚀 Project Structure

Inside of your Astro + Starlight project, you'll see the following folders and files:

```text
.
├── public/
├── src/
│   ├── assets/
│   ├── content/
│   │   ├── docs/
│   │   └── config.ts
│   └── env.d.ts
├── astro.config.mjs
├── package.json
├── tailwind.config.mjs
└── tsconfig.json
```

## 🧞 Commands

All commands are run from the root of the project, from a terminal:

| Command                   | Action                                           |
| :------------------------ | :----------------------------------------------- |
| `bun install`             | Installs dependencies                            |
| `bun run dev`             | Starts local dev server at `localhost:4321`      |
| `bun run build`           | Build your production site to `./dist/`          |
| `bun run preview`         | Preview your build locally, before deploying     |
| `bun run astro ...`       | Run CLI commands like `astro add`, `astro check` |
| `bun run astro -- --help` | Get help using the Astro CLI                     |

## Resources

Displaying Latex:

- [How to create an Astro LaTeX component](https://danidiaztech.com/create-astro-latex-component/)
- [KaTeX: The fastest math typesetting library for the web.](https://katex.org/)
