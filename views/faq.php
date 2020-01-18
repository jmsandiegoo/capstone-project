<?php 
 include_once __DIR__.'/../helpers/mysql.php';
 include_once __DIR__.'/../helpers/helper.php';
 $helper = new Helper();

 // Retrieving the course information
 $db = new Mysql_Driver();
 $db->connect(); 

 // Fetch the background
 $backgroundPath = '../assets/img/General/faq.png';
 $tglogoPath = '../assets/img/General/tglogo.png';
 
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
	  
    <section class="main-banner container-fluid" style="background-image: linear-gradient(rgba(0, 0, 0, 0), rgba(0, 0, 0, 0)), url(<?php echo $backgroundPath ?>);">
    </section>

    <section class="faq-content container">
        <div id="myBtnContainer-faq">
            <?php foreach ($faqResultsArray as $key => $row):?>
            <button class="collapsible"><?php echo $faqResultsArray[$key]['question_text'] ?></button>
            <div class="content">
            <p><?php echo $faqResultsArray[$key]['question_answer'] ?></p>
            </div>
            <?php endforeach; ?>
        </div>
    </section>

    <section class="faq-btn container">
        <div id="telegramWidget">
              <p>Have any other questions? Create an appointment with our course counsellors with our Telegram Chatbot by clicking on the Telegram button below!</p>
          <a class="tg-btn" href="https://t.me/npictoh_bot" target="_blank">
            <svg class="tg-btn-box" viewBox="0 0 21 18">
              <image href="<?php echo $tglogoPath; ?>" x="0" y="0" height="16px" width="16px"/>
            </svg>Chat with our bot! 
          </a>
        </div>
    </section>
</main>
<script src="<?php echo $helper->jsPath("faq.js") ?>" ></script>
<?php include $helper->subviewPath('footer.php') ?>

</html>