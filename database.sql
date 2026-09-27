CREATE TABLE IF NOT EXISTS `nametag_system` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `player_id` INT NOT NULL,
    `nametag_text` VARCHAR(255) NOT NULL,
    `nametag_color` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO `nametag_system` (`player_id`, `nametag_text`, `nametag_color`) VALUES
(1, 'Player 1', '255,255,255');