# BeamMP Web Interface
A Web interface for the BeamMP multiplayer server

# Warning
**I'm not a developer. All the PHP and CSS code was written by ChatGPT (not without difficulty...) and I took care of the Shell / Mysql part. It is therefore highly probable (not to say certain) that the code contains security flaws, particularly in terms of SQL injections and verification of uploaded files. Any help I can get to improve the code is therefore most welcome. Thanks in advance to those who do.**

**This project has been designed to facilitate management of the BeamMP server by the administrator and trusted players. It is not intended for public access, and Apache authentication is strongly recommended.**

# Features
• Displays the map currently configured on the server.

• Ability to change MAP

• Ability to delete an MOD

• Ability to upload an MOD

• Listing of all MODs present on the server (maps, cars and features) with the exception of the game's official cars.

• For each MOD (map, car, feature), its name, description and an image are displayed.

• For maps, an image showing the circuit layout can be displayed.

• Only the MAP currently configured on the server is present in the MOD folder, the others are placed in a separate folder to optimize MOD download and loading time.

• Multilingual management of the interface (and only the interface, not database content such as MOD names and descriptions). For the moment english, french, spanish and german only. Any language can be added to the lang file.

# Preview
![Preview](https://geekz0ne.fr/1.jpg) 
![Preview 2](https://geekz0ne.fr/20.jpg)
![Preview 3](https://geekz0ne.fr/30.jpg)
![Preview 4](https://geekz0ne.fr/40.jpg)
![Preview 5](https://geekz0ne.fr/50.jpg)
![Preview 6](https://geekz0ne.fr/60.jpg)

# Installation
## prerequisites

• Linux (I use Ubuntu 22.04 LTS)

• A Web server (I use Apache 2.4)

• PHP (I use 8.3 version)

• A database (I use MySQL 8.0)

• The following PHP modules must be installed : php-mysqli, php-json, php-fileinfo & php-filter

• The following Apache module must be installed : libapache2-mod-php

• **Knowledge of using Linux from the command line, Apache, PHP and MySQL is a great advantage**. Although I've tried to create a comprehensive installation guide, I don't go into detail about installing and configuring Apache, PHP or MySQL. You'll find a detailed tutorial in French [here](https://doc.ubuntu-fr.org/lamp) and in English [here](https://www.digitalocean.com/community/tutorials/how-to-install-lamp-stack-on-ubuntu).

• Open the Web server port to make your site accessible on the Internet.

## Installation guide
**If you need help with the installation, don't hesitate to contact me on the dedicated Telegram channel: https://t.me/+VwELwQa3Cb8yMjhk**

### 0 - Information used for the example

In our example, we'll use the following information:

- The root folder of the Web server where the Web interface files are located is: **/var/www/html/**
- The root folder of the BeamMP server is: **/home/user/BeamMP/**
- The database is called “**gaming**”.
- The database user is “**db_user**”.
- The database password is “**db_password**”.
- The default Apache user is **www-data**
- The BeamMP server service is called “**BeamMP**”.

**So you need to modify the information to suit your environment.**

**Most operations require root access. It is therefore preferable to follow all the steps as a “root” user.**

### 1 - Retrieve and upload files to the Web server

Click on the green “<> Code” button at the top of this page, then on “Download ZIP”.

Drop the contents of the “BeamMP-Web-Interface-main” folder into the root folder of your Web server (normally /var/www/html). You can also use a dedicated vhost (https://www.digitalocean.com/community/tutorials/how-to-set-up-apache-virtual-hosts-on-ubuntu-18-04-quickstart).

### 2 - Create the folder needed to store inactive cards

In your BeamMP server folder, you'll find a “Resources” folder. In this folder, create a new folder called “inactive_map”. In the “Resources” folder, you should now have 3 folders: “Client”, “Server” and “inactive_map”.

    $ cd /home/user/BeamMP/Resources
    $ mkdir inactive_map

### 3 - Give folders and files the necessary rights

You must grant the necessary rights to the folders and files in the Web interface and BeamMP folder, so that Apache can access them to modify the configuration file and manipulate the MODs.

    $ chmod -R 775 /var/www/html/beamng/ && chown -R www-data:www-data /var/www/html/beamng/ && chmod -R 775 /home/user/BeamMP/ && chown -R www-data:www-data /home/user/BeamMP/

### 4 - Apply execution rights to scripts

    $ chmod +x /var/www/html/beamng/scripts/changemap_script.sh && chmod +x /var/www/html/beamng/scripts/removemod_script.sh && chmod +x /var/www/html/beamng/scripts/uploadmod_script.sh

### 5 - Securing access to the Web interface

In the folder containing the beamng.php and config files, you'll find a file named .htaccess. This file restricts access to authorized users and protects the “config” file.
You need to create an .htpasswd file outside your Web server folder to create user accounts for access to the Web interface:

To create the file for the first time (replace “username1” with the user name of your choice) :

    $ htpasswd -c /var/www/.htpasswd username1

You will then be prompted to enter a password for the first user.

To add a new user to an existing .htpasswd file (replace “username2” with the username of your choice):

    $ htpasswd /var/www/.htpasswd username2

You will then be asked to enter a password for this new user.

**If you've created your .htpasswd file elsewhere, don't forget to change its path in the .htaccess file.**

### 6 - Create the database

    $ mysql
    $ create database gaming;
    $ exit

### 7 - Create the BeamMP service
If you haven't already done so, you need to create a service for your BeamMP server. The changemap_script.sh script restarts the service each time the MAP is changed.

    $ sudo nano /etc/systemd/system/BeamMP.service

Paste the following contents into the folder, adapting the path to the server execution script and the user and group running the server.

    $ [Unit]
    $ Description=Game server for BeamNG.drive

    $ [Service]
    $ ExecStart=/home/user/BeamMP/run.sh
    $ Restart=always
    $ User=user
    $ Group=user
    $ Environment=

    $ [Install]
    $ WantedBy=multi-user.target

(“ctrl x” then “y” to quit and save changes)

Start the service and activate it at system startup:

    $ systemctl daemon-reload
    $ systemctl start BeamMP
    $ systemctl enable BeamMP

### 8 - Set up the configuration file

    $ nano /var/www/html/beamng/config

Add or replace all the information in the configuration file to suit your environment:

**WARNING: Do not put an equal sign (=) in the password, user name, database name or folder names.**

servername = corresponds to the MySQL server name. Normally you'd leave this as “localhost”.
username = corresponds to the user name with access to the database
password = corresponds to the password of the user accessing the database
dbname = corresponds to the database name. If you haven't changed it in relation to this documentation, leave it as “gaming”.

BeamMPFolder = corresponds to the folder containing BeamMP server files
WebServerRootFolder = corresponds to the folder containing the Web interface files

**WARNING : make sure the path begins and ends with a slash “/”.**

beammpservice = corresponds to the name of the BeamMP service we created in the previous step.
lang = corresponds to the language of the Web interface.

### 9 - Add default MAPs to the database

I propose 4 SQL dumps in 4 different languages, allowing you to add the game's default maps to the database:

    $ cd /var/www/html/
    $ mysql gaming < gaming_EN.sql

(Replace “EN” with “FR”, “DE” or “ES” depending on the language you require).

### 10 - Configuring the “driver_training” map in the BeamMP conf file

In the database, the default map configured in the dump we loaded above is driver_training. It is therefore necessary to configure this map in the config file once for the MAP change script to work:

    $ nano /home/user/BeamMP/ServerConfig.toml

at Map level = configure the correct MAP, so the line looks like this:

    $ Map = “/levels/driver_training/info.json”


**That's it, your Web interface is up and running. Don't forget to open the Apache server port if you want to make it accessible to other trusted players.**

# To-do list

**Here are the things I'd like to add. But I don't promise to ever do it (especially the installation script)**

• When uploading a MAP, automatically detect the MAP ID to update the BeamMP server config file.

• Creating an installation script

• Support for MAPs with multiple variants in the zip file. For the moment it's possible to do this by manually inserting the other variants in the database (or perhaps by uploading the same MAP several times by changing its ID in the MOD upload form. But I haven't tried).
