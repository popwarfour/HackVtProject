<?php
include('config/db.php');
include('models/genre_model.php');
include('config/urls.php');


function get(){
	global $db;
	global $genre_model;

	$name = $_GET['genrename'];

	print_r($genre_model->getByName($name));

//	print_r($genre_model->getById(1));


}

function put(){

}

function post(){

//	$db->execute($query);

}

function delete(){

}

?>