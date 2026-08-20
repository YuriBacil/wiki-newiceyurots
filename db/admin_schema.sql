-- Script SQL para atualizar a tabela accounts ou criar a coluna de hierarquia/web_group se não existir.
-- Padrão TFS: O banco de dados do Tibia já possui a coluna `type` na tabela `accounts` (1 = player, 2 = tutor, 3 = senior tutor, 4 = GM, 5 = CM, 6 = God).
-- Para não mexer na estrutura nativa do jogo e evitar conflitos de segurança, leremos diretamente o `type` da conta no login.
-- Alternativamente, criamos uma coluna customizada `web_group` para gerenciar as permissões exclusivas do site/painel.

ALTER TABLE `accounts` ADD COLUMN IF NOT EXISTS `web_group` INT DEFAULT 1; 
-- 1 = Player Comum
-- 2 = Moderador (Pode deletar posts e banir tópicos na comunidade)
-- 3 = Administrador/GOD (Pode cadastrar Lores, gerenciar moderadores e posts)

-- Criar a tabela para armazenar as lores dinamicamente no banco
CREATE TABLE IF NOT EXISTS `web_lores` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(255) NOT NULL,
    `content` TEXT NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Inserir lores iniciais como fallback
INSERT INTO `web_lores` (`title`, `content`) VALUES 
('Capítulo I: O Despertar de IceYurots', 'No início das eras, quando o gelo dominava as terras do norte de Tibia, os antigos Elite Knights forjaram alianças com magos elementares para fundar o templo de IceYurots.'),
('Capítulo II: A Lenda da Golden Falcon', 'Diz a profecia que apenas o guerreiro que acumular frags suficientes nas arenas PVP será digno de empunhar a lendária Golden Falcon.');
