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
## prerequisites

• Linux (I use Ubuntu Ubuntu 22.04 LTS)

• A Web server (I use Apache 8.3)

• PHP

• A database (I use MySQL 8.0)

• **Knowledge of using Linux from the command line, Apache, PHP and MySQL is a great advantage**. Although I've tried to create a comprehensive installation guide, I don't go into detail about installing and configuring Apache or MySQL. You'll find a detailed tutorial in French [here](https://doc.ubuntu-fr.org/lamp) and in English [here](https://www.digitalocean.com/community/tutorials/how-to-install-lamp-stack-on-ubuntu).

• Open the Web server port to make your site accessible on the Internet.

# To-do list

**Here are the things I'd like to add. But I don't promise to ever do it (especially the installation script)**

• When uploading a MAP, automatically detect the MAP ID to update the BeamMP server config file.

• Multilingual management of Web interface (section titles, buttons, MOD submission form)

• Creating an installation script

• Support for MAPs with multiple variants in the zip file. For the moment it's possible to do this by manually inserting the other variants in the database (or perhaps by uploading the same MAP several times by changing its ID in the MOD upload form. But I haven't tried).
