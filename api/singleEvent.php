<?php
include('config/db.php');
include('models/genre_model.php');
include('models/poster_model.php');
include('models/events_model.php');
include('config/urls.php');



function get(){
	global $events_model;

	if(isset($_GET['bandid'])){
		$bandid = $_GET['bandid'];
		$results = $events_model->getByBandId($bandid);
	}
	if(isset($_GET['eventid'])){
		$eventid = $_GET['eventid'];
		$results = $events_model->getById($eventid);
	}

	$results = json_encode($results);

	echo $results;
}

function put(){
	echo "put";
}

function post(){
	global $events_model;
	error_log("event insert");

	$name = $_POST['event_name'];
	$location = $_POST['event_location'];
	$city = $_POST['event_city'];
	$date     = $_POST['event_date'];
	$genre    = $_POST['event_genre'];
	
	if(isset($_POST['event_description'])){
		$description = $_POST['event_description'];
	}else{
		$description = "";
	}

	$eventid= $events_model->insert($name, $location, $city, $date, $genre, $description);

	echo $eventid;
	//NEED TO GET genreid from genre table

	
}

function delete(){
	echo "delete";

}


?>