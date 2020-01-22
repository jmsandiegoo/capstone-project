<?php 
    include_once __DIR__.'/../helpers/mysql.php';
    include_once __DIR__.'/../helpers/helper.php';
    $helper = new Helper();
	$id = $_GET['id'];
    // Retrieving the course information
    $db = new Mysql_Driver();
    $db->connect(); 
    $sql = "SELECT * FROM Course WHERE id=$id";
    $courseInfoResult = $db->query($sql);
    $courseInfo = [];
    while ($row = $db->fetch_array($courseInfoResult)) {
      $courseInfo[] = $row;
    }
    $courseInfo = $courseInfo[0];

    // Fetch the background
    $sql = "SELECT * FROM Item WHERE course_id = " . $id . " AND item_path LIKE '%BG_1.jpg'";
    $courseItemResult = $db->query($sql);
    $row = $db->fetch_array($courseItemResult);
    $backgroundPath = '../' . $row['item_path'];

    // Fetch Category Jobs
    $sql = "SELECT j.job_name FROM Job j INNER JOIN CourseJob cj ON j.job_id = cj.job_id WHERE cj.id = $id";
    $jobNameResults = $db->query($sql);
    $jobName = [];
    while ($row = $db->fetch_array($jobNameResults)) {
        $jobName[] = $row;
    }

    // Retrieving the project information
    $projectImage = [];
    $db = new Mysql_Driver();
    $db->connect(); 
    $sql = "SELECT * FROM Item i INNER JOIN Project p ON i.project_id = p.project_id WHERE p.id=$id";
    $projectInfoResult = $db->query($sql);
    $projectInfo = [];
    while ($row = $db->fetch_array($projectInfoResult)) {
      $projectInfo[] = $row;
    }
    foreach ($projectInfo as $key => $row){
      $projectImage[] = $row["item_path"];
    }

    // Fetch Module_Year for IT Courses
    $sql = "SELECT DISTINCT module_year FROM CourseModule WHERE id=$id ORDER BY module_year ASC";
    $moduleYearResult = $db->query($sql);
    $moduleYear = [];
    while ($row = $db->fetch_array($moduleYearResult)) {
        $moduleYear[] = $row;
    }
    

    $courseModule = [];
    foreach ($moduleYear as $key => $row) {
        $sql = "SELECT m.module_id, m.module_name, i.item_path FROM Module m INNER JOIN CourseModule cm ON m.module_id = cm.module_id INNER JOIN Item i ON m.module_id = i.module_id WHERE cm.id = $id AND cm.module_year ='$row[module_year]' ORDER BY module_name ASC";
        $courseModuleResult = $db->query($sql);
        $modules= [];
        while ($row2 = $db->fetch_array($courseModuleResult)) {
            $sql = "SELECT j.job_name FROM Module m INNER JOIN CourseModule cm ON m.module_id = cm.module_id INNER JOIN ModuleJob mj ON mj.module_id=m.module_id INNER JOIN Job j ON j.job_id=mj.job_id WHERE cm.id=$id AND m.module_id='$row2[module_id]'ORDER BY module_name ASC";
            $jobResult = $db->query($sql);
            $jobArray = [];
            while ($row3 = $db->fetch_array($jobResult)) {
                array_push($jobArray, $row3['job_name']);
            }
            $row2['job_string'] = implode(",", $jobArray);
            $modules[] = $row2;
        }
        $courseModule["$row[module_year]"] = $modules;
    }

    $db->close();

    // echo '<pre>';
    // print_r($courseModule);
    // echo '</pre>';
    // Fetch the module name to display for each courses
?>

<!DOCTYPE html>
<html lang="en">
<?php include $helper->subviewPath('header.php') ?>

<main class="module-wrapper">
    <?php include $helper->subviewPath('navbar.php') ?>
	  
    <section class="main-banner container-fluid" style="background-image: linear-gradient(rgba(0, 0, 0, 0.25), rgba(0, 0, 0, 0.25)), url(<?php echo $backgroundPath ?>);">
        <div>
            <h1>Diploma in <br/> <?php echo $courseInfo['course_name']?></h1>
            <h3>Modules & Projects</h3>
        </div>
    </section>

    <section class="module-content container">
        <!-- Job Links Links -->
        <div id="myBtnContainer">
            <div class="filters">
            <button class="btn filter-btn active" onclick="filterSelection('all')">Show All</button>
                <?php foreach ($jobName as $key => $row): ?>
                    <button class="btn filter-btn" onclick="filterSelection('<?php echo $row['job_name'] ?>')"><?php echo $row['job_name'] ?></button>
                <?php endforeach; ?>
            </div>
            <div class="fade-overlay"></div>
        </div>
            <!-- Tab Year Links -->
        <div id="tabContainer">
            <div class="tabs">
                <?php foreach ($moduleYear as $key => $row): 
                    $tablinkLbl = 'Elective';

                    if ($row['module_year'] !== 'Elective') {
                        $tablinkLbl = 'Year ' . $row['module_year'];
                    }
                ?>
                    <button class="btn tab-link" onclick="openTab('<?php echo 'year-'.$row['module_year'] ?>')"><b><?php echo $tablinkLbl ?></b></button>
                <?php endforeach; ?>
            </div>

            <div class="tab-contents">
            <?php foreach ($moduleYear as $key => $row):
                $contentYear = "Elective";

                $desc = "";
				if ($row['module_year'] === '1') {
                    $desc = $courseInfo['course_year1_description'];
                }
                else if ($row['module_year'] === '2') {
                    $desc = $courseInfo['course_year2_description'];
                }
                else if ($row['module_year'] === '3') {
                    $desc = $courseInfo['course_year3_description'];
                }
                else if ($row['module_year'] === 'Elective') {
                    $desc = $courseInfo['course_elective_description'];
                }
            ?>
                <div class="tab-content year-<?php echo $row['module_year'] ?>">
                    <h4>Description</h4>
                    <p><?php echo $desc ?></p>
                    <h4>Modules</h4>
                    <div class="modules">
                    <?php foreach ($courseModule as $key => $modules): ?>
                        <?php if ($key == $row['module_year']): ?>
                            <?php foreach ($modules as $key => $module): ?>
                                <div class="card filterDiv <?php echo $module['job_string'] ?>">
                                <a id="<?php echo $module['module_id'] ?>" class="card-body">
                                <img class="img-fluid" style="width:50%; margin-bottom: 1rem;" src="../<?php echo $module["item_path"] ?>" alt="Module Image">
                                <h6 class="card-title"><?php echo $module['module_name'] ?></h6>
                                </a>
                                </div>
                            <?php endforeach; ?>
                        <?php endif; ?>
                    <?php endforeach; ?>
                    </div>
                </div>
            <?php endforeach; ?>
            </div>
        </div>

    </section>
    <section class="project-content container">
        <h1>Project Portfolio</h1>
        <div class="top-content">
            <div class="carousel">
            <?php foreach ($projectInfo as $key => $row): ?>
                    <div>
                      <img src="../<?php echo $row["item_path"]?>" class="img-fluid mx-auto d-block">
                    </div>
                <?php endforeach; ?>
        </div>
        </div>
    </section>  
    <?php include $helper->subviewPath('moduleInfoOverlay.php') ?>
</main>
<?php include $helper->subviewPath('footer.php') ?>
<script src="<?php echo $helper->jsPath("modules.js") ?>" ></script>
</html>
<script type="text/javascript">
$(document).ready(function(){
  $('.carousel').slick({
  slidesToShow: 3,
  dots:true,
  centerMode: true,
  arrows:true,
  autoplay: true,
  autoplaySpeed: 2000,
  });
});

</script>