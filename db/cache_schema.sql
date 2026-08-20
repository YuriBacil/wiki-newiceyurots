-- Script SQL adicional para suporte a cache de ranking (Fase 3)
-- Armazena o resultado em formato JSON do ranking "Top XP Hoje" gerado de tempos em tempos.

CREATE TABLE IF NOT EXISTS `web_cache_stats` (
    `cache_key` VARCHAR(50) PRIMARY KEY,
    `cache_value` LONGTEXT NOT NULL,
    `updated_at` INT UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
