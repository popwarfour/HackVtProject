<?php

class qr_model{

	public $db;

	function __construct($db){
		$this->db=$db;

	}

	function getByPosterId($posterid){
	
		$query = "select id as qr_id, fk_poster_id as poster_id, url as qr_url, image_path from qr where fk_poster_id=".$posterid;

		$results =$this->db->query($query);

		return $results[0];
	}

	function getScans(){
		$query = "select fk_event_id as event_id, lat, lng, scanCount from poster_scanned";
		$results=$this->db->query($query);
		return $results;
	}


	function insert($posterid, $url, $image){
		$query = "insert into qr values('', ".$posterid.", '".$url."', '".$image."')";

		$this->db->execute($query);

	}

}


global $db;
$qr_model = new qr_model($db);


?>