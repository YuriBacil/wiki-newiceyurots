import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const rootDir = path.resolve(__dirname, '..');

function ensureDir(dir) {
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }
}

function buildMonsterNames() {
  const monstersPath = path.join(rootDir, 'src', 'data', 'monsters.json');
  const outputDir = path.join(rootDir, 'public', 'data');
  const outputPath = path.join(outputDir, 'monster-names.json');

  ensureDir(outputDir);

  const monsters = JSON.parse(fs.readFileSync(monstersPath, 'utf-8'));
  const names = monsters.map((m) => m.name).sort((a, b) => a.localeCompare(b));

  fs.writeFileSync(outputPath, JSON.stringify(names));
  console.log(`Generated ${outputPath} with ${names.length} monster names`);
}

buildMonsterNames();
