import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const DOCS_DIR = 'Y:/Desktop/Pessoal/Projetos/Projeto de Jogo/OT Tibia/Compartilhado/IceYuriots OT - TFS 1.5/docs/monsters tiers';
const MONSTER_XML_DIR = 'Y:/Desktop/Pessoal/Projetos/Projeto de Jogo/OT Tibia/Compartilhado/IceYuriots OT - TFS 1.5/data/monster';
const ITEMS_PATH = path.resolve(__dirname, '../src/data/items.json');
const OUT_PATH = path.resolve(__dirname, '../src/data/monsters.json');

function loadItemsLookup() {
  if (!fs.existsSync(ITEMS_PATH)) return new Map();
  const items = JSON.parse(fs.readFileSync(ITEMS_PATH, 'utf-8'));
  const map = new Map();
  for (const item of items) {
    const normalized = normalizeName(item.name);
    if (!map.has(normalized)) {
      map.set(normalized, item.id);
    }
  }
  // Common aliases
  map.set('gold', 2148);
  map.set('platinum', 2152);
  map.set('goldcoin', 2148);
  map.set('platinumcoin', 2152);
  map.set('goldcoins', 2148);
  map.set('platinumcoins', 2152);
  return map;
}

function normalizeName(name) {
  return name
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9]/g, '');
}

function parseNumber(value) {
  if (!value || value === '—' || value === '-') return 0;
  const cleaned = String(value).replace(/\./g, '').replace(/,/g, '.').trim();
  const num = Number(cleaned);
  return isNaN(num) ? 0 : num;
}

function parseDamageRange(damageStr) {
  if (!damageStr || damageStr === '—' || damageStr === '-') return { min: 0, max: 0 };
  const cleaned = damageStr.replace(/\./g, '').replace(/,/g, '.').trim();
  // Match ranges like "440–1.540" or "0–1.045" or single values
  const dashMatch = cleaned.match(/^([\d.]+)\s*[–—-]\s*([\d.]+)$/);
  if (dashMatch) {
    return { min: Number(dashMatch[1]), max: Number(dashMatch[2]) };
  }
  const single = Number(cleaned);
  if (!isNaN(single)) return { min: single, max: single };
  return { min: 0, max: 0 };
}

function parseLevelRange(levelStr) {
  if (!levelStr) return { min: 0, max: 0, text: '' };
  // "150 ao 500" or "10k ao 10.5k"
  const text = levelStr.trim();
  const cleaned = text
    .replace(/k/g, '000')
    .replace(/\./g, '')
    .replace(/,/g, '.')
    .replace(/\s+/g, ' ');
  const match = cleaned.match(/(\d+(?:\.\d+)?)\s*ao\s*(\d+(?:\.\d+)?)/i);
  if (match) {
    return { min: Number(match[1]), max: Number(match[2]), text };
  }
  const single = Number(cleaned);
  if (!isNaN(single)) return { min: single, max: single, text };
  return { min: 0, max: 0, text };
}

const ITEMS_LOOKUP = loadItemsLookup();

function resolveItemId(name) {
  const normalized = normalizeName(name);
  if (ITEMS_LOOKUP.has(normalized)) return ITEMS_LOOKUP.get(normalized);
  // Try without plural
  if (normalized.endsWith('s') && ITEMS_LOOKUP.has(normalized.slice(0, -1))) {
    return ITEMS_LOOKUP.get(normalized.slice(0, -1));
  }
  return 0;
}

function parseLoot(lootStr) {
  if (!lootStr) return [];
  const items = [];
  // Split by commas that are not inside parentheses
  const parts = lootStr.split(',').map(p => p.trim()).filter(Boolean);
  for (const part of parts) {
    // Match: "gold coin (max 8): 30.0%" or "wooden shield: 15.0%"
    const match = part.match(/^(.+?)\s*(?:\(max\s+(\d+)\))?\s*:\s*([\d.]+)%$/);
    if (match) {
      const name = match[1].trim();
      const countmax = match[2] ? Number(match[2]) : 1;
      const chance = Number(match[3]);
      items.push({
        name,
        chance,
        countmax,
        itemid: resolveItemId(name),
      });
    }
  }
  return items;
}

