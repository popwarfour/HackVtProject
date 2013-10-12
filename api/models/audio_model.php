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

	function getByEventId($id){
		$query = "select audio_url, title as audio_title from audio
					left join audio_to_event ate on ate.fk_audio_id=audio.id where ate.fk_event_id=".$id;

		$results = $this->db->query($query);

		return $results;
	}

	function attachAudioToEvent($audioid, $eventid){
		$query = "insert into audio_to_event values(".$audioid.", ".$eventid.")";

		$this->db->execute($query);
	}

}


global $db;
$audio_model = new audio_model($db);


?>