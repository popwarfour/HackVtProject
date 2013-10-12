<?php

class bands_model{

	public $db;

	function __construct($db){
		$this->db=$db;

	}

	function listAll(){
	
		$query = "select id as band_id, name as band_name, details as band_details, email as band_email, phone as band_phone from band";
		$results = $this->db->query($query);

		return $results;
	}

	function update($id, $name, $email, $phone, $details){

		$query = "update band set
				  name='".$name."',
				  details='".$details."',
				  email='".$email."',
				  phone='".$phone."' where id=".$id;

		$this->db->execute($query);
	}

	function insert($name, $email, $phone, $details){
		$query = "insert into band values('', '".$name."', '".$details."', '".$email."', '".$phone."')";
		$this->db->execute($query);
	}

	function delete($id){
		$query = "delete from bands where id=".$id;
		$this->db->execute($query);
	}


}


global $db;
$bands_model = new bands_model($db);


?>