function parseMarkdownTable(content, tier, defaultZone) {
  const monsters = [];
  const lines = content.split('\n');
  let currentZone = defaultZone;
  let currentLevelRange = { min: 0, max: 0, text: '' };

  for (const rawLine of lines) {
    const line = rawLine.trim();

    // Detect zone/andar headers and extract recommended level range
    if (line.startsWith('###') || line.startsWith('##')) {
      const zoneMatch = line.match(/ZONA?\s*(\d+)|(\d+)[º°]?\s*Andar/i);
      if (zoneMatch) {
        currentZone = zoneMatch[1] || zoneMatch[2] || defaultZone;
      }
      const levelMatch = line.match(/Level\s+Recomendado:\s*([\d.k\s.,–—-]+(?:ao[\d.k\s.,–—-]+)?)/i);
      if (levelMatch) {
        currentLevelRange = parseLevelRange(levelMatch[1]);
      }
      continue;
    }

    if (!line.startsWith('|') || line.includes('---') || line.includes('Monstro') || line.includes('Criatura')) {
      continue;
    }

    const cells = line
      .split('|')
      .map(c => c.trim())
      .filter(c => c.length > 0);

    if (cells.length < 7) continue;

    let nameRaw, hpRaw, xpRaw, physicalRaw, magicRaw, maxDanoRaw, lootRaw;

    if (tier === 'tier1') {
      // Tier 1: Monstro | Faixa Level | HP | XP | Dano Físico | Dano Mágico | Dano Máx Total | Loot
      nameRaw = cells[0];
      hpRaw = cells[2];
      xpRaw = cells[3];
      physicalRaw = cells[4];
      magicRaw = cells[5];
      maxDanoRaw = cells[6];
      lootRaw = cells[7] || '';
    } else {
      // Tier 2: # | Criatura | HP | XP | Dano Físico | Dano Mágico | Dano Máx Total | Loot
      nameRaw = cells[1];
      hpRaw = cells[2];
      xpRaw = cells[3];
      physicalRaw = cells[4];
      magicRaw = cells[5];
      maxDanoRaw = cells[6];
      lootRaw = cells[7] || '';
    }

    nameRaw = nameRaw.replace(/\*\*/g, '').trim();
    if (!nameRaw) continue;

    const physicalRange = parseDamageRange(physicalRaw);
    const levelRange = tier === 'tier1' ? parseLevelRange(cells[1]) : currentLevelRange;

    monsters.push({
      name: nameRaw,
      normalizedName: normalizeName(nameRaw),
      tier,
      zone: String(currentZone),
      levelRange: levelRange.text,
      levelMin: levelRange.min,
      levelMax: levelRange.max,
      hp: parseNumber(hpRaw),
      xp: parseNumber(xpRaw),
      physicalDamage: physicalRaw,
      magicDamage: magicRaw,
      minDano: physicalRange.min,
      maxDano: parseNumber(maxDanoRaw) || physicalRange.max,
      loot: parseLoot(lootRaw),
    });
  }

  return monsters;
}

function findMonsterXml(name, normalizedName) {
  if (!fs.existsSync(MONSTER_XML_DIR)) return null;
  const files = fs.readdirSync(MONSTER_XML_DIR);

  // Try exact normalized match
  const exact = files.find(f => normalizeName(path.parse(f).name) === normalizedName);
  if (exact) return path.join(MONSTER_XML_DIR, exact);

  // Try contains
  const contains = files.find(f => {
    const base = normalizeName(path.parse(f).name);
    return base.includes(normalizedName) || normalizedName.includes(base);
  });
  if (contains) return path.join(MONSTER_XML_DIR, contains);

  return null;
}

function extractXmlData(xmlPath) {
  if (!xmlPath || !fs.existsSync(xmlPath)) return { speed: 0, looktype: 0 };
  const content = fs.readFileSync(xmlPath, 'utf-8');
  const speedMatch = content.match(/speed="(\d+)"/);
  const lookMatch = content.match(/<look[^>]*type="(\d+)"/);
  return {
    speed: speedMatch ? Number(speedMatch[1]) : 0,
    looktype: lookMatch ? Number(lookMatch[1]) : 0,
  };
}

function main() {
  console.log('Lendo documentos de tiers...');

  const tier1Content = fs.readFileSync(path.join(DOCS_DIR, 'monstros_tier1.md'), 'utf-8');
  const tier2Content = fs.readFileSync(path.join(DOCS_DIR, 'monstros_tier2.md'), 'utf-8');

  const tier1 = parseMarkdownTable(tier1Content, 'tier1', '1');
  const tier2 = parseMarkdownTable(tier2Content, 'tier2', '1');

  let allMonsters = [...tier1, ...tier2];

  // Add boss placeholder
  allMonsters.push({
    name: 'Aegis',
    normalizedName: 'aegis',
    tier: 'bosses',
    zone: 'Boss',
    levelRange: '100.000+',
    levelMin: 100000,
    levelMax: 100000,
    hp: 100000,
    xp: 0,
    physicalDamage: '',
    magicDamage: '',
    minDano: 0,
    maxDano: 0,
    loot: [],
  });

  // Enrich with XML data
  allMonsters = allMonsters.map((m, index) => {
    const xmlPath = findMonsterXml(m.name, m.normalizedName);
    const xmlData = extractXmlData(xmlPath);
    return {
      id: index + 1,
      name: m.name,
      tier: m.tier,
      hp: m.hp,
      xp: m.xp,
      speed: xmlData.speed,
      looktype: xmlData.looktype,
      levelRange: m.levelRange,
      levelMin: m.levelMin,
      levelMax: m.levelMax,
      minDano: m.minDano,
      maxDano: m.maxDano,
      mageHp: '',
      pallyHp: '',
      knightHp: '',
      zone: m.zone,
      physicalDamage: m.physicalDamage,
      magicDamage: m.magicDamage,
      loot: m.loot,
    };
  });

  fs.mkdirSync(path.dirname(OUT_PATH), { recursive: true });
  fs.writeFileSync(OUT_PATH, JSON.stringify(allMonsters, null, 2));

  console.log(`✅ ${allMonsters.length} monstros extraídos.`);
  console.log(`   Tier 1: ${tier1.length}`);
  console.log(`   Tier 2: ${tier2.length}`);
  console.log(`   Bosses: 1`);
}

main();
