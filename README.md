# IceYuriots Wiki

Wiki oficial estática do servidor **IceYuriots OT** (Baiak 8.60 / TFS 1.5).

Acesso livre, sem login, sem banco de dados. Construída com [Astro](https://astro.build) e hospedada gratuitamente na [Vercel](https://vercel.com).

## O que está incluído

- **Home** — navegação rápida e patch notes
- **Bestiário** — 58 monstros com HP, XP, dano proporcional e drops
- **Equipamentos** — 240 itens com atributos e fontes de drops
- **Sistemas Custom** — Pets, Mineração, Upgrades e Alimentos
- **Lore** — crônicas e história do servidor

## Tecnologias

- Astro 7 (geração estática)
- Tailwind CSS 4
- Dados em JSON (sem banco de dados)
- Sprites locais de itens e monstros

## Como rodar localmente

```bash
npm install
npm run dev
```

Acesse `http://localhost:4321`.

## Como fazer deploy na Vercel (grátis)

1. Crie um repositório no GitHub com essa pasta (`web-wiki`).
2. Acesse [vercel.com](https://vercel.com) e faça login com GitHub.
3. Clique em **Add New Project** → importe o repositório.
4. Mantenha as configurações padrão:
   - **Framework Preset:** Astro
   - **Build Command:** `npm run build`
   - **Output Directory:** `dist`
5. Clique em **Deploy**.

Pronto! O Vercel gera um link como `https://seu-projeto.vercel.app`.

## Como atualizar os dados

Os dados da wiki estão em `src/data/` como arquivos JSON:

- `monsters.json`
- `items.json`
- `systems.json`
- `patchNotes.json`
- `lores.json`

Você pode editá-los manualmente ou regenerá-los a partir do dump SQL do site antigo:

```bash
node scripts/extract-data.js
```

> O script lê `../db/web_dump_import.sql` e gera os JSONs atualizados.

## Estrutura do projeto

```
web-wiki/
├── public/              # Sprites de itens e monstros
├── scripts/             # Scripts de extração de dados
├── src/
│   ├── components/      # Cards, badges, inputs
│   ├── data/            # JSONs da wiki
│   ├── layouts/         # Layout base
│   ├── lib/             # Helpers de imagem
│   ├── pages/           # Páginas do site
│   └── styles/          # Tailwind e estilos globais
├── astro.config.mjs
├── package.json
└── README.md
```

## Licença

© 2026 IceYuriots OT. Todos os direitos reservados.
