<?php
include('config/db.php');
include('config/urls.php');



function get(){
	global $db;
	
	$query = "select * from band";


	$results = $db->query($query);

	$status =  Array("status_code"=>200);
	array_unshift($results, $status);
	$results = json_encode($results);

	echo $results;
}

function put(){
	echo "put";
}

function post(){
	global $db;

	$name = $_POST['band_name'];
	$email = $_POST['band_email'];
	$phone = $_POST['band_phone'];
	$details = $_POST['band_details'];

	$query = "insert into band values('', '".$name."', '".$details."', '".$email."', '".$phone."')";
	$db->execute($query);
	
}

function delete(){
	echo "delete";

}


?>