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

$database = new Database();
$db_connection = $database->connection;
$event = new Event($db_connection);

// get posted data
$data = json_decode(file_get_contents("php://input"));

$event = [];
if($data->id!=null){
  $result = $db_connection->query("SELECT e.*,
                        l.name as 'location_name',
                        r.name as 'room_name',
                        c.name as 'category_name'
                        FROM events as e
                        inner JOIN locations as l on e.location_id = l.location_id
                        inner JOIN rooms as r ON e.room_id = r.room_id
                        inner JOIN category as c on e.category_id = c.category_id
                        WHERE event_id = $data->id")
    or die($db->error);
    while($event_data = $result->fetch_assoc()) {
      $event->title = $event_data["title"];
      $event->start_date = $event_data["start"];
      $event->start = $event_data["start"];
      $event->end = $event_data["end"];
      $event->description = $event_data["description"];
      $event->image_url = $event_data["picture"];
      $event->location_id = $event_data["location_id"];
      $event->location_name = $event_data["location_name"];
      $event->room_name = $event_data["room_name"];
      $event->category_id = $event_data["category_id"];
      $event->category_name = $event_data["category_name"];
    }
}



/*
//get event ID from url
$event_id = $_GET["id"];

$database = new Database();
$event = new Event($database);
$event->assign_id($event_id);
$event->get_all_information();
*/

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
