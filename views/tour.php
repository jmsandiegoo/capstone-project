<?php 
    include_once __DIR__.'/../helpers/helper.php';
    $helper = new Helper();
?>

<!DOCTYPE html>
<html lang="en">
    <?php include $helper->subviewPath('navbar.php')?>
    <?php include $helper->subviewPath('header.php')?>
    <main class="container">
        <h4 class="text-center">Map</h4>
        <img src='../assets/img/tourmap/TourMap.png' alt="Tour Map" width="100%" height="100%">
    </main>
    <?php include $helper->subviewPath('footer.php') ?>

</html>