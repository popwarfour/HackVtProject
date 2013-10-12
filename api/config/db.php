<?php

class Database{
	
	public $app;
	public $con;
	public $pdo;
	public $host;
	public $user;
	public $pass;
	public $db;


	function __construct($host, $user, $pass, $db){
		$this->host = $host;
		$this->user = $user;
		$this->pass = $pass;
		$this->db = $db;
	}

	function connect(){

		$this->con = mysql_connect($this->host, $this->user, $this->pass);	
		mysql_select_db($this->db, $this->con) or die(mysql_error());

		// Check connection
		if (mysqli_connect_errno($this->con)){
			echo "Failed to connect to MySQL: " . mysqli_connect_error();
		}
	}

	public function query($string){
		$this->connect();

		$result=mysql_query($string);

		if (!$result) {
		    $message  = 'Invalid query: ' . mysql_error() . "\n";
		    $message .= 'Whole query: ' . $string;
		    die($message);
		}

		mysql_close($this->con);

		//Fetch all rows and place in return val
		$returnVal = array();
		$i=0;
		while($row = mysql_fetch_assoc($result)){
			$returnVal[$i]=$row;
			$i++;

		}

		return ($returnVal);	
	}

	//execute(): same as query except does not return results
	public function execute($string){
		$this->connect();

		$result=mysql_query($string);

		if (!$result) {
		    $message  = 'Invalid query: ' . mysql_error() . "\n";
		    $message .= 'Whole query: ' . $string;
		    die($message);
		}

		$id = mysql_insert_id($this->con);


		mysql_close($this->con);

		return $id;
	}

}

$dbname = "hackvt";
$host = "localhost";
$user = "root";
$pass = "root";


$db = new Database($host, $user, $pass, $dbname);
//$db->query("select * from events");
// Connecting, selecting database
//con = mysql_connect($host, $user, $pass)
   // or die('Could not connect: ' . mysql_error());

//mysql_select_db($dbname) or die('Could not select database');

?>