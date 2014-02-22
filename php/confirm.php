<?php
require_once './config.php';
require_once './functions.php';

if (!isset($_POST['token'])) {
    kill();
}
$token =  $_POST['token'];


$token = explode('AA=|=AA', $token);
$m = explode('|=AB=|', $token[1]);
$m = base64_decode($m[0]);
$t = explode('|', $m);

if ($t[0] !== $_POST['email']) {
    kill();
}



// agregar el avg acá

$message = '/' . $t[1] . '/messages/' . $t[2];
$fb = new fireBase($firebase_url .$message, $firebase_token);

$array = array();
$array['email'] = $_POST['email'];
$array['notes'] = $_POST['notes'];
$array['value'] = $_POST['grade'];
$array['name'] = $_POST['name'];


$fb->set('reviews/'.base64_encode($array['email']), $array);



echo "YOUR GRADE WAS POSTED, THANKS.";
return true;
