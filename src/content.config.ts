import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const updatesCollection = defineCollection({
  loader: glob({ pattern: '**/[^_]*.md', base: "./src/content/updates" }),
  schema: z.object({
    title: z.string(),
    date: z.coerce.date(),
    tag: z.enum(['Novidades', 'Balanceamento', 'Correções', 'Geral']),
    description: z.string(),
  }),
});

export const collections = {
  updates: updatesCollection,
};
