<!DOCTYPE html>
<html lang="fr">
<head>
    <link rel="stylesheet" href="style.css">
    <meta charset="UTF-8">
    <title>Admin BeamNG</title>
</head>
<body>

    <?php
    // Lire le fichier de configuration
    $config = parse_ini_file('beamng/config');
    if ($config === false) {
        die("Erreur de lecture du fichier de configuration");
    }

    // Récupérer la langue de configuration
    $lang = $config['lang'];

    // Lire le fichier de langue
    $lang_file = parse_ini_file('beamng/lang');
    if ($lang_file === false) {
        die("Erreur de lecture du fichier de langue");
    }

    // Fonction pour obtenir la chaîne de langue
    function getLangString($key) {
        global $lang, $lang_file;
        $lang_key = $lang . '_' . $key;
        return isset($lang_file[$lang_key]) ? trim($lang_file[$lang_key], '"') : $key;
    }

    echo "<h1>" . getLangString('title') . "</h1>";

    function displaySection($title_key, $condition, $toggleable = false, $showSelectButton = true) {
        global $config, $lang, $lang_file;

        $servername = $config['servername'];
        $username = $config['username'];
        $password = $config['password'];
        $dbname = $config['dbname'];

        $title = getLangString($title_key);
        $conn = new mysqli($servername, $username, $password, $dbname);

        if ($conn->connect_error) {
            die("Échec de la connexion : " . $conn->connect_error);
        }

        $sql = "SELECT nom, image, chemin, preview, description, id_beamng, type, map_active, map_officielle, mod_actif FROM beamng_mod WHERE $condition";
        $result = $conn->query($sql);

        $sectionId = preg_replace('/\s+/', '', strtolower($title));

        echo "<section class='content-section'>";
        echo "<h2" . ($toggleable ? " style='cursor: pointer;' onclick='toggleSection(\"$sectionId\")'" : "") . ">$title " . ($toggleable ? "&#x25BC;" : "") . "</h2>";
        echo "<div id='$sectionId' class='content'" . ($toggleable ? " style='display: none;'" : "") . ">";

        if ($result->num_rows > 0) {
            while($row = $result->fetch_assoc()) {
                echo "<div class='map-entry'>";
                echo "<img src='" . htmlspecialchars($row["image"]) . "' alt='Image principale' class='left-image'>";
                echo "<div class='map-info'>";
                echo "<h3>" . htmlspecialchars($row["nom"]) . "</h3>";
                echo "<p>" . htmlspecialchars($row["description"]) . "</p>";

                if ($title_key == "mapavailableoff" && $showSelectButton) {
                    echo "<button type='button' class='select-button' onclick=\"executeScript('" . htmlspecialchars($row["id_beamng"]) . "')\">" . getLangString('selectmap') . "</button>";
                } elseif ($title_key == "mapavailablemod") {
                    echo "<button type='button' class='select-button' onclick=\"executeScript('" . htmlspecialchars($row["id_beamng"]) . "')\">" . getLangString('selectmap') . "</button>";
                    echo "<button type='button' class='delete-button' onclick=\"executeScriptRemoveMod('" . htmlspecialchars($row["chemin"]) . "')\">" . getLangString('delmod') . "</button>";
                } elseif ($title_key == "caravailable") {
                    echo "<button type='button' class='delete-button' onclick=\"executeScriptRemoveMod('" . htmlspecialchars($row["chemin"]) . "')\">" . getLangString('delmod') . "</button>";
                } elseif ($title_key == "featureavailable") {
                    echo "<button type='button' class='delete-button' onclick=\"executeScriptRemoveMod('" . htmlspecialchars($row["chemin"]) . "')\">" . getLangString('delmod') . "</button>";
                }

                echo "</div>";
                if (!empty($row["preview"])) {
                    echo "<img src='" . htmlspecialchars($row["preview"]) . "' alt='Preview' class='right-image'>";
                }
                echo "</div>";
                if ($title_key != "actual") {
                    echo "<hr>";
                }
                echo "<br>";
            }
        } else {
            echo getLangString('nocontent');
        }

        echo "</div></section>";
        $conn->close();
    }

    displaySection("actual", "map_active = 1", false, false);
    displaySection("mapavailableoff", "type = 'map' AND map_active != 1 AND map_officielle = 1", true);
    displaySection("mapavailablemod", "map_officielle = 0 AND type = 'map' AND map_active != 1", true);
    displaySection("caravailable", "type LIKE '%car%'", true);
    displaySection("featureavailable", "type LIKE '%mod%'", true);
    ?>

    <!-- Nouvelle section avec formulaire -->
    <section class='content-section'>
        <h2 style='cursor: pointer;' onclick='toggleSection("modFormSection")'><?php echo getLangString('addmod'); ?> &#x25BC;</h2>
        <div id='modFormSection' class='content' style='display: none;'>
            <form id="uploadForm" class="form-style" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="modName"><?php echo getLangString('modnamel'); ?>:</label>
                    <input type="text" id="modName" name="modName" required>
                </div>

                <div class="form-group">
                    <label for="modDescription"><?php echo getLangString('moddescriptionl'); ?>:</label>
                    <textarea id="modDescription" name="modDescription" required></textarea>
                </div>

                <div class="form-group">
                    <label for="modType"><?php echo getLangString('modtypel'); ?>:</label>
                    <select id="modType" name="modType" onchange="toggleMapField()">
                        <option value="map">Map</option>
                        <option value="car">Car</option>
                        <option value="mod">Mod</option>
                    </select>
                </div>

                <div id="mapIdField" class="form-group" style="display: none;">
                    <label for="mapId"><?php echo getLangString('mapidl'); ?>:</label>
                    <input type="text" id="mapId" name="mapId" required>
                </div>

                <div id="mapTrackField" class="form-group" style="display: none;">
                    <label for="modTrack"><?php echo getLangString('previewimagel'); ?>:</label>
                    <input type="file" id="modTrack" name="modTrack" accept=".jpg, .jpeg, .png">
                </div>

                <div class="form-group">
                    <label for="modImage"><?php echo getLangString('imagemodl'); ?>:</label>
                    <input type="file" id="modImage" name="modImage" accept=".jpg, .jpeg, .png" required>
                </div>

                <div class="form-group">
                    <label for="modFile"><?php echo getLangString('modfile'); ?>:</label>
                    <input type="file" id="modFile" name="modFile" accept=".zip" required>
                </div>

                <button type="submit"><?php echo getLangString('uploadbutton'); ?></button>
            </form>
            <!-- Barre de progression -->
            <progress id="uploadProgress" value="0" max="100" style="width: 100%; margin-top: 10px;"></progress>
            <div id="statusMessage" style="margin-top: 10px;"></div>
        </div>
    </section>

