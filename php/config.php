<?php

require_once './lib/firebase/firebaseLib.php';
// https://github.com/ktamas77/firebase-php/blob/master/firebaseTest.php
// https://mailcademy.firebaseio.com/
// http://localhost/events/angelhack/fall2013/php/notify.php
require_once './lib/MAIL/PHPMailerAutoload.php';


$smtp['username'] = 'mailcademy@gmail.com';
$smtp['password'] = 'asdafsa777121uyasbjkasa';
$smtp['host'] = 'smtp.gmail.com';
$smtp['port'] = '465';

$notify_url = 'http://mailcademy.gopagoda.com/php/confirm.php';
$firebase_url = 'https://mailcademy.firebaseio.com/';
$firebase_token = 'A6RidddAqfCT5WjAHGoclHDV1YVefDkvbN5ri6ix';


