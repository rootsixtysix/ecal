<?php
// required headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Credentials: true");
header('Content-Type: application/json');

#require('config/globals.php');
include_once('../../config/database.php');
include_once('../../model/event.php');

//get event ID from url
$event_id = $_GET["id"];

$database = new Database();
$event = new Event($database);
$event->assign_id($event_id);
$event->get_all_information();


if($event->title!=null){
    // create array
    $event_arr = array(
        "id" =>  $event->id,
        "title" => $event->title,
    );

    // set response code - 200 OK
    http_response_code(200);

    // make it json format
    echo json_encode($event_arr);
}

else{
    // set response code - 404 Not found
    http_response_code(404);

    // tell the user product does not exist
    echo json_encode(array("message" => "Product does not exist."));
}

 ?>
