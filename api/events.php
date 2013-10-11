<?php
include('config/db.php');
include('config/urls.php');



function get(){

	global $db;
	$query = "select * from events";
	$results = $db->query($query);

	

	print_r($results);


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