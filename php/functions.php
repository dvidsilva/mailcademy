<?php
function parse_template($array,$file)
{
    if (file_exists($file)) {
        $template = file_get_contents($file);
    } else {
        return false; //$file.' not found';
    }

    if (is_array($array)) {
        foreach (array_keys($array) as $v) {
            $w[] = "/\[#".$v."#\]/";
        }
        $c = preg_replace($w, $array, $template);
    }
    return($c);
}

function hex2str($hex)
{
    return pack('H*', $hex);
}

function str2hex($str)
{
    $arr = unpack('H*', $str);
    return array_shift($arr);
}



function notify($body, $subject, $array, $smtp)
{
    $mail = new PHPMailer;
    $mail->isSMTP();                                      // Set mailer to use SMTP
    $mail->Host = $smtp['host'];
    $mail->SMTPAuth = true;
    $mail->Username = $smtp['username'];
    $mail->Password = $smtp['password'];
    $mail->SMTPSecure = 'tls';

    $mail->From = 'mailcademy@gmail.com';
    $mail->FromName = 'MailCademy [#'.$array["classname"].']';
    $mail->addAddress($array['email'], $array['name']);  // Add a recipient
    $mail->addReplyTo('mailcademy@gmail.com', 'MailCademy');

    $mail->WordWrap = 50;                                 // Set word wrap to 50 characters
    $mail->isHTML(true);                                  // Set email format to HTML

    $mail->Subject = $subject;
    $mail->Body    = $body;
    $mail->AltBody = "There's a new homework for you to grade in a class you're participating.";
    $mail->SMTPDebug = 1;
    if (!$mail->send()) {
         echo 'Message could not be sent.';
         echo 'Mailer Error: ' . $mail->ErrorInfo;
         return false;
    }
    return true;
}


function kill()
{
    echo "UNAUTHORIZED ATTEMPT TO MODIFY SOMETHING, DIALING POLICE NOW";
    echo '<iframe width="640" height="480" src="//www.youtube.com/embed/dQw4w9WgXcQ?rel=0" frameborder="0" allowfullscreen></iframe>';
    exit;
}
function killapi($status='fail', $message = 'shit')
{
    $response = [];
    header('Content-Type: application/json');
    $res['status'] = $status;
    $res['message'] = $message;
    echo json_encode($res);
    exit;
}
