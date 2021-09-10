<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Credentials: true");
header('Content-Type: application/json');

include_once('../../config/database.php');
include_once('../../config/globals.php');
include_once('../../model/event.php');

// get posted data
$data = json_decode(file_get_contents("php://input"));

$database = new Database();
$db_connection = $database->connection;
$event = new Event($db_connection);


//check connection
if ($db_connection->connect_errno) {
  echo($db_connection->connect_errno);
  die(' Sorry - gerade gibt es ein Problem');
}

if ($stmt = $db_connection->prepare("SELECT * FROM events WHERE 1")){
  if ($stmt->execute()){
    $result = $stmt->get_result();
    $events = $result->fetch_all(MYSQLI_ASSOC);
    // set response code - 200 OK
    http_response_code(200);
    // make it json format
    echo json_encode($events);
  }
}else{
  echo ("No connection to database");
}
 ?>
