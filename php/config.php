<?php

require_once './lib/firebase-php/firebaseLib.php';
require_once './lib/PHPMailer/PHPMailerAutoload.php';


$smtp['username'] = 'mailcademy@gmail.com';
$smtp['password'] = 'asdafsa777121uyasbjkasa';
$smtp['host'] = 'smtp.gmail.com';
$smtp['post'] = '465';

$notify_url = 'http://localhost/events/angelhack/fall2013/php/confirm.php';
$firebase_url = 'https://mailcademy.firebaseio.com/';
$firebase_token = 'A6RidddAqfCT5WjAHGoclHDV1YVefDkvbN5ri6ix';


