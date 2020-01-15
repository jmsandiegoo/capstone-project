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
        <div id="myBtnContainer">
            <?php foreach ($faqResultsArray as $key => $row):?>
            <button class="collapsible"><?php echo $faqResultsArray[$key]['question_text'] ?></button>
            <div class="content">
            <p><?php echo $faqResultsArray[$key]['question_answer'] ?></p>
            </div>
            <?php endforeach; ?>
        </div>
    </section>

    <section class="faq-content container">
        <div id="telegramWidget">
          <a style="display:block;font-size:16px;font-weight:500;text-align:center;border-radius:8px;padding:5px;background:#389ce9;text-decoration:none;color:#fff;" href="https://t.me/npictoh_bot" target="_blank">
            <svg style="width:30px;height:20px;vertical-align:middle;margin:0px 5px;" viewBox="0 0 21 18">
              <image href="<?php echo $tglogoPath; ?>" x="0" y="0" height="16px" width="16px"/>
            </svg>Chat with our bot!
          </a>
        </div>
    </section>
</main>
<script src="<?php echo $helper->jsPath("faq.js") ?>" ></script>
<?php include $helper->subviewPath('footer.php') ?>
<style>
.collapsible {
  background-color: #777;
  color: white;
  cursor: pointer;
  padding: 18px;
  width: 100%;
  border: none;
  text-align: left;
  outline: none;
  font-size: 15px;
}

.active, .collapsible:hover {
  background-color: #555;
}

.collapsible:after {
  content: '\002B';
  color: white;
  font-weight: bold;
  float: right;
  margin-left: 5px;
}

.active:after {
  content: "\2212";
}

.content {
  padding: 0 18px;
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.2s ease-out;
  background-color: #f1f1f1;
}
</style>
</html>