<?php 
    include_once __DIR__.'/../helpers/mysql.php';
    include_once __DIR__.'/../helpers/helper.php';
    $helper = new Helper();
	/*  $id = $_GET['id'];
    // Retrieving the course information
    $db = new Mysql_Driver();
    $db->connect(); 
    $sql = "SELECT * FROM Course WHERE id=$id";
    $courseInfoResult = $db->query($sql);
    $courseInfo = [];
    while ($row = $db->fetch_array($courseInfoResult)) {
      $courseInfo[] = $row;
    }
    $courseInfo = $courseInfo[0];*/
?>
<!DOCTYPE html>
<html lang="en">
<?php include $helper->subviewPath('header.php') ?> 
    <main class="project-wrapper">
     <section class="main-banner container-fluid">
        <h1>
          Project Name 
        </h1>
      </section>

          </br>
        <!--  !-->
        
        </section>
			<section class="project-content container">
        <h1>Project Portfolio</h1>
        <div id="projectSlider" class="carousel slide" data-ride="carousel">
        <ul class="carousel-indicators">
          <li data-target="#projectSlider" data-slide-to="0" class="active"></li>
          <li data-target="#projectSlider" data-slide-to="1"></li>
          <li data-target="#projectSlider" data-slide-to="2"></li>
        </ul>
        <div class="carousel-inner">
        <div class="carousel-item active">
          <img src="../assets/img/FI/BG_1.jpg"  />      
            <div class="carousel-caption">
            <h3>This is a test only.</h3>
        </div>
        <div class="carousel-item">
          <img src="../assets/img/IM/BG_1.jpg"  />    
            <div class="carousel-caption">
            <h3>This is a test only.</h3>
        </div>
        <div class="carousel-item">
          <img src="../assets/img/IT/BG_1.jpg"  />    
            <div class="carousel-caption">
            <h3>This is a test only.</h3>
        </div>

        <a class="carousel-control-prev" href="#projectSlider" data-slide="prev">
          <span class="carousel-control-prev-icon"></span>
        </a>
        <a class="carousel-control-next" href="#projectSlider" data-slide="next">
          <span class="carousel-control-next-icon"></span>
        </a>
      </div>
      </div>
			</section>
    </main>
    <?php include $helper->subviewPath('footer.php') ?>
</html>