<?php
include('config/db.php');
include('models/poster_model.php');
include('config/urls.php');



function get(){
	global $poster_model;

	$posterid = $_GET['posterid'];
	$lat = $_GET['lat'];
	$lng = $_GET['lng'];

	$eventid = $poster_model->getById($posterid);
	
	$scanCount = $results['scanCount'];
	$scanCount = $scanCount + 1;



	//update poster with new coords and scan count
	$poster_model->update($lat, $lng, $scanCount, $posterid);


	$results = json_encode($results);

	echo $results;

	
}

function put(){
	echo "put";
}

//Scanned QR code comes in. 
function post(){
	global $poster_model;

	$eventid = $_POST['eventid'];
	$lat = $_POST['lat'];
	$lng = $_POST['lng'];

	//round for consistency
	$lat = round($lat, 4);
	$lng = round($lng, 4);



	$scanned = $poster_model->getByLatLng($lat,$lng);
	if(sizeof($scanned)==0){
		$poster_model->insertScan($eventid, $lat, $lng);
	}else{
		$scanCount = $scanned['scanCount'];
		$scanId = $scanned['id'];
		$scanCount++;

		$poster_model->updateScan($scanId, $scanCount);
	}	
}

function delete(){
	echo "delete";

}


?>