-- =============================================================
-- SCHEMA EXCLUSIVO DO SITE / PAINEL WEB - IceYuriots OT
-- Este banco é 100% isolado do banco do jogo (theforgottenserver).
-- Todos os dados aqui são alimentados pelo importador (api/sync.php),
-- que lê o TFS e o banco do jogo e copia snapshots para cá.
-- Depois de importado, o site funciona SEM depender do servidor.
-- =============================================================

-- 1. Contas registradas no site (login + hierarquia)
CREATE TABLE IF NOT EXISTS `web_accounts` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(32) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `web_group` INT DEFAULT 1,
    `created` INT DEFAULT 0,
    UNIQUE KEY `uniq_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2. Itens da wiki (parsed do items.xml do TFS + docs de balanceamento)
CREATE TABLE IF NOT EXISTS `web_items` (
    `id` INT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `attack` INT DEFAULT 0,
    `defense` INT DEFAULT 0,
    `armor` INT DEFAULT 0,
    `weight` DECIMAL(10,2) DEFAULT 0,
    `slot` VARCHAR(50) DEFAULT 'Equipamento',
    `description` TEXT,
    `tier` VARCHAR(20) DEFAULT 'tier1',
    `category` VARCHAR(30) DEFAULT 'all',
    `id_860` INT DEFAULT 0,
    `id_10` INT DEFAULT 0,
    `attributes_desc` TEXT,
    KEY `idx_tier` (`tier`),
    KEY `idx_name` (`name`),
    KEY `idx_category` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3. Fontes de drop dos itens (parsed dos docs de balanceamento)
CREATE TABLE IF NOT EXISTS `web_item_drops` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `item_id` INT NOT NULL,
    `monster` VARCHAR(100) NOT NULL,
    `chance` VARCHAR(20) DEFAULT NULL,
    KEY `idx_item` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. Monstros da wiki (parsed do monsters.xml + docs de balanceamento)
CREATE TABLE IF NOT EXISTS `web_monsters` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `tier` VARCHAR(20) DEFAULT 'tier1',
    `hp` INT DEFAULT 0,
    `xp` BIGINT DEFAULT 0,
    `speed` INT DEFAULT 0,
    `looktype` INT DEFAULT 0,
    `level_range` VARCHAR(50) DEFAULT NULL,
    `max_dano` VARCHAR(50) DEFAULT NULL,
    `mage_hp` VARCHAR(20) DEFAULT NULL,
    `pally_hp` VARCHAR(20) DEFAULT NULL,
    `knight_hp` VARCHAR(20) DEFAULT NULL,
    KEY `idx_tier` (`tier`),
    KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. Loot table dos monstros
CREATE TABLE IF NOT EXISTS `web_monster_loot` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `monster_id` INT NOT NULL,
    `itemid` INT DEFAULT 0,
    `name` VARCHAR(100) DEFAULT NULL,
    `chance` DECIMAL(10,2) DEFAULT 0,
    `countmax` INT DEFAULT 1,
    KEY `idx_monster` (`monster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 6. Players (snapshot importado do banco do jogo)
CREATE TABLE IF NOT EXISTS `web_players` (
    `id` INT PRIMARY KEY,
    `account_id` INT DEFAULT 0,
    `name` VARCHAR(32) NOT NULL,
    `level` INT DEFAULT 1,
    `vocation` INT DEFAULT 0,
    `sex` INT DEFAULT 0,
    `group_id` INT DEFAULT 1,
    `online` INT DEFAULT 0,
    `experience` BIGINT DEFAULT 0,
    `maglevel` INT DEFAULT 0,
    `skill_fist` INT DEFAULT 10,
    `skill_club` INT DEFAULT 10,
    `skill_sword` INT DEFAULT 10,
    `skill_axe` INT DEFAULT 10,
    `skill_dist` INT DEFAULT 10,
    `skill_shielding` INT DEFAULT 10,
    `healthmax` INT DEFAULT 150,
    `manamax` INT DEFAULT 0,
    `balance` BIGINT DEFAULT 0,
    `lastlogin` INT DEFAULT 0,
    `resets` INT DEFAULT 0,
    `guild_name` VARCHAR(100) DEFAULT NULL,
    `guild_rank` VARCHAR(100) DEFAULT NULL,
    `account_created` INT DEFAULT 0,
    KEY `idx_name` (`name`),
    KEY `idx_level` (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 7. Equipamentos dos players (snapshot)
CREATE TABLE IF NOT EXISTS `web_player_items` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `player_id` INT NOT NULL,
    `pid` INT DEFAULT 0,
    `itemtype` INT DEFAULT 0,
    `count` INT DEFAULT 1,
    KEY `idx_player` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 8. Mortes dos players (snapshot)
CREATE TABLE IF NOT EXISTS `web_player_deaths` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `player_id` INT NOT NULL,
    `level` INT DEFAULT 0,
    `time` INT DEFAULT 0,
    `killed_by` VARCHAR(100) DEFAULT NULL,
    `is_player` INT DEFAULT 0,
    KEY `idx_player` (`player_id`),
    KEY `idx_killed_by` (`killed_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 9. Sistemas custom da wiki (pets, mineração, upgrades, alimentos) - config em JSON
CREATE TABLE IF NOT EXISTS `web_systems` (
    `category` VARCHAR(30) PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `description` TEXT,
    `config` JSON
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================
-- Tabelas originais do site (comunidade, lores, tickets, cache)
-- =============================================================
CREATE TABLE IF NOT EXISTS `web_community_posts` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `account_id` INT NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `content` TEXT NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `web_community_votes` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `post_id` INT NOT NULL,
    `account_id` INT NOT NULL,
    `vote_type` TINYINT NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `unique_user_post_vote` (`post_id`, `account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `web_community_comments` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `post_id` INT NOT NULL,
    `parent_id` INT DEFAULT NULL,
    `account_id` INT NOT NULL,
    `content` TEXT NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    KEY `idx_post` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `web_community_comment_votes` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `comment_id` INT NOT NULL,
    `account_id` INT NOT NULL,
    `vote_type` TINYINT NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `unique_user_comment_vote` (`comment_id`, `account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `web_lores` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(255) NOT NULL,
    `content` TEXT NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `web_tickets` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `account_id` INT NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `category` VARCHAR(50) NOT NULL,
    `description` TEXT NOT NULL,
    `status` VARCHAR(20) DEFAULT 'Aberto',
    `reply` TEXT DEFAULT NULL,
    `replied_by` INT DEFAULT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `web_cache_stats` (
    `cache_key` VARCHAR(50) PRIMARY KEY,
    `cache_value` LONGTEXT NOT NULL,
    `updated_at` INT UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;