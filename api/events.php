<?php
include('config/db.php');
include('config/urls.php');



function get(){
	global $db;

	$query = "select band.name as band_name, band.email as band_email, band.phone as band_phone, events.name as event_name, date as event_date, ei.type as event_type, genre.genre_name as event_genre, poster.poster_image_url, 
			 qr.url as qr_url, qr.image_path as qr_image_path from events
			  inner join band_to_events bte on bte.fk_events_id=events.id
			  inner join band on band.id=bte.fk_band_id
			  inner join event_info ei on ei.fk_event_id=events.id
			  inner join genre on ei.genre=genre.id
			  inner join poster_to_event pte on pte.fk_event_id=events.id
			  inner join poster on poster.id=pte.fk_poster_id
			  inner join qr_to_event qte on qte.fk_event_id=events.id
			  inner join qr on qte.fk_qr_id=qr.id
			";


	$results = $db->query($query);

	$status =  Array("status_code"=>200);
	array_unshift($results, $status);
	$results = json_encode($results);

	echo $results;
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