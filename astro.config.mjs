// @ts-check
import { defineConfig } from "astro/config";
import sitemap from "@astrojs/sitemap";
import starlight from "@astrojs/starlight";
import tailwindcss from "@tailwindcss/vite";
import mermaid from 'astro-mermaid';

// https://astro.build/config
export default defineConfig({
  vite: {
    plugins: [tailwindcss()],
  },
  site: "https://cs362.alexulbrich.com/",
  integrations: [
    mermaid({
      theme: 'dark',
      autoTheme: true
    }),
    sitemap(),
    starlight({
      title: "CS 362 Software Engineering II",
      social: [
        {
          icon: "github",
          label: "GitHub",
          href: "https://github.com/adulbrich/cs362",
      },],
      head: [
        {
          tag: "script",
          attrs: {
            src: "/knowledge/js/script.outbound-links.js",
            "data-api": "/knowledge/api/event",
            "data-domain": "cs362.alexulbrich.com",
            defer: true,
          },
        },
      ],
      sidebar: [
        {
          label: "Overview",
          autogenerate: { directory: "overview" },
        },
        {
          label: "Practicalities",
          autogenerate: { directory: "practicalities" },
        },
        {
          label: "Lecture Notes",
          autogenerate: { directory: "lectures" },
        },
        {
          label: "Assignments",
          autogenerate: { directory: "assignments" },
        },
        {
          label: "About",
          autogenerate: { directory: "about" },
        },
      ],
      customCss: ["./src/styles/global.css"],
    }),
  ],
});
