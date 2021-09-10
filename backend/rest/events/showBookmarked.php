<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Credentials: true");
header('Content-Type: application/json');


include_once('../../config/database.php');
include_once('../../model/event.php');
include_once('../../model/user.php');

// get posted data
$data = json_decode(file_get_contents("php://input"));

$database = new Database();
$db_connection = $database->connection;
$event = new Event($database);
$user = new User();

#$user->get_bookmarked_events2($db_connection, '1');
$bookmarked_event_ids = $user->get_bookmarked_events2($db_connection, $data->userId);


 ?>
