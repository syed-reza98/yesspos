<?php
header('Content-Type: text/plain');
$zip = new ZipArchive;
if ($zip->open('standalone_bundle.zip') === TRUE) {
    $zip->extractTo(__DIR__);
    $zip->close();
    echo "Extracted successfully\n";
    @unlink('standalone_bundle.zip');
} else {
    echo "Failed to open zip\n";
}
@unlink('unpacker.php');
@unlink('update_db.php');
@touch('tmp/restart.txt');
?>
