<?php
require_once('config/database.php');
require('config/globals.php');
require_once('model/event.php');
require('func/datetime_string_handle.php');


//get event ID from url
$event_id = $_GET["id"];

$database = new Database();
$event = new Event($database);
$event->assign_id($event_id);
$event->get_all_information();

#include("head.php");
echo("<body>");

#  include("header.php");
  echo("<main>");
    echo("<div class=\"main-content\" id=\"event-view\">");
      echo("<img class=\"event-picture\" src=\"$event->image_url\" alt=\"...\">");
      //show title
      echo("<h1>" . $event->title . "</h1>");
      echo("<div class=\"event-info\">");
        echo("<div class=\"date-time-location\">");
          //show startdate
          echo("<div>📅" . get_date($event->start) . "</div>");
          //show starttime
          echo("<div>🕑" . get_time($event->start) . "</div>");
          //show location and room if given
          echo "<div>📍<a href=\"location.php?id=$event->location_id\">$event->location_name</a></div>";
          if ($event->room_name != null)
            echo("🏠" . $event->room_name);
        echo("</div>");//date-time-location
        //show artists if given
        if ($event->artists!=[]){
          echo("<div>");
          $i = 1;
          foreach ($event->artists as $artist) {
            if ($i>1)
              echo " | ";
            echo "<a href=\"artist.php?id=$artist->id\">$artist->name</a>";
            $i++;
          }
          echo("</div>");//artists
        }
        //show group if given
        if ($event->group_id!=null)
          echo "<a href=\"group.php?id=$event->group_id\">$event->group_name</a>";
        //show category
        echo "<a href=\"category.php?id=$event->category_id\">$event->category_name</a>";
      echo("</div>");//event-info
      echo("<div class=\"event-buttons\">");
        //show Dwnload-Button link if proper event
        if ($event->id!=null and $event->id!=0){
        echo "<button class=\"small-button\"><a href=\"inc/event_download.php?id=$event->id\"><img src=\"assets/img/icons/add_event.png\" alt=\"..\"></a></button>";
        echo "<button onclick=\"openSharePopUp()\" class=\"small-button\"><img src=\"assets/img/icons/share.png\"></a></button>";
        echo "<button onclick=\"bookmark()\" id=\"star-icon\" class=\"small-button\"><img src=\"assets/img/icons/starfull.png\"></a></button>";
        }
      echo("</div>");//buttons
      echo("<div class=\"event-description\">");
        //show description
        echo "<p>".$event->description . "</p>";
      echo("</div>");//event-description
    echo("</div>");//event-view
  echo("</main>");

  echo("<div class=\"pop-up-frame\" id=\"pop-up-frame\">");

    echo("<div  id=\"pop-up-content-frame\" class=\"pop-up-content-frame\">");
      echo("<div id=\"pop-up-close-button\"><img src=\"assets/img/icons/x.png\" alt=\"..\"></div>");

      echo("<div id=\"pop-up-share\" class=\"pop-up-content\">");
        echo "<button onclick=\"openSubscribePopUp()\" class=\"button\">Add to external calendar</button>";
        echo "<button onclick=\"openEmbedPopUp()\" class=\"button\">Embed</button>";
      echo("</div>");

      echo("<div id=\"pop-up-subscribe\" class=\"pop-up-content\">");
        echo "<p> Add the following link to your calendar application:";
        echo("<div class=\"subscription-link\"> $domain/inc/event_download.php?id=$event->id </div>");
      echo("</div>");//pop-up-subscribe

      echo("<div id=\"pop-up-embed\" class=\"pop-up-content\">");
        echo "<p> Add the following html code to your page";
        echo("<div class=\"code\"> <xmp> <iframe src=\"$domain/event-embed.php?id=$event->id\" frameborder=\"no\" height=\"500px\" width=\"100%\"></iframe></xmp>  </div>");
      echo("</div>");//pop-up-embed
    echo("</div>");//pop-up-content
  echo("</div>");//pop-up-frame

#  include("footer.php");

  echo("<script src=\"assets/popup.js\"></script>");
echo("</body>");
?>
