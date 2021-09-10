<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Credentials: true");
header('Content-Type: application/json');

require_once('../../config/database.php');
require_once('../../model/user.php');
require_once('../../model/event.php');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $database = new Database();
  $db_connection = $database->connection;
  $user = new User();

  // get posted data
  $data = json_decode(file_get_contents("php://input"));

  //get user_id from cookies
  $user->get_user_id_from_cookie($db_connection, $_COOKIE['session_id']);

  //bookmark event
  $user->bookmark_event($db_connection, $data->event_id);
}

?>
