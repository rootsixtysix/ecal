<?php
//Dieses Modul stellt die Verbindung zur Datenbank her

$servername = "db5000290729.hosting-data.io";
$username = "dbu503094";
$password = "knhAnLG8R>%Csg9J";
$db_name = "dbs284017";

//Create connection to Database
$db = new mysqli($servername, $username, $password, $db_name);
//check connection
if ($db->connect_errno) {
  die('Sorry - gerade gibt es ein Problem');
}
 ?>
