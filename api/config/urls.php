<?php

//Get the request type, ie GET PUT POST DELETE
$request = $_SERVER['REQUEST_METHOD'];

switch($request){
	case "GET":
		get();
		break;

	case "PUT":
		put();
		break;

	case "POST":
		post();
		break;

	case "DELETE":
		delete();
		break;
}

mysql_close($con);

?>