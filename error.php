<?php 
$status = $_SERVER['REDIRECT_STATUS'];
$codes = array(
    403 => array('403', 'Forbidden','The server has refused to fulfill
    your request.'),
    404 => array('404', 'Not Found', 'The document/file requested was not 
    found on this server.'),
    405 => array('405', 'Method Not Allowed', 'The method specified in 
    the Request-Line is not allowed for the specified resuource.'),
    408 => array('408', 'Request Timeout','Your browser failed to send a 
    request in the time allowed by the server'),
    500 => array('500', 'Internal Server Error','The request was unsuccessful 
    response due to an unexpected condition encountered by the server.'),
    502 => array('502', 'Bad Gateway','The server received an invalid response 
    from the upstream server while trying to fulfill the request.'),
    504 => array('504', 'Gateway Timeout','The upstream server failed to send 
    a request in the time allowed by the server.'),
);

$title = $codes[$status][0];
$description = $codes[$status][1];
$message = $codes[$status][2];

if($title == false || strlen($status) != 3) {
    $title = '431';
    $description = 'Unrecognized Status Code';
    $message = 'The website returned an unrecognized status code.';
}
?>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title><?php echo $title; ?></title>
        <!-- Google font -->
        <link href="https://fonts.googleapis.com/css?family=Oswald:700" rel="stylesheet">
	    <link href="https://fonts.googleapis.com/css?family=Lato:400" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="error.css"/>    
        </head>
    <body>
    <div id="notfound">
		<div class="notfound-bg">
			<div></div>
			<div></div>
			<div></div>
			<div></div>
		</div>
		<div class="notfound">
			<div class="notfound-404">
				<h1><?php echo$title; ?></h1>
			</div>
			<h2><?php echo$description; ?></h2>
			<p><?php echo$message; ?></p>
			<a href="#">Homepage</a>
		</div>
	</div>
    </body>
</html>