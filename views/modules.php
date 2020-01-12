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

    // Fetch Module_Year for IT Courses
    $sql = "SELECT DISTINCT module_year FROM CourseModule WHERE id=$id ORDER BY module_year ASC";
    $moduleYearResult = $db->query($sql);
    $moduleYear = [];
    while ($row = $db->fetch_array($moduleYearResult)) {
        $moduleYear[] = $row;
    }
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
                    <button class="btn tab-link" onclick="openCity(event, 'London')"><b><?php echo $tablinkLbl ?></b></button>
                <?php endforeach; ?>
            </div>
            <?php foreach ($moduleYearResult as $key => $row):
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
                <div class="tab-content">
                    <p><?php echo $desc ?></p>
                    <?php echo $row['module_year'] ?>
                </div>
            <?php endforeach; ?>
        </div>
    </section>

</main>
<?php include $helper->subviewPath('footer.php') ?>
</html>