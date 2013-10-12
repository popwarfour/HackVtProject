<?php
include('config/db.php');
include('models/audio_model.php');
include('models/events_model.php');
include('models/genre_model.php');
include('config/urls.php');



function get(){
	global $db;
	global $genre_model;
	global $events_model;

	

	//if(isset($_GET['bands'])){
		$results = $events_model->listAllJoined();
	//}else{
	//	$results = $events_model->listAll();
	//}

//$status =  Array("status_code"=>200);
//	array_unshift($results, $status);
	$results = json_encode($results);

	echo $results;
}

function put(){





	echo "put";
}

function post(){
	echo "post";
}

function delete(){
	echo "delete";

}


?>