<?php
//include('config/db.php');

class genre_model{

	public $db;

	function __construct($db){
		$this->db=$db;
	}

	function getById($id){
		$query = "select * from genre where id=".$id;

		$results = $this->db->query($query);

		return $results[0];
	}

	function getByName($name){
		$query = "select * from genre where genre_name='".$name."'";

		$results = $this->db->query($query);

		return $results[0];
	}

	function insert($name){
		$query = "insert into genre values('', '".$name."')";
		$this->db->execute($query);
	}

}


global $db;
$genre_model = new genre_model($db);



?>