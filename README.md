# BeamMP Web Interface
A Web interface for the BeamMP multiplayer server

# Warning
**I'm not a developer. All the PHP and CSS code was written by ChatGPT (not without difficulty...) and I took care of the Shell / Mysql part. It is therefore highly probable (not to say certain) that the code contains security flaws, particularly in terms of SQL injections and verification of uploaded files. Any help I can get to improve the code is therefore most welcome. Thanks in advance to those who do.**

# Features
• Displays the map currently configured on the server.

• Ability to change MAP

• Ability to delete an MOD

• Ability to upload an MOD

• Listing of all MODs present on the server (maps, cars and features) with the exception of the game's official cars.

• For each MOD (map, car, feature), its name, description and an image are displayed.

• For maps, an image showing the circuit layout can be displayed.

• Only the MAP currently configured on the server is present in the MOD folder, the others are placed in a separate folder to optimize MOD download and loading time.

# Installation
### prerequisites

• Linux (I use Ubuntu)

• A Web server (I use Apache)

• A database (I use MySQL)

# To-do list

Here are the things I'd like to add. But I don't promise to ever do it (especially the installation script)

• When uploading a MAP, automatically detect the MAP ID to update the BeamMP server config file.

• Multilingual management of Web interface (section titles, buttons, MOD submission form)

• Creating an installation script
