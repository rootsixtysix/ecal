<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Credentials: true");
header('Content-Type: application/json');

require_once('../../config/database.php');
require_once('../../model/user.php');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $user = new User();
  $database = new Database();
  $db_connection = $database->connection;

  // get posted data
  $data = json_decode(file_get_contents("php://input"));

  $user->register($db_connection, $data);
}
?>
