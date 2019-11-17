<?php 
    include_once __DIR__.'/../helpers/helper.php';
    $helper = new Helper();
    
?>

<!DOCTYPE html>
<html lang="en">
    <?php include $helper->subviewPath('header.php') ?>
    <main class="container appointment-selection-wrapper">
        <h1>Welcome to ICT Open House Appointment</h1>
        <h2>Please Select User Type:</h2>
        <button class="btn btn-primary">Guest</button>
        <button class="btn btn-success">Teacher</button>
    </main>
    <?php include $helper->subviewPath('footer.php') ?>

</html>