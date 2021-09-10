<?php

require_once('config/database.php');

$database = new Database();
$db_connection = $database->connection;


// prepare and bind for inserting into protagonists
$stmt1 = $db_connection->prepare("INSERT INTO protagonists (role_id) VALUES (?)");
$stmt1->bind_param("i", $role_id);

// set parameters and execute for inserting into protagonists
$role_id = 1;
$stmt1->execute();

//catch last inserted id for protagonist_id
$catched_protagonist_id = $db_connection->insert_id;

// prepare and execute for inserting into contacts
$stmt2 = $db_connection->prepare("INSERT INTO contacts () VALUES ()");
$stmt2->execute();

//catch last inserted id for protagonist_id
$catched_conact_id = $db_connection->insert_id;

// prepare and bind for inserting into users
$stmt3 = $db_connection->prepare("INSERT INTO users (protagonist_id, username, email, password) VALUES (?, ?, ?, ?)");
$stmt3->bind_param("isss", $protagonist_id, $username, $email, $password);

// prepare and bind for inserting into persons
$stmt4 = $db_connection->prepare("INSERT INTO persons (protagonist_id, contact_id, name) VALUES (?, ?, ?)");
$stmt4->bind_param("iis", $protagonist_id, $contact_id, $name);

// set parameters and execute for inserting into users and into persons
$protagonist_id = $catched_protagonist_id;
$username = 'user';
$email = 'mail@me.com';
$password = password_hash("12345678", PASSWORD_DEFAULT);
$contact_id = $catched_conact_id;
$name = "User";
$stmt3->execute();
$stmt4->execute();





echo($catched_protagonist_id);

 ?>
