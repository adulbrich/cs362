# CS 362: Software Engineering II

This repository contains the source code for the CS362 website.

> What should we have students be doing so that they become way more competent software engineers by the end of this course?

Future Improvements (post-Spring 2025):

- [ ] Slow down during classtime to allow students to write code at the same time
- [ ] Consider a flip classroom approach for the course
- [ ] Shuffle lecture order to match assignments better
  - space out the different types of testing (unit, integration, e2e)
  - add coverage in between unit and integration testing
- [ ] Add a section in CI/CD on [act](https://github.com/nektos/act) to run GitHub Actions locally for testing purposes
- [ ] Figure out how to deploy from a branch instead of GH Actions (because of risk of running out of minutes)
- [ ] Add a lecture on Docker and containerization (before CI/CD, so that it can be used for playwright containers and act)
- [ ] Mention monorepos with examples
- [ ] Explain the different types of documentation
- [ ] Discuss cost-analysis frameworks, open-source vs proprietary
- [ ] Add in-class examples for property-based testing
- [ ] Add in-class examples for reliability testing
- [ ] Find a less time-consuming way to grade project demos
- [ ] Cover DevTools a little more for debugging purposes (networking, application, storage, console)
- [ ] Fix team formation schedule (due date for joining a team vs deadline for being assigned randomly based on form submission)
- [ ] Replace mermaid component with starlight plugin

## Instructor Checklist

Every term:

- [ ] Update the version of this repository if making changes (`package.json`)
- [ ] Add TAs to Canvas
- [ ] Create team **Bookings** page for assignment demo and set up slots (**not working**, creating individual pages instead)
- [ ] Update Bookings link in Canvas
- [ ] Create **GitHub Classroom** class and add TAs
- [ ] Update GitHub Classroom link in Canvas
- [ ] Create form for random team assignment for final project and add to Canvas

## PDFs

Note: For some reason [starlight-to-pdf](https://github.com/Linkerin/starlight-to-pdf) does not properly render Mermaid diagrams even after the various updates. Switching to custom build.

To generate lecture notes, assignments, and practicalities, in separate files (one per web page), use the following bash script:

```shell
chmod +x ./pdf/generate-individual-pdfs.sh
./pdf/generate-individual-pdfs.sh
```

To generate one PDF with all lecture notes, assignments, and practicalities, use the following command:

```shell
chmod +x ./pdf/generate-combined-pdf.sh
./pdf/generate-combined-pdf.sh
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
- [How to create an Astro LaTeX component](https://danidiaztech.com/create-astro-latex-component/) -- LaTeX component
- [KaTeX: The fastest math typesetting library for the web.](https://katex.org/) -- LaTeX component
- [Mermaid User Guide](https://mermaid.js.org/intro/getting-started.html) -- Mermaid component
