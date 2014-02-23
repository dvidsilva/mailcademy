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

 
$message = '/' . $t[1] . '/messages/' . $t[2];
$fb = new fireBase($firebase_url .$message, $firebase_token);

$num_homework = $fb->get('num_homework');



$email = preg_replace('/.*<|>.*|["]/', "", $fb->get('sender'));

$email = base64_encode($email);

$probar = $firebase_url.$t[1].'/'.$email.'/homeworks/'.$num_homework;


$email = new fireBase($firebase_url.$t[1] .'/'.$email, $firebase_token);

$avgstr =  '/homeworks/'.$num_homework. '/average';

$array = array();
$array['email'] = $_POST['email'];
$array['notes'] = $_POST['notes'];
$array['value'] = $_POST['grade'];
$array['name'] = $_POST['name'];

$reviewstr = 'reviews/'.base64_encode($array['email']);

$already = $fb->get($reviewstr.'/asdasdasd');

if (is_null($already) || $already === 'null') {
    echo kill();
}



$avg = ( $email->get('average') + $array['value'] ) / 2;
$email->set('average', $avg);


$avg2 = ($email->get($avgstr)+$array['value']) / 2 ;
$email->set($avgstr, $avg2);




$fb->set($reviewstr, $array);

echo $num_homework;

echo "YOUR GRADE WAS POSTED, THANKS.";
return true;
