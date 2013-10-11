<?php

$dbname = "hackvt";
$host = "localhost";
$user = "root";
$pass = "root";

// Connecting, selecting database
$con = mysql_connect($host, $user, $pass)
    or die('Could not connect: ' . mysql_error());

mysql_select_db($dbname) or die('Could not select database');

?>