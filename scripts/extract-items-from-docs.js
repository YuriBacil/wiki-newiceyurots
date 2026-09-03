import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const DOCS_DIR = fs.existsSync(path.resolve(__dirname, '../../IceYuriots OT - TFS 1.5/docs/itens tiers'))
  ? path.resolve(__dirname, '../../IceYuriots OT - TFS 1.5/docs/itens tiers')
  : 'Y:/Desktop/Pessoal/Projetos/Projeto de Jogo/OT Tibia/Compartilhado/IceYuriots OT - TFS 1.5/docs/itens tiers';

const OUT_PATH = path.resolve(__dirname, '../src/data/equipment.json');

function normalizeName(name) {
  return name
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9]/g, '');
}

function parseNumber(value) {
  if (!value || value === '—' || value === '-' || value === '') return 0;
  const cleaned = String(value).replace(/\./g, '').replace(/,/g, '.').trim();
  const num = Number(cleaned);
  return isNaN(num) ? 0 : num;
}

function parseChance(val) {
  if (!val) return 0;
  const cleaned = String(val).replace(',', '.').trim();
  const num = parseFloat(cleaned);
  return isNaN(num) ? 0 : num;
}

function parseDrops(dropStr) {
  if (!dropStr) return [];
  const drops = [];
  const regex = /([^,]+?)\s*\(([\d.,]+)%\)/g;
  let match;
  while ((match = regex.exec(dropStr)) !== null) {
    const monster = match[1].trim();
    const chance = parseChance(match[2]);
    if (
      monster &&
      !monster.toLowerCase().includes('nenhum mob') &&
      !monster.toLowerCase().includes('quest') &&
      !monster.toLowerCase().includes('a ser definido')
    ) {
      drops.push({ monster, chance });
    }
  }
  return drops;
}

function mapCategory(raw) {
  const c = raw.toLowerCase();
  if (c.includes('spellbook')) return 'Spellbook';
  if (c.includes('shield')) return 'Shield';
  if (c.includes('armor')) return 'Armor';
  if (c.includes('helmet')) return 'Helmet';
  if (c.includes('boot')) return 'Boots';
  if (c.includes('leg')) return 'Legs';
  if (c.includes('axe')) return 'Axe';
  if (c.includes('sword')) return 'Sword';
  if (c.includes('club')) return 'Club';
  if (c.includes('arrow') || c.includes('bolt')) return 'Arrow & Bolt';
  if (c.includes('spear') || c.includes('distance')) return 'Spear';
  if (c.includes('bow') || c.includes('crossbow')) return 'Bow & Crossbow';
  if (c.includes('rod') || c.includes('wand')) return 'Rod & Wand';
  return raw;
}

function parseItemsDoc(content, tier) {
  const lines = content.split('\n');
  const items = [];
  let currentCategory = 'Geral';
  let currentItem = null;

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i].trim();

    // Section category header
    if (line.startsWith('## ') && !line.includes('Ajustes')) {
      const catMatch = line.match(/^##\s+(?:[^\s]+\s+)?(.+)/);
      if (catMatch) {
        currentCategory = mapCategory(catMatch[1].trim());
      }
      continue;
    }

    // Item header
    if (line.startsWith('### ')) {
      if (currentItem && currentItem.id > 0) {
        items.push(currentItem);
        currentItem = null;
      }

      const nameMatch = line.match(/^###\s+\*\*([^*]+)\*\*/);
      if (nameMatch) {
        const name = nameMatch[1].trim();
        currentItem = {
          id: 0,
          name,
          normalizedName: normalizeName(name),
          tier,
          category: currentCategory,
          id860: 0,
          id10: 0,
          attributes: '',
          drops: []
        };
      }
      continue;
    }

    if (!currentItem) continue;

    if (line.startsWith('- **ID')) {
      const id860Match = line.match(/ID(?:\s*8\.60)?:\*\*\s*(\d+)/i);
      const id10Match = line.match(/ID\s*10(?:\.0\+)?:\*\*\s*(\d+)/i);

      if (id860Match) currentItem.id860 = Number(id860Match[1]);
      if (id10Match) currentItem.id10 = Number(id10Match[1]);
      currentItem.id = currentItem.id860 || currentItem.id10 || 0;
    } else if (line.startsWith('- **Atributos:**')) {
      currentItem.attributes = line.replace('- **Atributos:**', '').trim();
    } else if (line.startsWith('- **Drops:**')) {
      const dropStr = line.replace('- **Drops:**', '').trim();
      currentItem.drops = parseDrops(dropStr);
    }
  }

  if (currentItem && currentItem.id > 0) {
    items.push(currentItem);
  }

  return items;
}

