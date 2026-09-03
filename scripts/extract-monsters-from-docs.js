import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const DOCS_DIR = fs.existsSync(path.resolve(__dirname, '../../IceYuriots OT - TFS 1.5/docs/monsters tiers'))
  ? path.resolve(__dirname, '../../IceYuriots OT - TFS 1.5/docs/monsters tiers')
  : 'Y:/Desktop/Pessoal/Projetos/Projeto de Jogo/OT Tibia/Compartilhado/IceYuriots OT - TFS 1.5/docs/monsters tiers';

const MONSTER_XML_DIR = fs.existsSync(path.resolve(__dirname, '../../IceYuriots OT - TFS 1.5/data/monster'))
  ? path.resolve(__dirname, '../../IceYuriots OT - TFS 1.5/data/monster')
  : 'Y:/Desktop/Pessoal/Projetos/Projeto de Jogo/OT Tibia/Compartilhado/IceYuriots OT - TFS 1.5/data/monster';

const ITEMS_PATH = path.resolve(__dirname, '../src/data/items.json');
const OUT_PATH = path.resolve(__dirname, '../src/data/monsters.json');

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

function parseDamageRange(damageStr) {
  if (!damageStr || damageStr === '—' || damageStr === '-') return { min: 0, max: 0 };
  const cleaned = damageStr.replace(/\./g, '').replace(/,/g, '.').trim();
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

function loadItemsLookup() {
  const map = new Map();
  if (fs.existsSync(ITEMS_PATH)) {
    const items = JSON.parse(fs.readFileSync(ITEMS_PATH, 'utf-8'));
    for (const item of items) {
      const normalized = normalizeName(item.name);
      if (!map.has(normalized)) {
        map.set(normalized, item.id);
      }
    }
  }
  // Common aliases
  map.set('gold', 2148);
  map.set('goldcoin', 2148);
  map.set('goldcoins', 2148);
  map.set('platinum', 2152);
  map.set('platinumcoin', 2152);
  map.set('platinumcoins', 2152);
  map.set('crystal', 2160);
  map.set('crystalcoin', 2160);
  map.set('crystalcoins', 2160);
  map.set('yoyo', 3982);
  map.set('crocodileboots', 3982);
  return map;
}

const ITEMS_LOOKUP = loadItemsLookup();

function resolveItemId(name) {
  const normalized = normalizeName(name);
  if (ITEMS_LOOKUP.has(normalized)) return ITEMS_LOOKUP.get(normalized);
  if (normalized.endsWith('s') && ITEMS_LOOKUP.has(normalized.slice(0, -1))) {
    return ITEMS_LOOKUP.get(normalized.slice(0, -1));
  }
  return 0;
}

function parseLoot(lootStr) {
  if (!lootStr) return [];
  const items = [];
  const parts = lootStr.split(',').map((p) => p.trim()).filter(Boolean);
  for (const part of parts) {
    const match = part.match(/^(.+?)\s*(?:\(max\s+(\d+)\))?\s*:\s*([\d.,]+)%$/i);
    if (match) {
      const name = match[1].trim();
      const countmax = match[2] ? Number(match[2]) : 1;
      const chance = parseFloat(match[3].replace(',', '.'));
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

function findMonsterXml(name, normalizedName) {
  if (!fs.existsSync(MONSTER_XML_DIR)) return null;
  const files = fs.readdirSync(MONSTER_XML_DIR);

  // Try exact match
  const exact = files.find((f) => normalizeName(path.parse(f).name) === normalizedName);
  if (exact) return path.join(MONSTER_XML_DIR, exact);

  // Try all words match (e.g. 'Frog (Orchid)' -> 'orchid frog.xml')
  const words = name
    .toLowerCase()
    .replace(/[^a-z0-9\s]/g, ' ')
    .split(/\s+/)
    .filter(Boolean);
  if (words.length > 0) {
    const wordsMatch = files.find((f) => {
      const fName = f.toLowerCase();
      return words.every((w) => fName.includes(w));
    });
    if (wordsMatch) return path.join(MONSTER_XML_DIR, wordsMatch);
  }

  // Try contains
  const contains = files.find((f) => {
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

function parseMonstersDoc(content, tier, defaultZone) {
  const lines = content.split('\n');
  const monsters = [];
  let currentZone = defaultZone;
  let currentZoneLevelRange = { min: 0, max: 0, text: '' };
  let currentMonster = null;

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i].trim();

    // Zone or Andar detection
    if (line.startsWith('## ') && !line.includes('Ajustes')) {
      const zoneMatch = line.match(/ZONA?\s*(\d+)|(\d+)[º°]?\s*Andar/i);
      if (zoneMatch) {
        currentZone = zoneMatch[1] || zoneMatch[2] || defaultZone;
      }
      const levelMatch = line.match(/Level(?:\s+Recomendado)?:\s*([^\)]+)/i);
      if (levelMatch) {
        currentZoneLevelRange = parseLevelRange(levelMatch[1]);
      }
      continue;
    }

    // Monster heading
    if (
      line.startsWith('### ') &&
      !line.includes('Balanceamento') &&
      !line.includes('Regras') &&
      !line.includes('Magia')
    ) {
      if (currentMonster && currentMonster.name) {
        monsters.push(currentMonster);
        currentMonster = null;
      }

      const nameMatch = line.match(/^###\s+\*\*([^*]+)\*\*/);
      if (nameMatch) {
        const name = nameMatch[1].trim();
        currentMonster = {
          name,
          normalizedName: normalizeName(name),
          tier,
          zone: String(currentZone),
          levelRange: currentZoneLevelRange.text,
          levelMin: currentZoneLevelRange.min,
          levelMax: currentZoneLevelRange.max,
          hp: 0,
          xp: 0,
          physicalDamage: '',
          magicDamage: '',
          minDano: 0,
          maxDano: 0,
          loot: [],
        };
      }
      continue;
    }

    if (!currentMonster) continue;

    if (line.startsWith('- **Faixa Level:**')) {
      const lr = parseLevelRange(line.replace('- **Faixa Level:**', '').trim());
      currentMonster.levelRange = lr.text;
      currentMonster.levelMin = lr.min;
      currentMonster.levelMax = lr.max;
    } else if (line.startsWith('- **HP:**')) {
      currentMonster.hp = parseNumber(line.replace('- **HP:**', '').trim());
    } else if (line.startsWith('- **XP:**')) {
      currentMonster.xp = parseNumber(line.replace('- **XP:**', '').trim());
    } else if (line.startsWith('- **Dano Físico (Melee):**')) {
      const dmg = line.replace('- **Dano Físico (Melee):**', '').trim();
      currentMonster.physicalDamage = dmg;
      const range = parseDamageRange(dmg);
      currentMonster.minDano = range.min;
      if (currentMonster.maxDano === 0) currentMonster.maxDano = range.max;
    } else if (line.startsWith('- **Dano Mágico/Habilidade:**')) {
      currentMonster.magicDamage = line.replace('- **Dano Mágico/Habilidade:**', '').trim();
    } else if (line.startsWith('- **Dano Máx Total:**')) {
      currentMonster.maxDano = parseNumber(line.replace('- **Dano Máx Total:**', '').trim());
    } else if (line.startsWith('- **Loot Pool:**') || line.startsWith('- **Loot:**')) {
      const lootStr = line.replace(/^- \*\*(?:Loot Pool|Loot):\*\*/, '').trim();
      currentMonster.loot = parseLoot(lootStr);
    }
  }

  if (currentMonster && currentMonster.name) {
    monsters.push(currentMonster);
  }

  return monsters;
}

function main() {
  console.log('Lendo documentos de monstros em:', DOCS_DIR);

  if (!fs.existsSync(DOCS_DIR)) {
    console.error('Diretório de documentos não encontrado:', DOCS_DIR);
    process.exit(1);
  }

  const files = fs
    .readdirSync(DOCS_DIR)
    .filter((f) => f.startsWith('monstros_tier') && f.endsWith('.md'))
    .sort();

  console.log(`Encontrados ${files.length} arquivos de tiers:`, files);

  let allMonsters = [];
  const tierStats = {};

  for (const f of files) {
    const tierMatch = f.match(/monstros_(tier\d+)/i);
    const tier = tierMatch ? tierMatch[1].toLowerCase() : 'tier1';
    const content = fs.readFileSync(path.join(DOCS_DIR, f), 'utf-8');
    const monsters = parseMonstersDoc(content, tier, '1');
    tierStats[tier] = monsters.length;
    allMonsters.push(...monsters);
  }

  // Boss Aegis
  const aegisXml = findMonsterXml('Aegis', 'aegis');
  const aegisXmlData = extractXmlData(aegisXml);
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
    physicalDamage: '260 melee',
    magicDamage: 'Lifedrain, Fire, Physical, Death',
    minDano: 200,
    maxDano: 1500,
    loot: [],
    speed: aegisXmlData.speed || 605,
    looktype: aegisXmlData.looktype || 287,
  });
  tierStats['bosses'] = 1;

  // Enrich with XML data and format
  allMonsters = allMonsters.map((m, index) => {
    const xmlPath = findMonsterXml(m.name, m.normalizedName);
    const xmlData = extractXmlData(xmlPath);
    return {
      id: index + 1,
      name: m.name,
      tier: m.tier,
      hp: m.hp,
      xp: m.xp,
      speed: m.speed || xmlData.speed,
      looktype: m.looktype || xmlData.looktype,
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

  console.log(`\n✅ ${allMonsters.length} monstros extraídos com sucesso!`);
  for (const [tier, count] of Object.entries(tierStats)) {
    console.log(`   ${tier}: ${count} monstros`);
  }
}

main();
