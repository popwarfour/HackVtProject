<?php

class events_model{

	public $db;

	function __construct($db){
		$this->db=$db;

	}

	function listAll(){
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


	function getById($id){
		$query = "select band.id as band_id, band.name as band_name, band.email as band_email, band.phone as band_phone, 
			band.details as band_details, events.id as event_id, events.name as event_name, date as event_date, ei.type as event_type, 
			genre.id as genre_id, genre.genre_name as event_genre, poster.id as poster_id, poster.poster_image_url, 
			qr.id as qr_id, qr.url as qr_url, qr.image_path as qr_image_path from events
			  inner join band_to_events bte on bte.fk_events_id=events.id
			  inner join band on band.id=bte.fk_band_id
			  inner join event_info ei on ei.fk_event_id=events.id
			  inner join genre on ei.genre=genre.id
			  inner join poster_to_event pte on pte.fk_event_id=events.id
			  inner join poster on poster.id=pte.fk_poster_id
			  inner join qr on qr.fk_poster_id=poster.id
			   where events.id=".$id."
			";


		$results = $this->db->query($query);

		return $results;
	}

	function insert($name, $location, $city, $date, $genre){
		global $genre_model;

		$genres = $genre_model->getByName($genre);

		if(sizeof($genres) ==0){
			$genre_model->insert($genre);
			$genres =$genre_model->getByName($name);
		}
		$genreid = $genres['id'];

		$query = "insert into events values('', '".$name."', '".$location."', '".$city."', '".$date."', '".$genreid."', '".$description."')";
		$eventid= $this->db->execute($query);

		
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