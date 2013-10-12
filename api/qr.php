<?php
include('config/db.php');
include('models/qr_model.php');
include('config/urls.php');

function get(){
	global $qr_model;

	//posterid=$_GET['posterid'];
	$results =$qr_model->getScans();

	//$results =$qr_model->getByPosterId($posterid);


	//$status =  Array("status_code"=>200);
	//array_unshift($results, $status);
	$results = json_encode($results);

	echo $results;

}

function put(){

}

function post(){
	global $qr_model;

	$posterid = $_POST['poster_id'];
	$url = $_POST['qr_url'];
	$image = $_POST['qr_image'];

	$qr_model->insert($posterid, $url, $image);
	
}

function delete(){

}

?>