<?php
class ArtistInEvent{
  public $id;
  public $name;

  function __construct($id, $name){
    $this->id = $id;
    $this->name = $name;
  }
}

class Event{
  //Database
  private $database;
  //keys
  public $id;
  public $room_id;
  public $location_id;
  public $category_id;
  //from own table
  public $title;
  public $start;
  public $end;
  public $description;
  public $image_url;
  //from other tables
  public $artists;
  public $location_name;
  public $room_name;
  public $category_name;
  public $group_id;
  public $group_name;


  function __construct($database){
    $blank_string = "...";

    $this->database = $database;

    $this->id = null;
    $this->room_id = null;
    $this->location_id = null;
    $this->category_id = null;
    $this->title = $blank_string;
    $this->start = $blank_string;
    $this->end = null;
    $this->description = $blank_string;
    $this->image_url = null;
    $this->artists = [];
    $this->location_name = $blank_string;
    $this->room_name = null;
    $this->category_name;
    $this->group_id = null;
    $this->group_name = null;
  }

  function assign_id($event_id){
    $this->id = $event_id;
  }


  function get_all_information(){
    $this->get_information();
    $this->get_group();
    $this->get_artists();
  }

  function get_information(){
    $db = $this->database->connection;
    $result = $db->query("SELECT e.*,
    											l.name as 'location_name',
    											r.name as 'room_name',
                          c.name as 'category_name'
    											FROM events as e
    											inner JOIN locations as l on e.location_id = l.location_id
    											inner JOIN rooms as r ON e.room_id = r.room_id
                          inner JOIN category as c on e.category_id = c.category_id
    											WHERE event_id = $this->id")
    	or die($db->error);
      while($event_data = $result->fetch_assoc()) {
      	$this->title = $event_data["title"];
        $this->start_date = $event_data["start"];
      	$this->start = $event_data["start"];
      	$this->end = $event_data["end"];
      	$this->description = $event_data["description"];
        $this->image_url = $event_data["picture"];
      	$this->location_id = $event_data["location_id"];
      	$this->location_name = $event_data["location_name"];
      	$this->room_name = $event_data["room_name"];
        $this->category_id = $event_data["category_id"];
        $this->category_name = $event_data["category_name"];
      }
  }

  function get_group(){
    $db =  $this->database->connection;
    $result = $db->query("SELECT ge.*,
                          g.group_id as 'group_id', g.name as 'group_name'
                          FROM group_event  as ge
                          inner JOIN groups as g on ge.group_id = g.group_id
                          WHERE event_id = $this->id")
    or die($db->error);
    while($group_data = $result->fetch_assoc()){
      $this->group_id = $group_data["group_id"];
      $this->group_name = $group_data["group_name"];
    }
  }

  function get_artists(){
    $db =  $this->database->connection;
    $result = $db->query("SELECT ae.*,
                          a.name as 'artist_name'
                          FROM artist_in_event as ae
                          inner JOIN artists as a on ae.artist_id = a.artist_id
                          WHERE event_id = $this->id")
    or die($db->error);
    $all_artists = $result->fetch_all(MYSQLI_ASSOC);
    foreach ($all_artists as $artist) {
      $new_artist = new ArtistInEvent($artist['artist_id'], $artist['artist_name']);
      array_push($this->artists, $new_artist);
    }
  }

  function to_ics_event($icalobj){
    require_once('lib/icalendar/zapcallib.php');
    $servername = 'evente.org';
    //add even node to icalobject
    $eventobj = new ZCiCalNode("VEVENT", $icalobj->curnode);
    $eventobj->addNode(new ZCiCalDataNode("SUMMARY:" . $this->title));
    $eventobj->addNode(new ZCiCalDataNode("DTSTART:" . ZCiCal::fromSqlDateTime($this->start)));
    if (isset($this->end)){
        $eventobj->addNode(new ZCiCalDataNode("DTEND:" . ZCiCal::fromSqlDateTime($this->end)));
    }
    $eventobj->addNode(new ZCiCalDataNode("LOCATION:" . ZCiCal::formatContent($this->location_name)));
    $eventobj->addNode(new ZCiCalDataNode("Description:" . ZCiCal::formatContent($this->description)));   //TODO: Format description (remove \n)
    $eventobj->addNode(new ZCiCalDataNode("UID:" . $servername . '/' . $this->id));
    $eventobj->addNode(new ZCiCalDataNode("DTSTAMP:" . ZCiCal::fromSqlDateTime()));
    return $icalobj;
  }


  public function create($data){
    $wasSuccesful = false;
    $catched_event_id = '';
    $db_connection = $this->database->connection;

    // create event with absolutely required parameters (title, start and privacy)
    if(!empty($data->title) && !empty($data->start) && !empty($data->privacy)){
      if ($stmt = $db_connection->prepare("INSERT INTO events (title, start, privacy) VALUES (?, ?, ?)")){
        $stmt->bind_param("sss", $title, $start, $privacy);
        $title = $data->title;
        $start = $data->start;
        $privacy = $data->privacy;
        if ( ($stmt->execute())) {
          $catched_event_id = $db_connection->insert_id;
          $wasSuccesful = true;
        }else{
          echo($stmt->error);
        }
        $stmt->close();
      }else{
        echo("no valid db query");
      }
    }else{
      echo("empty data");
    }

    //add description
    if(!empty($data->description) && $catched_event_id!=''){
      //
      if ($stmt = $db_connection->prepare("UPDATE events SET description=? WHERE event_id=?")){
        $stmt->bind_param("si", $description, $event_id);
        $description = $data->description;
        $event_id = $catched_event_id;
        if ( !($stmt->execute())) {
          echo($stmt->error);
        }
        $stmt->close();
      }else{
        echo("no valid db query");
      }
    }
    //add location
    /*
    if(!empty($data->location) && $catched_event_id!=''){
      //
      if ($stmt = $db_connection->prepare("UPDATE events SET location=? ")){
        $stmt->bind_param("s", $location);
        $description = $data->location;
        if ( !($stmt->execute())) {
          echo($stmt->error);
        }
        $stmt->close();
      }else{
        echo("no valid db query");
      }
    }
    */





    //send answer
    $response = array(
        "wasSuccesful" =>  $wasSuccesful,
        "id" => $catched_event_id,
    );
    http_response_code(200);
    echo(json_encode($response));

    return($catched_event_id);
  }



}
 ?>