function main() {
  console.log('Lendo documentos de itens em:', DOCS_DIR);

  if (!fs.existsSync(DOCS_DIR)) {
    console.error('Diretório de documentos não encontrado:', DOCS_DIR);
    process.exit(1);
  }

  const files = fs
    .readdirSync(DOCS_DIR)
    .filter((f) => f.startsWith('item_tier') && f.endsWith('.md'))
    .sort();

  console.log(`Encontrados ${files.length} arquivos de tiers:`, files);

  const allItems = [];
  const tierStats = {};

  for (const f of files) {
    const tierMatch = f.match(/item_(tier\d+)/i);
    const tier = tierMatch ? tierMatch[1].toLowerCase() : 'tier1';
    const content = fs.readFileSync(path.join(DOCS_DIR, f), 'utf-8');
    const items = parseItemsDoc(content, tier);
    tierStats[tier] = items.length;
    allItems.push(...items);
  }

  fs.mkdirSync(path.dirname(OUT_PATH), { recursive: true });
  fs.writeFileSync(OUT_PATH, JSON.stringify(allItems, null, 2));

  console.log(`\n✅ ${allItems.length} itens de equipamento extraídos com sucesso!`);
  for (const [tier, count] of Object.entries(tierStats)) {
    console.log(`   ${tier}: ${count} itens`);
  }

  const categories = {};
  for (const item of allItems) {
    categories[item.category] = (categories[item.category] || 0) + 1;
  }
  console.log('   Categorias:', categories);

  // Sincronizar items.json
  const ITEMS_JSON_PATH = path.resolve(__dirname, '../src/data/items.json');
  if (fs.existsSync(ITEMS_JSON_PATH)) {
    console.log('\nSincronizando src/data/items.json...');
    const items = JSON.parse(fs.readFileSync(ITEMS_JSON_PATH, 'utf-8'));
    const itemsMap = new Map();
    for (const it of items) {
      itemsMap.set(it.id, it);
    }
    let updatedCount = 0;
    for (const eq of allItems) {
      if (itemsMap.has(eq.id)) {
        const target = itemsMap.get(eq.id);
        target.tier = eq.tier;
        target.category = eq.category;
        target.id860 = eq.id860;
        target.id10 = eq.id10;
        target.attributesDesc = eq.attributes;
        if (eq.drops && eq.drops.length > 0) {
          target.drops = eq.drops.map((d, i) => ({
            id: (target.drops && target.drops[i] && target.drops[i].id) || 100000 + i,
            itemId: eq.id,
            monster: d.monster,
            chance: String(d.chance),
          }));
        } else {
          target.drops = [];
        }
        updatedCount++;
      } else {
        const newItem = {
          id: eq.id,
          name: eq.name,
          attack: 0,
          defense: 0,
          armor: 0,
          weight: 0,
          slot: eq.category,
          description: '',
          tier: eq.tier,
          category: eq.category,
          id860: eq.id860,
          id10: eq.id10,
          attributesDesc: eq.attributes,
          drops: (eq.drops || []).map((d, i) => ({
            id: 100000 + i,
            itemId: eq.id,
            monster: d.monster,
            chance: String(d.chance),
          })),
        };
        items.push(newItem);
        itemsMap.set(eq.id, newItem);
        updatedCount++;
      }
    }
    fs.writeFileSync(ITEMS_JSON_PATH, JSON.stringify(items, null, 2));
    console.log(`✅ ${updatedCount} itens sincronizados em items.json.`);
  }
}

main();
