-- Script SQL para criar a tabela de Tickets de Suporte do Painel do Site
-- Conectar e rodar no banco de dados do site (theforgottenserver_web)

CREATE TABLE IF NOT EXISTS `web_tickets` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `account_id` INT NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `category` VARCHAR(50) NOT NULL, -- Bug, Report, Financeiro, Outros
    `description` TEXT NOT NULL,
    `status` VARCHAR(20) DEFAULT 'Aberto', -- Aberto, Em Atendimento, Resolvido, Fechado
    `reply` TEXT DEFAULT NULL,
    `replied_by` INT DEFAULT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT `fk_tickets_account` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
