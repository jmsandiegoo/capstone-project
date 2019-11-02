<?php 
    include_once __DIR__.'/helpers/helper.php';
    $helper = new Helper();
?>

<!DOCTYPE html>
<html lang="en">
    <?php include $helper->subviewPath('header.php') ?>
    <main class="container">
        <header>
            <h1>Fullscreen Landing Page</h1>
        </header>
        <section class="courses">
            <div class="row justify-content-center">
                <div class="col-xs-6 col-md-4 bg-primary">Course 1</div>
                <div class="col-xs-6 col-md-4 bg-primary">Course 2</div>
                <div class="col-xs-6 col-md-4 bg-primary">Course 3</div>
                <div class="col-xs-6 col-md-4 bg-primary">Course 4</div>
                <div class="col-xs-6 col-md-4 bg-primary">Course 5</div>
            </div>

        </section>
    </main>

    <?php include $helper->subviewPath('footer.php') ?>
</html>