import fs from 'fs';
import path from 'path';

const DUMP_PATH = path.resolve('./db/web_dump_import.sql');
const OUT_DIR = path.resolve('src/data');

function readDump() {
  return fs.readFileSync(DUMP_PATH, 'utf-8');
}

function parseSqlValue(raw) {
  const trimmed = raw.trim();
  if (trimmed === 'NULL') return null;
  if (trimmed.startsWith("'") && trimmed.endsWith("'")) {
    return trimmed.slice(1, -1).replace(/''/g, "'").replace(/\\'/g, "'");
  }
  if (trimmed === 'true' || trimmed === 'false') return trimmed === 'true';
  if (!isNaN(Number(trimmed)) && trimmed !== '') return Number(trimmed);
  return trimmed;
}

function splitValues(row) {
  const values = [];
  let current = '';
  let inString = false;
  let escape = false;

  for (let i = 0; i < row.length; i++) {
    const char = row[i];

    if (escape) {
      current += char;
      escape = false;
      continue;
    }

    if (char === '\\') {
      current += char;
      escape = true;
      continue;
    }

    if (char === "'") {
      inString = !inString;
      current += char;
      continue;
    }

    if (char === ',' && !inString) {
      values.push(parseSqlValue(current));
      current = '';
      continue;
    }

    current += char;
  }

  if (current.length > 0) {
    values.push(parseSqlValue(current));
  }

  return values;
}

function extractInserts(sql, tableName) {
  const rows = [];
  const pattern = 'INSERT INTO `' + tableName + '` VALUES ';
  const regex = new RegExp(pattern.replace(/[.*+?^${}()|[\]\\]/g, '\\$&') + '\\((.*?)\\);', 'gs');
  let match;

  while ((match = regex.exec(sql)) !== null) {
    const block = match[1];
    // Cada conjunto de valores está entre parênteses
    const rowMatches = block.matchAll(/\(([^]*?)\)(?=,\s*\(|$)/g);
    for (const rm of rowMatches) {
      rows.push(splitValues(rm[1]));
    }
  }

  return rows;
}

function extractSystems(sql) {
  const rows = [];
  const prefix = 'INSERT INTO `web_systems` VALUES ';
  let pos = 0;

  while (true) {
    const start = sql.indexOf(prefix, pos);
    if (start === -1) break;

    let i = start + prefix.length;
    // Encontra o final do statement respeitando strings
    let inString = false;
    let escape = false;
    let statementStart = i;

    for (; i < sql.length; i++) {
      const char = sql[i];

      if (escape) {
        escape = false;
        continue;
      }

      if (char === '\\') {
        escape = true;
        continue;
      }

      if (char === "'") {
        inString = !inString;
        continue;
      }

      if (!inString && char === ';') {
        break;
      }
    }

    const statement = sql.slice(statementStart, i);
    pos = i + 1;

    // Extrai cada row manualmente respeitando strings e parênteses
    let current = '';
    let depth = 0;
    inString = false;
    escape = false;
    const valuesList = [];

    for (let j = 0; j < statement.length; j++) {
      const char = statement[j];

      if (escape) {
        current += char;
        escape = false;
        continue;
      }

      if (char === '\\') {
        current += char;
        escape = true;
        continue;
      }

      if (char === "'") {
        inString = !inString;
        current += char;
        continue;
      }

      if (!inString) {
        if (char === '(') {
          depth++;
          if (depth === 1) {
            current = '';
            continue;
          }
        } else if (char === ')') {
          depth--;
          if (depth === 0) {
            valuesList.push(current);
            current = '';
            continue;
          }
        } else if (char === ',' && depth === 0) {
          continue;
        }
      }

      current += char;
    }

    for (const rowStr of valuesList) {
      const vals = splitValues(rowStr);
      let configRaw = vals[3] ?? '{}';
      // Unescape SQL string para JSON válido
      configRaw = configRaw
        .replace(/\\"/g, '"')
        .replace(/\\u/g, '\\u')
        .replace(/\\\\/g, '\\');
      let config = {};
      try {
        config = JSON.parse(configRaw);
      } catch (e) {
        console.warn(`Erro ao parsear config da categoria ${vals[0]}:`, e.message);
      }
      rows.push({
        category: vals[0],
        name: vals[1],
        description: vals[2] ?? '',
        config,
      });
    }
  }

  return rows;
}

const ITEMS_XML_PATH = 'Y:/Desktop/Pessoal/Projetos/Projeto de Jogo/OT Tibia/Compartilhado/IceYuriots OT - TFS 1.5/data/items/items.xml';

function extractItemsFromXml() {
  if (!fs.existsSync(ITEMS_XML_PATH)) return new Map();
  const content = fs.readFileSync(ITEMS_XML_PATH, 'utf-8');
  const map = new Map();
  const regex = /<item\s+(?:id="(\d+)"|fromid="(\d+)"\s+toid="(\d+)")\s+[^>]*name="([^"]+)"/g;
  let match;
  while ((match = regex.exec(content)) !== null) {
    const id = match[1] ? Number(match[1]) : Number(match[2]);
    const toId = match[3] ? Number(match[3]) : id;
    const name = match[4];
    for (let i = id; i <= toId; i++) {
      if (!map.has(i)) map.set(i, name);
    }
  }
  return map;
}

function extractItems(sql) {
  const rows = extractInserts(sql, 'web_items');
  const xmlItems = extractItemsFromXml();
  const byId = new Map();

  for (const r of rows) {
    byId.set(r[0], {
      id: r[0],
      name: r[1],
      attack: r[2] ?? 0,
      defense: r[3] ?? 0,
      armor: r[4] ?? 0,
      weight: r[5] ?? 0,
      slot: r[6] ?? 'Equipamento',
      description: r[7] ?? '',
      tier: r[8] ?? 'tier1',
      category: r[9] ?? 'all',
      id860: r[10] ?? 0,
      id10: r[11] ?? 0,
      attributesDesc: r[12] ?? '',
    });
  }

  // Merge XML items not present in SQL
  for (const [id, name] of xmlItems) {
    if (!byId.has(id)) {
      byId.set(id, {
        id,
        name,
        attack: 0,
        defense: 0,
        armor: 0,
        weight: 0,
        slot: 'Equipamento',
        description: '',
        tier: 'tier1',
        category: 'all',
        id860: 0,
        id10: 0,
        attributesDesc: '',
      });
    }
  }

  return Array.from(byId.values());
}

function extractMonsters(sql) {
  const rows = extractInserts(sql, 'web_monsters');
  return rows.map(r => ({
    id: r[0],
    name: r[1],
    tier: r[2] ?? 'tier1',
    hp: r[3] ?? 0,
    xp: r[4] ?? 0,
    speed: r[5] ?? 0,
    looktype: r[6] ?? 0,
    levelRange: r[7] ?? '',
    maxDano: r[8] ?? '',
    mageHp: r[9] ?? '',
    pallyHp: r[10] ?? '',
    knightHp: r[11] ?? '',
  }));
}

function extractMonsterLoot(sql) {
  const rows = extractInserts(sql, 'web_monster_loot');
  return rows.map(r => ({
    id: r[0],
    monsterId: r[1],
    itemid: r[2],
    name: r[3] ?? '',
    chance: r[4] ?? 0,
    countmax: r[5] ?? 1,
  }));
}

function extractItemDrops(sql) {
  const rows = extractInserts(sql, 'web_item_drops');
  return rows.map(r => ({
    id: r[0],
    itemId: r[1],
    monster: r[2] ?? '',
    chance: r[3] ?? '',
  }));
}



function main() {
  console.log('Lendo dump SQL...');
  const sql = readDump();

  console.log('Extraindo itens...');
  const items = extractItems(sql);

  console.log('Extraindo monstros...');
  const monsters = extractMonsters(sql);

  console.log('Extraindo loot dos monstros...');
  const monsterLoot = extractMonsterLoot(sql);

  console.log('Extraindo drops dos itens...');
  const itemDrops = extractItemDrops(sql);

  console.log('Extraindo sistemas custom...');
  const systems = extractSystems(sql);

  // Enriquecer monstros com loot
  const lootByMonster = {};
  for (const loot of monsterLoot) {
    if (!lootByMonster[loot.monsterId]) lootByMonster[loot.monsterId] = [];
    lootByMonster[loot.monsterId].push(loot);
  }

  for (const m of monsters) {
    m.loot = lootByMonster[m.id] || [];
  }

  // Enriquecer itens com drops
  const dropsByItem = {};
  for (const drop of itemDrops) {
    if (!dropsByItem[drop.itemId]) dropsByItem[drop.itemId] = [];
    dropsByItem[drop.itemId].push(drop);
  }

  for (const item of items) {
    item.drops = dropsByItem[item.id] || [];
  }

  fs.mkdirSync(OUT_DIR, { recursive: true });

  fs.writeFileSync(path.join(OUT_DIR, 'items.json'), JSON.stringify(items, null, 2));
  fs.writeFileSync(path.join(OUT_DIR, 'monsters.json'), JSON.stringify(monsters, null, 2));
  fs.writeFileSync(path.join(OUT_DIR, 'systems.json'), JSON.stringify(systems, null, 2));

  // Patch notes manuais (do index.html original)
  const patchNotes = [
    {
      title: 'Update 1.2: Balanceamento e Perks',
      date: '30 Jun, 2026',
      content: 'Ajustado o cooldown dos especiais de cura e rebalanceamento da chance máxima de Dodge para Knights (50%) e outras vocações (40%). Adicionado sistema de perks.'
    },
    {
      title: 'Correção de Bugs Críticos',
      date: '22 Jun, 2026',
      content: 'Resolvidos problemas no salvamento do JSON do sistema de perks. Corrigido bug de duplicação de itens ao morrer em arenas não-PVP.'
    },
    {
      title: 'Inauguração do Servidor',
      date: '15 Jun, 2026',
      content: 'Abertura oficial do IceYuriots OT! Mapa Baiak totalmente remasterizado, novos sistemas exclusivos e jogabilidade retro-moderna.'
    }
  ];
  fs.writeFileSync(path.join(OUT_DIR, 'patchNotes.json'), JSON.stringify(patchNotes, null, 2));

  // Lore inicial
  const lores = [
    {
      id: 1,
      title: 'Capítulo I: O Despertar de IceYurots',
      content: 'No início das eras, quando o gelo dominava as terras do norte de Tibia, os antigos Elite Knights forjaram alianças com magos elementares para fundar o templo de IceYurots.'
    },
    {
      id: 2,
      title: 'Capítulo II: A Lenda da Golden Falcon',
      content: 'Diz a profecia que apenas o guerreiro que acumular frags suficientes nas arenas PVP será digno de empunhar a lendária Golden Falcon.'
    }
  ];
  fs.writeFileSync(path.join(OUT_DIR, 'lores.json'), JSON.stringify(lores, null, 2));

  console.log('\n✅ Extração concluída!');
  console.log(`  - ${items.length} itens`);
  console.log(`  - ${monsters.length} monstros`);
  console.log(`  - ${monsterLoot.length} registros de loot`);
  console.log(`  - ${itemDrops.length} registros de drops`);
  console.log(`  - ${systems.length} sistemas custom`);
}

main();
