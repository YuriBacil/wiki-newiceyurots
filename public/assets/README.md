# 🎨 Assets Visuais — IceYuriots Wiki

Este diretório contém as imagens customizadas que substituem os emojis/ícones padrão do site.

> **Como funciona o fallback:** se uma imagem não for encontrada, o site exibe automaticamente o emoji/ícone padrão. Você pode adicionar as imagens gradualmente, sem pressa.

---

## 📁 Estrutura de pastas

```
public/assets/
├── bestiary-tiers/     # Ícones dos tiers do Bestiário
├── item-tiers/         # Ícones dos tiers de Equipamentos
└── systems/            # Imagens das Mecânicas/Sistemas
```

---

## 🐾 Bestiário — `public/assets/bestiary-tiers/`

Use estes nomes exatos para cada imagem:

| Arquivo | Onde aparece |
|---------|--------------|
| `tier1.png` | Card "Tier 1 — Free" |
| `tier2.png` | Card "Tier 2 — City Collins" |
| `tier3.png` | Card "Tier 3 — Customs" (conteúdo em produção) |
| `tier4.png` | Card "Tier 4 — Pharaonic" (conteúdo em produção) |
| `bosses.png` | Card "Bosses — Desafios Épicos" |
| `all.png` | Card "Todos — Catálogo Completo" |

---

## ⚔️ Equipamentos — `public/assets/item-tiers/`

Use estes nomes exatos para cada imagem:

| Arquivo | Onde aparece |
|---------|--------------|
| `tier1.png` | Card "Tier 1 — Free" |
| `tier2.png` | Card "Tier 2 — City Collins" |
| `tier3.png` | Card "Tier 3 — Customs" (conteúdo em produção) |
| `tier4.png` | Card "Tier 4 — Pharaonic" (conteúdo em produção) |
| `all.png` | Card "Todos — Catálogo Completo" |

---

## ⚙️ Sistemas/Mecânicas — `public/assets/systems/`

Use estes nomes exatos para cada imagem (igual ao slug da URL):

| Arquivo | Sistema |
|---------|---------|
| `auto-loot.png` | Sistema de Auto Loot |
| `awakening-system.png` | Sistema de Awakening |
| `bless-iceyurots.png` | Sistema de Bênçãos |
| `boss-aegis.png` | Boss Aegis |
| `cassino-interativo.png` | Cassino Interativo |
| `castle-24hrs.png` | Castle 24h |
| `dodge-critical-system.png` | Sistema de Dodge e Critical |
| `exp-booster.png` | Sistema de Exp Booster |
| `food-especial.png` | Alimentos Especiais |
| `mining-system.png` | Sistema de Mineração |
| `new-promotion.png` | Sistema de Promoção de Classe |
| `pedra-evolucao.png` | Pedra de Evolução |
| `perk-system.png` | Sistema de Perks |
| `pet-system.png` | Sistema de Pets |
| `reset-system.png` | Sistema de Reset |

---

## 📐 Tamanhos recomendados

| Tipo de asset | Tamanho ideal | Observação |
|---------------|---------------|------------|
| Ícones de tier (bestiário/itens) | **128 × 128 px** | Ficam nítidos nos cards grandes e pequenos |
| Imagens de sistemas | **256 × 256 px** | Usadas nos cards de listagem e no hero do artigo |

> 💡 **Dica:** mantenha as imagens quadradas para melhor encaixe nos cards.

---

## 🖼️ Formatos aceitos

- **`.png`** — recomendado (qualidade e transparência)
- `.jpg` / `.jpeg` — aceito, mas sem transparência
- `.webp` — aceito, ótimo para compressão

> ⚠️ **Importante:** use o nome exato listado acima e a extensão escolhida. Se usar `.png`, o arquivo deve ser `.png`. Se preferir `.webp`, renomeie para `.webp` e o site vai aceitar.

---

## 🎨 Diretrizes visuais

Para manter a identidade visual do site:

- **Fundo transparente** é o ideal para ícones de tier e imagens de sistemas.
- Prefira uma **paleta escura com detalhes dourados** para combinar com o tema dark fantasy do IceYuriots.
- Evite textos muito pequenos nas imagens, pois elas são redimensionadas.
- Para os tiers, uma ilustração simbólica funciona melhor do que texto.

---

## ✅ Checklist para adicionar uma imagem

1. Escolha a pasta correta (`bestiary-tiers/`, `item-tiers/` ou `systems/`).
2. Salve com o **nome exato** indicado na tabela.
3. Use o **tamanho recomendado**.
4. Prefira **fundo transparente** (PNG).
5. Recarregue a página para ver o resultado.

> Se algo não aparecer, verifique se o nome do arquivo está exatamente igual ao da tabela (incluindo hífens e letras minúsculas).
