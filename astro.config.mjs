// @ts-check
import { defineConfig } from "astro/config";
import sitemap from "@astrojs/sitemap";
import starlight from "@astrojs/starlight";
import tailwind from "@astrojs/tailwind";

import svelte from "@astrojs/svelte";

// https://astro.build/config
export default defineConfig({
  site: "https://TODO.com",
  integrations: [
    sitemap(),
    starlight({
      title: "TODO",
      social: {
        github: "https://TODO.github.com",
      },
      head: [
        {
          tag: "script",
          attrs: {
            src: "/knowledge/js/script.outbound-links.js",
            "data-api": "/knowledge/api/event",
            "data-domain": "TODO",
            defer: true,
          },
        },
      ],
      // TODO
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
          label: "Studios",
          autogenerate: { directory: "studios" },
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
      customCss: ["./src/tailwind.css"],
    }),
    tailwind({ applyBaseStyles: false }),
    svelte(),
  ],
});
