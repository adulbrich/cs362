# CS 362: Software Engineering II

This repository contains the source code for the CS362 website.

## Instructor Checklist

Every term:

- [ ] Update the version of this repository if making changes (`package.json`)
- [x] Add TAs to Canvas
- [x] Create team **Bookings** page for assignment demo and set up slots: not working, creating individual pages instead
- [x] Update Bookings link in Canvas
- [x] Create **GitHub Classroom** class and add TAs
- [x] Update GitHub Classroom link in Canvas
- [x] Create form for random team assignment for final project and add to Canvas
- [ ] Review project code and complete assignment using vitest and playwright (optionally, use something else than SvelteKit)
- [x] Check feasibility of project demo (time-wise): about 12 hours in final's week
- [x] Use mermaid for flow charts and git flows
- [ ] Use `bun` for everything (incl. running an http server locally)
- [ ] additional topics to cover
  - [ ] maintenance
  - [ ] git pre-commit hooks
  - [ ] feature flags
  - [ ] chaos engineering
  - [ ] system performance and reliability
  - [ ] technical debt
  - [ ] ...

## PDFs

To generate the documentation in PDF format, use [starlight-to-pdf](https://github.com/Linkerin/starlight-to-pdf).

Here's the command to generate one large PDF.

```bash
npx starlight-to-pdf https://cs362.alexulbrich.com --footer ./footer.html --header ./header.html --filename cs362.pdf --no-contents --margins '2cm 1cm 2cm 1cm'
```

To generate lecture notes in separate files (one per page), use the corresponding bash script:

```shell
chmod +x ./pdf/generate-lecture-notes.sh
./pdf/generate-lecture-notes.sh
```

To generate slides from marp, use:

```shell
cd slides
npx @marp-team/marp-cli@latest intro.md --pdf --allow-local-files
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

- [Starlight Getting Started](https://starlight.astro.build/getting-started/) -- Astro template
- [TailwindCSS](https://tailwindcss.com/) -- for styling
- [Svelte](https://svelte.dev/docs/svelte/overview) -- for reactive components
- [How to create an Astro LaTeX component](https://danidiaztech.com/create-astro-latex-component/) -- LaTeX component
- [KaTeX: The fastest math typesetting library for the web.](https://katex.org/) -- LaTeX component
- [Adding Mermaid diagrams to Astro MDX](https://xkonti.tech/blog/astro-mermaid-mdx/) -- Mermaid component
- [Mermaid User Guide](https://mermaid.js.org/intro/getting-started.html) -- Mermaid component
