<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Credentials: true");
header('Content-Type: application/json');

require_once('../../config/database.php');
require_once('../../model/user.php');

$database = new Database();
$db_connection = $database->connection;


if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $username_available = '';
  // get posted data
  $data = json_decode(file_get_contents("php://input"));

  // make sure data is not empty
  if( !empty($data->username)){

    // prepare and bind for searching in users
    if ($stmt = $db_connection->prepare("SELECT username FROM users WHERE username = ?")){

      $stmt->bind_param('s', $username);
      $username = $data->username;
      if ($stmt->execute()){
        $stmt->store_result();
        if($stmt->num_rows == 1){
          $username_available = "false";
        }else{
          $username_available = "true";
        }
      }
    }else{
      echo ("No connection to database");
    }
  }
  $response = array(
      "usernameIsAvailable" =>  $username_available,
  );
  // set response code - 200 OK
  http_response_code(200);

  // make it json format
  echo(json_encode($response));
}

?>
