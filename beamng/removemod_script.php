<?php
// Assurez-vous que cette API est sécurisée et accessible uniquement aux utilisateurs autorisés
if ($_SERVER["REQUEST_METHOD"] == "POST" && !empty($_POST["ModChemin"])) {
    $ModChemin = escapeshellarg($_POST["ModChemin"]); // Sécurisation de l'entrée

    // Chemin vers le script shell sur le serveur
    $scriptPath = "scripts/removemod_script.sh";

    // Construction de la commande
    $command = $scriptPath . " " . $ModChemin;

    // Exécution du script shell
    $output = shell_exec($command);

    // Envoi de la sortie du script au client
    echo $output;
} else {
    // Gestion des erreurs ou accès non autorisé
    http_response_code(400); // Bad Request
    echo "Requête invalide";
}
?>
