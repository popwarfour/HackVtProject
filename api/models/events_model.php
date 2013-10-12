<?php

class events_model{

	public $db;

	function __construct($db){
		$this->db=$db;

	}

	function listAllJoined(){
		$query = "select band.id as band_id, band.name as band_name, band.email as band_email, band.phone as band_phone, 
			band.details as band_details, events.id as event_id, events.name as event_name, date as event_date, ei.type as event_type, 
			genre.id as genre_id, genre.genre_name as event_genre, poster.poster_image_url, 
			qr.image_path as qr_image_path from events
			  inner join band_to_events bte on bte.fk_events_id=events.id
			  inner join band on band.id=bte.fk_band_id
			  inner join event_info ei on ei.fk_event_id=events.id
			  inner join genre on ei.genre=genre.id
			  inner join poster on poster.event_id=events.id
			  inner join qr on qr.event_id=events.id
			";


		$results = $this->db->query($query);

		return $results;
	}

	function listAll(){
		$query = "select events.name as event_name, events.location as event_location, events.city as event_city, events.date as event_date, genre.genre_name as event_genre from events inner join genre on genre.id=events.fk_genre_id";

		$this->db->query($query);

		return $results;
	}

	function getByBandId($bandid){
		$query="select events.id as event_id, name as event_name, location as event_location, city as event_city, date as event_date,
				 poster.poster_image_url from events
				inner join band_to_events bte on bte.fk_events_id=events.id
				inner join poster on poster.event_id=events.id where bte.fk_band_id=".$bandid;
				
		$results = $this->db->query($query);

		return $results;
	}

	function getById($id){
		$query = "select band.id as band_id, band.name as band_name, band.email as band_email, band.phone as band_phone, 
			band.details as band_details, events.id as event_id, events.name as event_name, date as event_date, ei.type as event_type, 
			genre.id as genre_id, genre.genre_name as event_genre, poster.id as poster_id, poster.poster_image_url, 
			qr.id as qr_id, qr.url as qr_url, qr.image_path as qr_image_path from events
			  right join band_to_events bte on bte.fk_events_id=events.id
			  right join band on band.id=bte.fk_band_id
			  right join event_info ei on ei.fk_event_id=events.id
			  right join genre on ei.genre=genre.id
			  right join poster_to_event pte on pte.fk_event_id=events.id
			  right join poster on poster.id=pte.fk_poster_id
			  right join qr on qr.fk_poster_id=poster.id
			   where events.id=".$id."
			";


		$results = $this->db->query($query);

		return $results;
	}

	function insertEventInfo($eventid, $type, $genreid){
		$query = "insert into event_info values('', ".$eventid.", 'Music', ".$genreid.")";
		$this->db->execute($query);
	}


	function insert($name, $location, $city, $date, $genre){
		global $genre_model;
		global $poster_model;

		$genres = $genre_model->getByName($genre);

		if(sizeof($genres) ==0 && $genre!=""){
			$genre_model->insert($genre);
			$genres =$genre_model->getByName($name);
			$genreid = $genres['id'];	
		}else{
			$genreid = null;
		}	
		
		$query = "insert into events values('', '".$name."', '".$location."', '".$city."', '".$date."', '".$genreid."', '".$description."')";
		$eventid= $this->db->execute($query);

		//Image stuff
		$output_dir = "../img_uploads/";
		var_dump($_FILES);
		
		if(isset($_FILES["myFile"])){
			$filename = $eventid.".jpg";
		  move_uploaded_file($_FILES["myFile"]["tmp_name"], $output_dir.$filename);
			// echo $output_dir.$_FILES['myFile']['name'];
		}

		if(isset($_POST['band_id'])){
			$query = "insert into band_to_events values(".$_POST['band_id'].",".$eventid.")";
			$this->db->execute($query);
			$poster_model->add($eventid, $filename);
		}

		return $eventid;
	}



	function getByName($name){
		$query = "select * from genre where genre_name='".$name."'";

		$results = $this->db->query($query);

		return $results[0];
	}

}


global $db;
$events_model = new events_model($db);


?>