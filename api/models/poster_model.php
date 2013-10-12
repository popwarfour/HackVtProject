<?php

class poster_model{

	public $db;

	function __construct($db){
		$this->db=$db;

	}

	function add($eventid, $imgpath){
		$query = "insert into poster values(".$eventid.", '".$imgpath."')";
		$this->db->execute($query);
	}

	function getById($posterid){
	
		$query = "select event_id, scanCount from poster where id=".$posterid;
		$results=$this->db->query($query);	
		$results=$results[0];
		
	}

	function getByLatLng($lat,$lng){
		$query = "select * from poster_scanned where lat=".$lat." and lng=".$lng;
		$results = $this->db->query($query);
		$results = $results[0];

		return $results;

	}

	function insertScan($eventid, $lat, $lng){
		$query = "insert into poster_scanned values('', ".$eventid.", ".$lat.", ".$lng.", 1)";
		$this->db->execute($query);
	}

	function updateScan($id, $scanCount){
		$query = "update poster_scanned set scanCount=".$scanCount." where id=".$id;
		$this->db->execute($query);
	}


	function update($lat, $lng, $scanCount, $posterid){
		$query = "update poster set lat=".$lat.", lng=".$lng.", scanCount=".$scanCount." where id=".$posterid;	
		$this->db->execute($query);
	}

	function insert($posterid, $url, $image){
		$query = "insert into qr values('', ".$posterid.", '".$url."', '".$image."')";

		$this->db->execute($query);

	}

}


global $db;
$poster_model = new poster_model($db);


?>