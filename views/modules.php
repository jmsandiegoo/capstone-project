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
?>
<!DOCTYPE html>
<html lang="en">
<?php include $helper->subviewPath('header.php') ?> 
    <main class="module-wrapper">
      <?php 
        $sql2 = "SELECT * FROM Item WHERE course_id = " . $id . " AND item_path LIKE '%BG_1.jpg'";
        $courseItemResult = $db->query($sql2);
        $backgroundPath = '';
        while ($row = $db->fetch_array($courseItemResult)) {
          $backgroundPath = '../' . $row['item_path'];
        }
      ?>
      <section class="main-banner container-fluid" style="background-image: linear-gradient(rgba(0, 0, 0, 0.25), rgba(0, 0, 0, 0.25)), url(<?php echo $backgroundPath ?>);">
        <h1>
          Diploma in <br/> <?php echo $courseInfo['course_name'] ?>
        </h1>
      </section>
      <section class="year-description-content container">
        <!-- Description is still hardcoded -->
        <?php
        foreach ($courseInfo as $key => $value): ?>

          <?php if ($key === 'course_year1_description'): ?>
            <h2>Year 1</h2>
            <p><?php echo $value ?></p>
          <?php elseif ($key === 'course_year2_description'): ?>
            <h2>Year 2</h2>
            <p><?php echo $value ?></p>
          <?php elseif ($key === 'course_year3_description'): ?> 
            <h2>Year 3</h2>
            <p><?php echo $value ?></p>
          <?php else:
            continue;
          endif;?>
        <?php endforeach; ?>
      </section>

      <section class="module-content container">
        <h1>Modules</h1>
        <hr>
        <!-- filter buttons !-->
        <div id="myBtnContainer">
          <button class="btn active" onclick="filterSelection('all')">Show all</button>
          <?php 
            //Get the job names
            $sql3 = "SELECT j.job_name FROM Job j INNER JOIN CourseJob cj ON j.job_id = cj.job_id WHERE cj.id = $id";
            $jobNameResult = $db->query($sql3);
            $jobName = [];
            while ($row = $db->fetch_array($jobNameResult)) {
              $jobName[] = $row;
            }
            foreach ($jobName as $key => $row)
            {
              $jobName = $row['job_name'];
              echo "<button class=\"btn\" onclick=\"filterSelection('".$jobName."')\">".$jobName."</button>";
            }
          ?>
        </div>
          </br>
        <!--  !-->
        <div id="tableContainer">
          <?php
            //Get module_year for IT Course
            $sql4 = "SELECT DISTINCT module_year FROM CourseModule WHERE id=$id ORDER BY module_year ASC";
            $moduleYearResult = $db->query($sql4);
            $moduleYear = [];
            while ($row = $db->fetch_array($moduleYearResult)) {
              $moduleYear[] = $row;
            }
            foreach ($moduleYear as $key => $row){
              $moduleYear = $row['module_year'];
              echo "<button type=\"button\" class=\"collapsible\">".$moduleYear."</button><div class=\"content\">";
              //Get module name to display and module id for filtering
              $sql5 = "SELECT * FROM Module m INNER JOIN CourseModule cm ON m.module_id = cm.module_id WHERE cm.id= $id AND cm.module_year ='$moduleYear' ORDER BY module_name ASC";
              $courseModuleResult = $db->query($sql5);
              while ($row2 = $db->fetch_array($courseModuleResult)){ 
                //get names of jobs for the modules
                $sql6 = "SELECT * FROM Module m INNER JOIN CourseModule cm ON m.module_id = cm.module_id INNER JOIN ModuleJob mj ON mj.module_id=m.module_id INNER JOIN Job j ON j.job_id=mj.job_id WHERE cm.id=$id AND m.module_id='".$row2['module_id']."'ORDER BY module_name ASC";
                $filterJobNameResult = $db->query($sql6);
                $filterJobName = array();
                while ($row4 = $db->fetch_array($filterJobNameResult)){
                  array_push($filterJobName,$row4['job_name']);
                } 
                
                $filterJobNameString = implode( ", ", $filterJobName );
                echo"<section class='cards'>";
                
                echo "<article class=\"filterDiv ".$filterJobNameString." \"><p>".$row2['module_name']."</p></article>";
                echo"</section>";
              }

              echo "</div>";
            }
            $db->close();
          ?>
        </div>
			</section>
			<section class="project-content container">
				<h1>Project Portfolio</h1>
			</section>
    </main>
    <?php include $helper->subviewPath('footer.php') ?>
</html>