export interface ItemDrop {
  monster: string;
  chance: number;
}

export interface EquipmentItem {
  id: number;
  name: string;
  normalizedName?: string;
  tier: string;
  category: string;
  id860?: number;
  id10?: number;
  attributes?: string;
  drops?: ItemDrop[];
}

export interface MonsterLoot {
  name: string;
  chance: number;
  countmax?: number;
  itemid: number;
}

export interface Monster {
  id: number;
  name: string;
  tier: string;
  hp: number;
  xp: number;
  speed?: number;
  looktype?: number;
  levelRange?: string;
  levelMin?: number;
  levelMax?: number;
  minDano?: number;
  maxDano?: number;
  mageHp?: string;
  pallyHp?: string;
  knightHp?: string;
  zone?: string;
  physicalDamage?: string;
  magicDamage?: string;
  loot?: MonsterLoot[];
}

export interface Mechanic {
  slug: string;
  title: string;
  summary: string;
  content: string;
  icon: string;
  category: string;
  image?: string;
}
