<?php
header('Content-Type: text/plain');
$conn = new mysqli('localhost', 'yessban2_syed', 'oushodhwala2026', 'yessban2_yesspos');
if ($conn->connect_error) {
    die('Connect Error: ' . $conn->connect_error);
}

$queries = [
    "ALTER TABLE media_assets MODIFY file_path TEXT NULL",
    "ALTER TABLE media_assets ADD COLUMN IF NOT EXISTS path TEXT NULL AFTER name",
    "ALTER TABLE media_assets ADD COLUMN IF NOT EXISTS url TEXT NULL AFTER path",
    "ALTER TABLE media_assets ADD COLUMN IF NOT EXISTS folder VARCHAR(100) DEFAULT 'general' AFTER file_size",
    "ALTER TABLE media_assets ADD COLUMN IF NOT EXISTS mime_type VARCHAR(100) NULL AFTER alt_text",
    "ALTER TABLE media_assets ADD COLUMN IF NOT EXISTS size_bytes INT NULL AFTER mime_type",
    "ALTER TABLE media_assets ADD COLUMN IF NOT EXISTS tags JSON NULL AFTER size_bytes",
    "ALTER TABLE media_assets ADD COLUMN IF NOT EXISTS width INT NULL AFTER tags",
    "ALTER TABLE media_assets ADD COLUMN IF NOT EXISTS height INT NULL AFTER width",
    "ALTER TABLE media_assets ADD COLUMN IF NOT EXISTS variants JSON NULL AFTER height",
    "ALTER TABLE media_assets ADD COLUMN IF NOT EXISTS uploaded_by VARCHAR(36) NULL AFTER variants",
    "ALTER TABLE media_assets ADD COLUMN IF NOT EXISTS deleted_at TIMESTAMP NULL AFTER uploaded_by",
    "ALTER TABLE media_assets ADD COLUMN IF NOT EXISTS deleted_by VARCHAR(36) NULL AFTER deleted_at",
    "ALTER TABLE media_assets ADD COLUMN IF NOT EXISTS deleted_usage JSON NULL AFTER deleted_by",
    "ALTER TABLE media_assets ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER created_at",
    "ALTER TABLE user_carts MODIFY customer_phone VARCHAR(30) NULL",
    "ALTER TABLE user_carts MODIFY items LONGTEXT NULL",
    "ALTER TABLE user_carts ADD COLUMN IF NOT EXISTS user_id VARCHAR(36) NULL AFTER id",
    "ALTER TABLE user_carts ADD COLUMN IF NOT EXISTS `lines` JSON NULL AFTER user_id"
];

foreach ($queries as $q) {
    if ($conn->query($q)) {
        echo "SUCCESS: " . substr($q, 0, 45) . "...\n";
    } else {
        echo "NOTE: " . $conn->error . "\n";
    }
}

$conn->close();
@unlink(__FILE__);
?>
