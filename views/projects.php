<?php 
    include_once __DIR__.'/../helpers/mysql.php';
    include_once __DIR__.'/../helpers/helper.php';
    $helper = new Helper();
    $id = $_GET['id'];
    
    $db = new Mysql_Driver();
    $db->connect(); 
    
    // Retrieving the project information
    $sql = "SELECT * FROM Project WHERE project_id=$id";
    $projectInfoResult = $db->query($sql);
    $projectInfo = [];
    while ($row = $db->fetch_array($projectInfoResult)) {
      $projectInfo[] = $row;
    }
    $projectInfo = $projectInfo[0];

    // Fetch the background
    $sql = "SELECT * FROM Item WHERE project_id = " . $id;
    $projectItemResult = $db->query($sql);
    $row = $db->fetch_array($projectItemResult);
    $projectImagePath = '../' . $row['item_path'];
?>
<!DOCTYPE html>
<html lang="en">
<?php include $helper->subviewPath('header.php') ?> 
    <main class="project-wrapper">
      <?php include $helper->subviewPath('navbar.php') ?>  
      <!--<section class="main-banner container-fluid" style="background-image: linear-gradient(rgba(0, 0, 0, 0.25), rgba(0, 0, 0, 0.25)), url(<?php //echo $backgroundPath ?>);">-->
      <section class="main-banner container-fluid" style="background-image: linear-gradient(rgba(0, 0, 0, 0.25), rgba(0, 0, 0, 0.25))"> 
        <h1>
          <?php echo $projectInfo['project_name']; ?>  
        </h1>
      </section>
      <body>
      <section class="project-image container">
        <div class="project-content">
          <div class="project-product">
            <img src="<?php echo $projectImagePath ?>" class="img-fluid" alt="Responsive image">
          </div>
        </div>
      </section>
      <section class="project-description container">
            <?php echo $projectInfo['project_desc']; ?>  
      </section>
      <section class="project-popup">
        <div class="project-popup-div">
          <div class="project-content">
            <a style="color: #f00;display: block;position: absolute;text-decoration: navajowhite;transform: rotate(45deg);font-size: 50px;right: 10px;top: 10px;">+</a>
            <strong>Section 1.10.32 of "de Finibus Bonorum et Malorum", written by Cicero in 45 BC</strong>
            <br />
            "a"
            <strong>1914 translation by H. Rackham</strong><br />
            "b"
          </div>
        </div>
      </section>
      </body>
    </main>
    
    <script src="<?php echo $helper->jsPath("projects.js") ?>" ></script>
    <?php include $helper->subviewPath('footer.php') ?>
</html>