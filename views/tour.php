<?php 
    include_once __DIR__.'/../helpers/helper.php';
    $helper = new Helper();
?>

<!DOCTYPE html>
<html lang="en">
    <?php include $helper->subviewPath('navbar.php')?>
    <?php include $helper->subviewPath('header.php')?>
    <main class="container">
        <h1 class="text-center">Map</h1>
        <img src='../assets/img/tourmap/TourMap.png' alt="Tour Map">
    </main>
    <?php include $helper->subviewPath('footer.php') ?>

</html>