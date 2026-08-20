-- Script SQL para o sistema de Comunidade (Mini-Reddit)
-- Integrado com a tabela `accounts` já existente no banco de dados do OTserv.

-- Tabela de posts/tópicos criados pelos usuários
CREATE TABLE IF NOT EXISTS `web_community_posts` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `account_id` INT NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `content` TEXT NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT `fk_posts_account` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela de votos (Upvotes / Downvotes) para controle de relevância e ordenação por entropia/score
CREATE TABLE IF NOT EXISTS `web_community_votes` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `post_id` INT NOT NULL,
    `account_id` INT NOT NULL,
    `vote_type` TINYINT NOT NULL, -- 1 para Upvote, -1 para Downvote
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `unique_user_post_vote` (`post_id`, `account_id`),
    CONSTRAINT `fk_votes_post` FOREIGN KEY (`post_id`) REFERENCES `web_community_posts` (`id`) ON DELETE CASCADE,
    CONSTRAINT `fk_votes_account` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
