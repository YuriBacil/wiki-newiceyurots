export function getMonsterSpriteUrl(name: string): string {
  const cleanName = name.toLowerCase().replace(/[^a-z0-9]/g, '');
  return `/monsters/${cleanName}.gif`;
}

export function getItemSpriteUrl(itemId: number): string {
  return `/items/${itemId}.png`;
}

export function handleBrokenImage(img: HTMLImageElement): void {
  img.src = 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="1" height="1"></svg>';
  img.style.opacity = '0';
}
