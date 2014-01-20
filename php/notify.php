<?php

require_once './config.php';
require_once './functions.php';

$fb = new fireBase($firebase_url, $firebase_token);

$message = explode('/', 'cs169/messages/19992');

$class = $fb->get($message[0]);
$class = json_decode($class, true);




$top = count($class['emails']) >= 3 ? 3 : count($class['emails']);


$sendto = array_rand($class['emails'], $top);


$subject = 'MAILCADEMY: New Homework to grade in '.$message[0];

$array = array();
$array['classname'] = $message[0];
$array['notify_url'] = $notify_url;
$array['content'] = $class['messages'][$message[2]]['text'];
$array['attachments'] = $class['messages'][$message[2]]['attachments'];
if (is_array($array['attachments'])) {
    foreach ($array['attachments'] as $arr) {
        $t = '<p><a href="'.$arr.'" >'.$arr.'</a></p>';
    }
} else {
    $t = '';
}
$array['attachments'] = $t;

foreach ($sendto as $mail) {
    $str = $class['emails'][$mail]['email'] . $message[0] . $message[2];
    $hx = str2hex($str);
    $array['token'] = base64_encode($hx.$str.$hx)."|=AB=|".time();
    $array['name'] = $class['emails'][$mail]['name'];
    $array['email'] =  $class['emails'][$mail]['email'];
    $body =  parse_template($array, 'form.html');
    notify($body, $subject, $array, $smtp);
}
