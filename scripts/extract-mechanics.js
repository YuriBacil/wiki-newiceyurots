import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const docsDir = fs.existsSync(path.resolve(__dirname, '../../IceYuriots OT - TFS 1.5/docs/mecanicas'))
  ? path.resolve(__dirname, '../../IceYuriots OT - TFS 1.5/docs/mecanicas')
  : 'Y:/Desktop/Pessoal/Projetos/Projeto de Jogo/OT Tibia/Compartilhado/IceYuriots OT - TFS 1.5/docs/mecanicas';
const outputPath = path.join(__dirname, '..', 'src', 'data', 'mechanics.json');

const categoryMap = {
  'auto_loot': 'Economia e Qualidade de Vida',
  'awakening_system': 'Progressão de Equipamento',
  'bless_iceyurots': 'Proteção e Sobrevivência',
  'boss_aegis': 'End-Game e Raids',
  'cassino_interativo': 'Economia e Entretenimento',
  'castle_24hrs': 'Guilda e PvP',
  'dodge_critical_system': 'Combate',
  'exp_booster': 'Progressão',
  'food_especial': 'Combate e Suporte',
  'mining_system': 'Atividades e Coleta',
  'new_promotion': 'Progressão de Classe',
  'pedra_evolucao': 'Progressão de Equipamento',
  'perk_system': 'Progressão',
  'pet_system': 'Companheiros',
  'reset_system': 'Progressão'
};

const iconMap = {
  'auto_loot': '🎒',
  'awakening_system': '⚔️',
  'bless_iceyurots': '🕊️',
  'boss_aegis': '🛡️',
  'cassino_interativo': '🎰',
  'castle_24hrs': '🏰',
  'dodge_critical_system': '🎯',
  'exp_booster': '⚡',
  'food_especial': '🍖',
  'mining_system': '⛏️',
  'new_promotion': '🎭',
  'pedra_evolucao': '💎',
  'perk_system': '🧠',
  'pet_system': '🐾',
  'reset_system': '🔄'
};

function toSlug(filename) {
  return filename
    .replace(/\.md$/, '')
    .toLowerCase()
    .replace(/_/g, '-')
    .replace(/\s+/g, '-');
}

function extractTitle(content) {
  const match = content.match(/^#\s+(.+)$/m);
  return match ? match[1].trim() : '';
}

function extractSummary(content) {
  // Remove the title line
  const withoutTitle = content.replace(/^#\s+.+$/m, '').trim();
  // Remove horizontal rules and empty lines at the start
  const cleaned = withoutTitle.replace(/^(---\s*\n?)+/, '').trim();
  // Find first paragraph (non-empty, not starting with #, not ---)
  const lines = cleaned.split('\n');
  let summaryLines = [];
  for (const line of lines) {
    const trimmed = line.trim();
    if (!trimmed || trimmed === '---' || trimmed.startsWith('#')) continue;
    if (trimmed.startsWith('>')) continue;
    summaryLines.push(trimmed);
    break;
  }
  const summary = summaryLines.join(' ');
  // Remove markdown bold markers
  return summary.replace(/\*\*/g, '').trim();
}

function processFile(filename) {
  const filePath = path.join(docsDir, filename);
  const content = fs.readFileSync(filePath, 'utf-8');
  const key = filename.replace(/\.md$/, '');

  return {
    id: key,
    slug: toSlug(filename),
    title: extractTitle(content),
    summary: extractSummary(content),
    content: content,
    icon: iconMap[key] || '✦',
    image: key,
    category: categoryMap[key] || 'Sistemas'
  };
}

const files = fs.readdirSync(docsDir)
  .filter(f => f.endsWith('.md'))
  .sort();

const mechanics = files.map(processFile);

fs.mkdirSync(path.dirname(outputPath), { recursive: true });
fs.writeFileSync(outputPath, JSON.stringify(mechanics, null, 2), 'utf-8');

console.log(`✅ Extraídas ${mechanics.length} mecânicas para ${outputPath}`);
mechanics.forEach(m => console.log(`  • ${m.title} (${m.slug}) - ${m.category}`));
