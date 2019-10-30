<?php 
    // echo __DIR__ . '/../../index.php';

    // echo $_SERVER["REQUEST_URI"] . "</br>";
    // echo $_SERVER["SERVER_NAME"] . "</br>";
    // echo $_SERVER["HTTP_HOST"];

    // null if index.php
    function dynamicLink($file) {
        $httpProtocol = !isset($_SERVER['HTTPS']) || $_SERVER['HTTPS'] != 'on' ? 'http' : 'https';
        $url = $httpProtocol . '://' . $_SERVER['HTTP_HOST'] . '/capstone-project/';
        if ($file !== 'index.php') {
            $url .= 'views/' . $file;
        }
        return $url;
    }
?>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Interactive Digital Experience</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand mb-0 h1" href=<?php echo dynamicLink('index.php') ?>>ICT Open House</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNavAltMarkup">
            <div class="navbar-nav">
                <a class="nav-item nav-link" href="<?php echo dynamicLink("index.php") ?>">Courses<span class="sr-only">(current)</span></a>
                <a class="nav-item nav-link" href="<?php echo dynamicLink("quiz.php") ?>">Course Quiz</a>
                <a class="nav-item nav-link" href="<?php echo dynamicLink("tour.php") ?>">Tour Map</a>
            </div>
        </div>
    </div>
</nav>