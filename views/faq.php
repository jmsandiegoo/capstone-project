<?php 
 include_once __DIR__.'/../helpers/mysql.php';
 include_once __DIR__.'/../helpers/helper.php';
 $helper = new Helper();

 // Retrieving the course information
 $db = new Mysql_Driver();
 $db->connect(); 

 // Fetch the background
 $backgroundPath = '../assets/img/General/FAQ.png';
 $tglogoPath = '../assets/img/General/tglogo.png';
 $tgbtnPath = '../assets/img/General/tgbtn.png';
 
 //Fetch FAQs
 $sql = "SELECT * FROM FAQ";
    $faqResults = $db->query($sql);
    $faqResultsArray = [];
    while ($row = $db->fetch_array($faqResults)) {
        $faqResultsArray[] = $row;
    }
//    print_r($faqResultsArray);
//    echo "</br></br>" .$faqResultsArray[0]['question_id'];
    
 $db->close();
?>

<!DOCTYPE html>
<html lang="en">
<?php include $helper->subviewPath('header.php') ?>
<head>
</head>
<main class="faq-wrapper">
    <?php include $helper->subviewPath('navbar.php') ?>
    <section class="main-banner faq container-fluid" style="background-image: linear-gradient(rgba(0, 0, 0, 0), rgba(0, 0, 0, 0)), url(<?php echo $backgroundPath ?>);">
    </section>

    <section class="faq-content container">
        <div id="myBtnContainer-faq">
            <?php foreach ($faqResultsArray as $key => $row):?>
            <div class="colle">
                <button class="collapsible faq"><b><?php echo $row['question_text'] ?></b></button>
                <div class="content">
                    <h5><?php echo $row['question_answer'] ?></h5>
                </div>
            </div></br>
            <?php endforeach; ?>
        </div>
        <div class="tele-button align-items-center">
        </div> 
        <!-- <div class="row"> 
            <div class="col-lg-4">
            </div>
            <div class="col-lg-4 telegram-button">
                <a class="tg-btn" href="https://t.me/npictoh_bot"><img src="<?php echo $tgbtnPath; ?>" width="70%"/></a>
            </div>
            <div class="col-lg-4">
            </div>
        </div> -->
    </section>
</main>
<script src="<?php echo $helper->jsPath("faq.js") ?>" ></script>
<?php include $helper->subviewPath('footer.php') ?>

</html>