<!-- Bouton Mettre à jour -->
<button type='button' class='delete-button' onclick='updateServer()'><?php echo getLangString('updatebutton'); ?></button>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            toggleMapField();

            document.getElementById('uploadForm').addEventListener('submit', function(event) {
                event.preventDefault();
                var formData = new FormData(this);
                var xhr = new XMLHttpRequest();

                xhr.open('POST', 'beamng/uploadmod_script.php', true);

                xhr.upload.onprogress = function(event) {
                    if (event.lengthComputable) {
                        var percentComplete = (event.loaded / event.total) * 100;
                        document.getElementById('uploadProgress').value = percentComplete;
                    }
                };

                xhr.onload = function() {
                    if (xhr.status == 200) {
                        var response = JSON.parse(xhr.responseText);
                        document.getElementById('statusMessage').innerHTML = response.message;
                    } else {
                        document.getElementById('statusMessage').innerHTML = '<?php echo getLangString('uploaderror'); ?>';
                    }
                };

                xhr.send(formData);
            });
        });

        function toggleSection(sectionId) {
            var section = document.getElementById(sectionId);
            section.style.display = section.style.display === 'none' ? 'block' : 'none';
        }

        function toggleMapField() {
            var modType = document.getElementById("modType").value;
            var mapIdField = document.getElementById("mapIdField");
            var mapTrackField = document.getElementById("mapTrackField");
            if (modType === "map") {
                mapIdField.style.display = 'block';
                mapTrackField.style.display = 'block';
                document.getElementById("mapId").required = true;
            } else {
                mapIdField.style.display = 'none';
                mapTrackField.style.display = 'none';
                document.getElementById("mapId").required = false;
            }
        }

        function executeScript(mapId) {
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                    console.log(this.responseText);
                    window.location.reload();
                }
            };
            xhttp.open("POST", "beamng/changemap_script.php", true);
            xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhttp.send("mapId=" + mapId);
        }

        function executeScriptRemoveMod(ModChemin) {
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                    console.log(this.responseText); // Ajout de logs pour voir la réponse
                    window.location.reload();
                }
            };
            xhttp.open("POST", "beamng/removemod_script.php", true);
            xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhttp.send("ModChemin=" + encodeURIComponent(ModChemin));
        }

        function updateServer() {
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                    console.log(this.responseText);
                    window.location.reload();
                }
            };
            xhttp.open("POST", "beamng/updateserver_script.php", true);
            xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhttp.send();
        }
    </script>
</body>
</html>
