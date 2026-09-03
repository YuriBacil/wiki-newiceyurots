# Como Criar Novos Patch Notes Usando IA

Para criar um novo patch note, basta colar as atualizações brutas no chat de qualquer IA (ou nesta IA) junto com as seguintes instruções. 

---

## 📋 Instruções para a IA

> "Por favor, formate as seguintes notas de atualização do servidor IceYuriots OT em um arquivo Markdown do Astro de acordo com as regras abaixo:
>
> 1. **Cabeçalho (Frontmatter)**:
>    Deve conter os seguintes campos no formato YAML:
>    - `title`: Título do patch note (ex: "Update 1.3 - Novas Dungeons & Balanceamento").
>    - `date`: Data do update no formato `AAAA-MM-DD` (ex: `2026-08-23`).
>    - `tag`: Escolha a tag principal que melhor resume o patch:
>      - `"Novidades"` (novos sistemas, novas áreas, grandes atualizações)
>      - `"Balanceamento"` (ajustes de fórmulas, vocações, monstros, cooldowns)
>      - `"Correções"` (correções de bugs, crashes, erros de mapa)
>      - `"Geral"` (manutenções gerais, melhorias de infraestrutura)
>    - `description`: Um resumo curto de uma frase sobre as atualizações.
>
> 2. **Corpo do Texto (Markdown)**:
>    Use cabeçalhos Markdown e bullet points para organizar as mudanças de forma limpa. Adicione emojis adequados para cada categoria:
>    - `### 🟢 Adições & Novidades` (Para novos recursos/sistemas)
>    - `### ⚖️ Balanceamento` (Para mudanças de valores, XP, força)
>    - `### 🛠️ Correções de Bugs` (Para erros consertados)
>    - `### ⚙️ Outros / Gerais` (Outras modificações de menor impacto)
>
> 3. **Destaques Visuais**:
>    - Use negrito (`**texto**`) para destacar nomes de itens, monstros, feitiços ou vocações.
>    - Mantenha o tom profissional e direto.
>
> Exemplo de saída esperada:
> ```markdown
> ---
> title: "Update 1.3 - Sistema de Dungeons"
> date: 2026-08-23
> tag: "Novidades"
> description: "Nova masmorra desafiadora adicionada e ajustes na força dos monstros."
> ---
> 
> ### 🟢 Adições & Novidades
> - Nova Dungeon **Yalahar's Pit** adicionada para jogadores de level 150+.
> - Adicionado o item **Yalahari Armor** como recompensa rara do boss final.
> 
> ### ⚖️ Balanceamento
> - Reduzido o dano de ataque do boss **Grim Reaper** em **5%**.
> - Ajustada a XP da criatura **Dragon Lord** em **+8%**.
> 
> ### 🛠️ Correções de Bugs
> - Corrigido um bug onde o jogador podia atravessar a parede da arena de PvP.
> ```"
>
> **Aqui estão as minhas notas brutas do update:**
> [Cole as notas brutas aqui]

---

## 🚀 Como Publicar no Site

1. Copie o resultado gerado pela IA (incluindo as linhas `---` do início).
2. Vá na pasta do projeto: [src/content/updates/](file:///Y:/Desktop/Pessoal/Projetos/Projeto%20de%20Jogo/OT%20Tibia/Compartilhado/WebEcossistema/src/content/updates/)
3. Crie um arquivo com a data e o nome do update (exemplo: `2026-08-23-sistema-dungeons.md`).
4. Cole o texto, salve o arquivo e pronto! O site irá ler e atualizar automaticamente.
