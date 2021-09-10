<?php

function get_time($zeichenkette){
  $suchmuster = '/(\d{4})-(\d{2})-(\d{2})\s(\d+:\d+):\d+/i';
  $ersetzung = '$4'; //Uhrzeit
  return(preg_replace($suchmuster, $ersetzung, $zeichenkette));
}

function get_date($zeichenkette){
  $suchmuster = '/(\d{4})-(\d{2})-(\d{2})\s(\d+:\d+):\d+/i';
  $ersetzung = '$3.$2.$1'; //Datum
  $zeichenkette = preg_replace($suchmuster, $ersetzung, $zeichenkette);
  return(str_replace(date("Y"),"", $zeichenkette));
}

function format_ics($zeichenkette){
  $suchmuster = '/(\s)([A-Z]+:.*)/i';
  $ersetzung = '<br>$2'; //Zeile
  return(preg_replace($suchmuster, $ersetzung, $zeichenkette));
}

function add_hours($zeichenkette, $stunden){
  $date = new DateTime($zeichenkette);
  $date->add(new DateInterval('P'.$stunden.'H'));
  return $date;
}
?>



