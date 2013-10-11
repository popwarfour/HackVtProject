<?php

class Error{

	public $status_code;
	public $data;

	function __construct($status, $data){
		$this->status_code = $status;
		$this->data = $data;
	}
}

?>