<?php

class audio_model{

	public $db;

	function __construct($db){
		$this->db=$db;
	}

	function getAll(){
		$query = "select * from audio";
		$results = $this->db->query($query);

		return $results;
	}

}


global $db;
$audio_model = new audio_model($db);


?>