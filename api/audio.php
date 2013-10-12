<?php
include('config/db.php');
include('models/audio_model.php');
include('config/urls.php');



function get(){
	global $audio_model;

	$results = $audio_model->getAll();

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