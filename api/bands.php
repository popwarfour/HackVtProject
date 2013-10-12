<?php
include('config/db.php');
include('models/bands_model.php');
include('config/urls.php');



function get(){
	global $db;
	global $bands_model;

	$results=$bands_model->listAll();

	$status =  Array("status_code"=>200);
	array_unshift($results, $status);
	$results = json_encode($results);

	echo $results;
}

function put(){
	global $bands_model;

	parse_str(file_get_contents("php://input"),$post_vars);	

	$id = $post_vars['band_id'];
	$name = $post_vars['band_name'];
	$email = $post_vars['band_email'];
	$phone = $post_vars['band_phone'];
	$details = $post_vars['band_details'];

	$bands_model->update($id,$name,$email,$phone,$details);

}

function post(){
	global $bands_model;

	$name = $_POST['band_name'];
	$email = $_POST['band_email'];
	$phone = $_POST['band_phone'];
	$details = $_POST['band_details'];

	$bands_model->insert($name, $email, $phone, $details);
	
}

function delete(){
	global $bands_model;
	
	parse_str(file_get_contents("php://input"),$post_vars);	

	$id = $post_vars['band_id'];

	$bands_model->delete($id);
}


?>