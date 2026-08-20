import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const DOCS_DIR = 'Y:/Desktop/Pessoal/Projetos/Projeto de Jogo/OT Tibia/Compartilhado/IceYuriots OT - TFS 1.5/docs/itens tiers';
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

function parseDrops(dropStr) {
  if (!dropStr) return [];
  const drops = [];
  // Match: "Mob Name (12.5%)" or "Mob Name (0.2%)"
  const regex = /([^,]+?)\s*\(([\d.]+)%\)/g;
  let match;
  while ((match = regex.exec(dropStr)) !== null) {
    const monster = match[1].trim();
    const chance = parseNumber(match[2]);
    if (monster && !monster.toLowerCase().includes('nenhum mob') && !monster.toLowerCase().includes('quest')) {
      drops.push({ monster, chance });
    }
  }
  return drops;
}

function parseCategory(line) {
  // ## 📚 Spellbook -> Spellbook
  const match = line.match(/##\s*(?:[^\s]+\s+)?(.+)/);
  if (!match) return 'Geral';
  const raw = match[1].trim();
  if (raw.toLowerCase().includes('arrow')) return 'Arrow & Bolt';
  if (raw.toLowerCase().includes('bolt')) return 'Arrow & Bolt';
  if (raw.toLowerCase().includes('spear')) return 'Spear';
  return raw;
}

function parseItemsFromDoc(content, tier) {
  const items = [];
  const lines = content.split('\n');
  let currentCategory = 'Geral';

  for (const rawLine of lines) {
    const line = rawLine.trim();
    if (line.startsWith('##')) {
      currentCategory = parseCategory(line);
      continue;
    }
    if (!line.startsWith('|') || line.includes('---') || line.includes('Item')) {
      continue;
    }

    const cells = line
      .split('|')
      .map(c => c.trim())
      .filter(c => c.length > 0);

    if (cells.length < 4) continue;

    const nameRaw = cells[0].replace(/\*\*/g, '').trim();
    const id860 = parseNumber(cells[1]);
    const id10 = parseNumber(cells[2]);
    const attributes = cells[3] || '';
    const dropsRaw = cells[4] || '';

    if (!nameRaw || id860 === 0 && id10 === 0) continue;

    items.push({
      id: id860 || id10,
      name: nameRaw,
      normalizedName: normalizeName(nameRaw),
      tier,
      category: currentCategory,
      id860,
      id10,
      attributes,
      drops: parseDrops(dropsRaw),
    });
  }

  return items;
}

function main() {
  console.log('Lendo documentos de itens...');

  const tier1Content = fs.readFileSync(path.join(DOCS_DIR, 'item_tier1.md'), 'utf-8');
  const tier2Content = fs.readFileSync(path.join(DOCS_DIR, 'item_tier2.md'), 'utf-8');

  const tier1 = parseItemsFromDoc(tier1Content, 'tier1');
  const tier2 = parseItemsFromDoc(tier2Content, 'tier2');

  const allItems = [...tier1, ...tier2];

  fs.mkdirSync(path.dirname(OUT_PATH), { recursive: true });
  fs.writeFileSync(OUT_PATH, JSON.stringify(allItems, null, 2));

  console.log(`✅ ${allItems.length} itens de equipamento extraídos.`);
  console.log(`   Tier 1: ${tier1.length}`);
  console.log(`   Tier 2: ${tier2.length}`);

  const categories = {};
  for (const item of allItems) {
    categories[item.category] = (categories[item.category] || 0) + 1;
  }
  console.log('   Categorias:', categories);
}

main();
