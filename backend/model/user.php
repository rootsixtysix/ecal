<?php
class User{
  //Database
  public $id;

  function __construct(){
    $this->id = null;
  }

  public function usernameIsAvailable($db_connection, $data){
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

  public function register($db_connection, $data){
    // make sure data is not empty
    if(!empty($data->username) && !empty($data->mail) &&
        !empty($data->password) && !empty($data->role)){

          // make new protagonist
          $stmt1 = $db_connection->prepare("INSERT INTO protagonists (role_id) VALUES (?)");
          $stmt1->bind_param("i", $role_id);
          $role_id = $data->role;
          $stmt1->execute();
          $catched_protagonist_id = $db_connection->insert_id;
          $stmt1->close();

          // create new empty contact table
          $stmt2 = $db_connection->prepare("INSERT INTO contacts () VALUES ()");
          $stmt2->execute();
          $catched_conact_id = $db_connection->insert_id;
          $stmt2->close();

          //create new user
          $stmt3 = $db_connection->prepare("INSERT INTO users (protagonist_id, username, email, password) VALUES (?, ?, ?, ?)");
          $stmt3->bind_param("isss", $protagonist_id, $username, $email, $password);
          $protagonist_id = $catched_protagonist_id;
          $username = $data->username;
          $email = $data->mail;
          $password = password_hash($data->password, PASSWORD_DEFAULT);
          $stmt3->execute();
          $stmt3->close();

          switch ($data->role) {
            case '1':
              // make new person
              $stmt4 = $db_connection->prepare("INSERT INTO persons (protagonist_id, contact_id, name) VALUES (?, ?, ?)");
              $stmt4->bind_param("iis", $protagonist_id, $contact_id, $name);
              $protagonist_id = $catched_protagonist_id;
              $contact_id = $catched_conact_id;
              $name = $data->username;
              $stmt4->execute();
              $stmt4->close();
              break;
            case '2':
              //make new addresse
              $stmt5 = $db_connection->prepare("INSERT INTO addresses () VALUES ()");
              $stmt5->execute();
              $catched_address_id = $db_connection->insert_id;
              $stmt5->close();
              //make new location
              $stmt6 = $db_connection->prepare("INSERT INTO locations (protagonist_id, address_id, contact_id, name) VALUES (?, ?, ?, ?)");
              $stmt6->bind_param("iiis", $protagonist_id, $address_id, $contact_id, $name);
              $protagonist_id = $catched_protagonist_id;
              $address_id = $catched_address_id;
              $contact_id = $catched_conact_id;
              $name = $data->name;
              $stmt6->execute();
              $stmt6->close();
              break;
            case '3':
              //make new artist
              $stmt7 = $db_connection->prepare("INSERT INTO artists (protagonist_id, contact_id, name) VALUES (?, ?, ?)");
              $stmt7->bind_param("iis", $protagonist_id, $contact_id, $name);
              $protagonist_id = $catched_protagonist_id;
              $contact_id = $catched_conact_id;
              $name = $data->name;
              $stmt7->execute();
              $stmt7->close();
              break;
            default:
              break;
        }
    }
  }

  public function login($db_connection, $data, $globals){
    $logInWasSuccesful = false;
    $catched_id = '0';
    // make sure data is not empty
    if( !empty($data->username) &&  !empty($data->password) ){
      //search in users with username
      if ($stmt = $db_connection->prepare("SELECT user_id, password FROM users WHERE username = ?")){
        $stmt->bind_param('s', $username);
        $username = $data->username;
        if ($stmt->execute()){
          $stmt->bind_result($user_id, $password);
          $stmt->fetch();
          if (password_verify($data->password, $password)){
            $logInWasSuccesful = true;
            $catched_id = $user_id;
          }
          $stmt->close();
        }
      }
    }elseif( !empty($data->mail) &&  !empty($data->password) ){
      if ($stmt = $db_connection->prepare("SELECT user_id, password FROM users WHERE mail = ?")){
        $stmt->bind_param('s', $mail);
        $mail = $data->mail;
        if ($stmt->execute()){
          $stmt->bind_result($user_id, $password);
          $stmt->fetch();
          if (password_verify($data->password, $password)){
            $logInWasSuccesful = true;
            $catched_id = $user_id;
          }
          $stmt->close();
        }
      }
    }

    if ($logInWasSuccesful){
      $this->createUserIdCookie($db_connection, $data, $user_id, $globals);
      $this->createSessionCookie($db_connection, $data, $user_id, $globals);
    }

    $response = array(
        "id" => $catched_id,
    );
    // set response code - 200 OK
    http_response_code(200);

    // make it json format
    echo(json_encode($response));
  }

  private function createUserIdCookie($db_connection, $data, $u_id, $globals){
    //prepate Cookie
    $salt = substr (md5($data->password), 0, 2);
    $cookie_content = base64_encode ("$data->username:" . md5($data->password, $salt));

    //store cookie Content in db to identify user
    if ($stmt = $db_connection->prepare("UPDATE users SET user_id_cookie=? WHERE user_id=?")){
      $stmt->bind_param('ss', $user_id_cookie, $user_id);
      $user_id_cookie = $cookie_content;
      $user_id = $u_id;
      $stmt->execute();
      $stmt->close();
    }

    //set cookie
    setcookie ('user_id', $cookie_content, "", $globals['path_rest_api']);
  }

  private function createSessionCookie($db_connection, $data, $u_id, $globals){
    //prepate Cookie
    $salt = substr (md5($data->password), 0, 2);
    $cookie_content = base64_encode ("$data->username:" . md5($data->password, $salt));

    //store cookie Content in db to identify user
    if ($stmt = $db_connection->prepare("UPDATE users SET session_cookie=? WHERE user_id=?")){
      $stmt->bind_param('ss', $session_cookie, $user_id);
      $session_cookie = $cookie_content;
      $user_id = $u_id;
      $stmt->execute();
      $stmt->close();
    }

    //set cookie
    setcookie ('session_id', $cookie_content, "", $globals['path_rest_api']);
  }

  public function get_user_id_from_cookie($db_connection, $cookie){
    if ($stmt = $db_connection->prepare("SELECT user_id FROM users WHERE session_cookie = ?")){
      $stmt->bind_param('s', $session_cookie);
      $session_cookie = $cookie;
      if ($stmt->execute()){
        $stmt->bind_result($user_id);
        $stmt->fetch();
        $stmt->close();
        $this->id = $user_id;
        return($user_id);
      }
    }
    return(NULL);
  }

  public function bookmark_event($db_connection, $user_id, $event_id){
    if ($stmt = $db_connection->prepare("INSERT INTO user_bookmarked_event (user_id, event_id) VALUES (?, ?)")){
      $stmt->bind_param("ss", $user_id, $event_id);
      $user_id = $user_id;
      $event_id = $event_id;
      if ( ($stmt->execute())) {
        $catched_event_id = $db_connection->insert_id;
        $wasSuccesful = true;
      }else{
        echo($stmt->error);
      }
      $stmt->close();
    }
  }

  public function get_bookmarked_events($db_connection, $user_id){
    if ($stmt = $db_connection->prepare("SELECT event_id FROM user_bookmarked_event WHERE user_id = ?")){
      $stmt->bind_param('s', $user_id);
      $user_id = $user_id;
      if ($stmt->execute()){
        $result = $stmt->get_result();
        #$events = [1,2,3];
        $events = $result->fetch_all(MYSQLI_ASSOC);
        // set response code - 200 OK
        http_response_code(200);
        // make it json format
        echo json_encode($events);
        return($events);
      }
    }else{
      echo ("No connection to database");
    }
  }

  public function get_bookmarked_events2($db_connection, $u_id){
    if ($stmt = $db_connection->prepare(" SELECT *
                                          FROM events
                                          JOIN user_bookmarked_event
                                          ON events.event_id = user_bookmarked_event.event_id
                                          WHERE user_bookmarked_event.user_id = ?")){
      $stmt->bind_param('s', $user_id);
      $user_id = $u_id;
      if ($stmt->execute()){
        $result = $stmt->get_result();
        #$events = [1,2,3];
        $events = $result->fetch_all(MYSQLI_ASSOC);
        // set response code - 200 OK
        http_response_code(200);
        // make it json format
        echo json_encode($events);
        return($events);
      }
    }else{
      echo ("No connection to database");
    }
  }


}
 ?>
