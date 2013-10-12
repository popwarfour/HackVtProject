<?php
include('config/db.php');
include('models/genre_model.php');
include('models/audio_model.php');
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

//Called after pic upload
function put(){
	global $events_model;
	global $audio_model;

	parse_str(file_get_contents("php://input"),$post_vars);
	$eventid = $post_vars['eventid'];
	$name = $post_vars['event_name'];
	$location = $post_vars['event_location'];
	$city = $post_vars['event_city'];
	$date     = $post_vars['event_date'];
	$genre    = $post_vars['event_genre'];
	$description    = $post_vars['event_description'];

	$description = str_replace("'", '', $description);
	
	$audioids = $post_vars['audio_ids'];

	$events_model->updateEvent($eventid, $name, $location, $city, $date, $genre, $description);

	foreach($audioids as $audioid){
		$audio_model->attachAudioToEvent($audioid, $eventid);
	}
	

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

	$returndata= $events_model->insert($name, $location, $city, $date, $genre, $description);

	echo $returndata;
	//NEED TO GET genreid from genre table

	
}

function delete(){
	echo "delete";

}


?>