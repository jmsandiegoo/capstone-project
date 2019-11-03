<?php
?>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Interactive Digital Experience</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="<?php echo $helper->cssPath("style.css") ?>"/>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand mb-0 h1" href=<?php echo $helper->pageUrl("index.php")?>>ICT OPEN HOUSE</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNavAltMarkup">
            <div class="navbar-nav">
                <a class="nav-item nav-link" href="<?php echo $helper->pageUrl("index.php") ?>">COURSES<span class="sr-only">(current)</span></a>
                <a class="nav-item nav-link" href="<?php echo $helper->pageUrl("quiz.php") ?>">QUIZ</a>
                <a class="nav-item nav-link" href="<?php echo $helper->pageUrl("tour.php") ?>">MAP</a>
            </div>
        </div>
    </div>
</nav>