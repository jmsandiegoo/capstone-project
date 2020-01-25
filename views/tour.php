<?php 
 include_once __DIR__.'/../helpers/mysql.php';
 include_once __DIR__.'/../helpers/helper.php';
 $helper = new Helper();

 // Retrieving the course information
 $db = new Mysql_Driver();
 $db->connect(); 

 // Fetch the background
 
 //Fetch tours
 $sql = "SELECT j.*, i.item_path FROM Journey j INNER JOIN Item i ON j.journey_id = i.journey_id ";
    $result = $db->query($sql);
    $Journey = [];
    while ($row = $db->fetch_array($result)) {
        $Journey[] = $row;
    }
    
 $db->close();
?>

<!DOCTYPE html>
<html lang="en">
<?php include $helper->subviewPath('header.php') ?>
<head>
</head>
<main class="tour-wrapper">
    <?php include $helper->subviewPath('navbar.php') ?>
	  
    

    <section class="tour-content container">
        <div id="myBtnContainer-tour">
            <?php foreach ($Journey as $key => $row):?>
            <div class="colle">
            <button class="collapsible"><?php echo $row["journey_id"]. ". " .$row['title'] ?></button>
            <div class="content tour">
            <p><?php echo $row['checkpoint_desc'] ?></p>
            <br/>
            <img class="img-fluid tour" src="../<?php echo $row["item_path"]?>"></img>
            <br/>
            </div>
            </div>
            <?php endforeach; ?>
    </section>
</main>
<script src="<?php echo $helper->jsPath("faq.js") ?>" ></script>
<?php include $helper->subviewPath('footer.php') ?>

</html>