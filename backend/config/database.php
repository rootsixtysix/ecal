<?php

//Dieses Modul stellt die Verbindung zur Datenbank her
class Database{

  private $servername = "localhost";
  private $username = "root";
  private $password = "";
  private $db_name = "events_db";
  
  public $connection = NULL;


  public function __construct(){
    //Create connection to Database
    $this->connection = new mysqli($this->servername, $this->username, $this->password, $this->db_name);
    //check connection
    if ($this->connection->connect_errno) {
      die('Sorry - gerade gibt es ein Problem');
    }
  }

}

 ?>
