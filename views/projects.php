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

    // Retrieving the project's course information
    $sql = "SELECT * FROM Course WHERE id=".$projectInfo['id'];
    $projectCourseResult = $db->query($sql);
    $projectCourse = [];
    while ($row = $db->fetch_array($projectCourseResult)) {
      $projectCourse[] = $row;
    }
    $projectCourse = $projectCourse[0];

    // Fetch the background
    $sql = "SELECT * FROM Item WHERE project_id = " . $id;
    $projectItemResult = $db->query($sql);
    $row = $db->fetch_array($projectItemResult);
    $projectImagePath = '../' . $row['item_path'];
?>

<!DOCTYPE html>
<html lang="en">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
    
<?php include $helper->subviewPath('header.php') ?> 
<meta name="viewport" content="width=device-width, initial-scale=1">
    <main class="project-wrapper">
      <?php include $helper->subviewPath('navbar.php') ?>  

      <!--<section class="main-banner container-fluid" style="background-image: linear-gradient(rgba(0, 0, 0, 0.25), rgba(0, 0, 0, 0.25)), url(<?php //echo $backgroundPath ?>);">
      <section class="main-banner container-fluid" style="background-image: linear-gradient(rgba(0, 0, 0, 0.25), rgba(0, 0, 0, 0.25))"> 
        <h1>
          <?php //echo $projectInfo['project_name']; ?>  
        </h1>
      </section>-->
<!--https://getbootstrap.com/docs/4.0/layout/grid/-->
      <section class="project-content container">
        <div class="projectContainer">
          <div class="row"> 

            <div class="col-md-6 project-left">
                <h1><?php echo $projectInfo['project_name']; ?></h1>
                <p style="font-style:italic;"><?php echo $projectCourse['course_name']; ?></p>
                <p><?php echo $projectInfo['project_desc']; ?></p>
            </div>
            <div class="col-md-6 project-right">
                <div class="project-image">
                  <img style="max-height:80% " src="<?php echo $projectImagePath; ?>" class="img-fluid" alt="Responsive image">
                </div>
            </div>

          </div> 
        </div>
      </section>
      
    </main>
    
    <script src="<?php echo $helper->jsPath("projects.js") ?>" ></script>
    <?php include $helper->subviewPath('footer.php') ?>
</html>