<?php 
    include_once __DIR__.'/../helpers/mysql.php';
    include_once __DIR__.'/../helpers/helper.php';
    $helper = new Helper();
	  $id = $_GET['id'];
    
    $years = [];
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

    // Retrieving the module year
    $sql2 = "SELECT DISTINCT module_year FROM CourseModule WHERE id=$id ORDER BY module_year ASC";
    $moduleYearResult = $db->query($sql2);
    $moduleYear = [];
    while ($row = $db->fetch_array($moduleYearResult)) {
      $moduleYear[] = $row;
    }
    $db->close();
?>
<!DOCTYPE html>
<html lang="en">
<?php include $helper->subviewPath('header.php') ?> 
    <main class="modules-container">
      <?php 
        $db->connect();
        $sql3 = "SELECT * FROM Item WHERE course_id = " . $id . " AND item_path LIKE '%BG_1.jpg'";
        $courseItemResult = $db->query($sql3);
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
      
      <section class="container">
        <?php foreach ($moduleYear as $key => $row){
          $moduleYear = $row['module_year'];
          echo "<button type=\"button\" class=\"collapsible\">".$moduleYear."</button><div class=\"content\">";
          $db->connect();
          $sql4 = "SELECT * FROM Module m INNER JOIN CourseModule cm ON m.module_id = cm.module_id WHERE cm.id= $id AND cm.module_year ='$moduleYear' ORDER BY module_name ASC";
          $courseModuleResult = $db->query($sql4);
          while ($row2 = $db->fetch_array($courseModuleResult)){
            echo "<p>".$row2['module_name']."</p></br>";
          }
          echo "</div>";
            $db->close();
          }
        ?>
      </section>
    </main>
    
    <?php include $helper->subviewPath('footer.php') ?>

</html>
<style>
    table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 100%;
    }

    td, th {
      border: 1px solid #dddddd;
      text-align: left;
      padding: 8px;
    }

    tr:nth-child(even) {
      background-color: #dddddd;
    }
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

    .content {
      padding: 0 18px;
      display: none;
      overflow: hidden;
      background-color: #f1f1f1;
    }
    </style>
    <script>
      var coll = document.getElementsByClassName("collapsible");
      var i;

      for (i = 0; i < coll.length; i++) {
        coll[i].addEventListener("click", function() {
          this.classList.toggle("active");
          var content = this.nextElementSibling;
          if (content.style.display === "block") {
            content.style.display = "none";
          } else {
            content.style.display = "block";
          }
        });
        }
    </script>