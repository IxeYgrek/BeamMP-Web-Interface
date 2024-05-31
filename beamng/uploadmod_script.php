<?php
header('Content-Type: application/json');

// Définir le répertoire de téléchargement
$targetDir = __DIR__ . "/TEMP/";
if (!is_dir($targetDir)) {
    mkdir($targetDir, 0777, true);
}

// Vérifier si les fichiers sont bien téléchargés
if (!isset($_FILES["modImage"]) || !isset($_FILES["modFile"])) {
    echo json_encode(['message' => 'Les fichiers nécessaires ne sont pas présents.']);
    exit;
}

// Variables pour stocker les chemins complets des fichiers dans le répertoire cible
$modImage = $targetDir . basename($_FILES["modImage"]["name"]);
$modTrack = !empty($_FILES["modTrack"]["name"]) ? $targetDir . basename($_FILES["modTrack"]["name"]) : "";
$modFile = $targetDir . basename($_FILES["modFile"]["name"]);

// Déplacer les fichiers uploadés depuis leur emplacement temporaire vers le répertoire cible
if (move_uploaded_file($_FILES["modImage"]["tmp_name"], $modImage) &&
    (empty($_FILES["modTrack"]["name"]) || move_uploaded_file($_FILES["modTrack"]["tmp_name"], $modTrack)) &&
    move_uploaded_file($_FILES["modFile"]["tmp_name"], $modFile)) {

    // Récupérer les autres données du formulaire
    $modName = $_POST["modName"];
    $modDescription = $_POST["modDescription"];
    $modType = $_POST["modType"];
    $idBeamng = $_POST["mapId"]; // Nouvelle variable pour l'ID BeamNG

    // Préparer les variables pour le script shell
    $variables = [
        'modname' => $modName,
        'moddescription' => $modDescription,
        'modtype' => $modType,
        'modimage' => basename($modImage),
        'modpreview' => basename($modTrack),
        'modzip' => basename($modFile),
        'idbeamng' => $idBeamng // Ajout de l'ID BeamNG
    ];

    // Exemple de commande shell (à adapter)
    $shellCommand = "sh scripts/uploadmod_script.sh " . escapeshellarg($modName) . " " . escapeshellarg($modDescription) . " " . escapeshellarg($modType) . " " . escapeshellarg(basename($modImage)) . " " . escapeshellarg(basename($modTrack)) . " " . escapeshellarg(basename($modFile)) . " " . escapeshellarg($idBeamng);
    shell_exec($shellCommand);

    echo json_encode(['message' => 'Le MOD a été téléchargé avec succès.']);
} else {
    echo json_encode(['message' => 'Une erreur s\'est produite lors du téléchargement des fichiers.']);
}
?>
