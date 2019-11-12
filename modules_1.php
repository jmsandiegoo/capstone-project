<?php 
    include_once __DIR__.'/helpers/mysql.php';
    include_once __DIR__.'/helpers/helper.php';
    $helper = new Helper();
    //$val = $_GET['id'];
    //hi
    $val = 1;
    $years = [];
    // Retrieving the course details
    $db = new Mysql_Driver();
    $db->connect();
    $sql = "SELECT DISTINCT module_year FROM coursemodule WHERE id=$val ORDER BY module_year ASC";
	  $result = $db->query($sql);
    $sql3 = "SELECT DISTINCT e.elective_name FROM elective e INNER JOIN electivemodule em on e.elective_id=em.elective_id INNER JOIN coursemodule cm on cm.module_id=em.module_id WHERE cm.id=$val ORDER BY e.elective_name ASC";
	  $result3 = $db->query($sql3);
    $db->close();
?>
<!DOCTYPE html>
<html lang="en">
<?php include $helper->subviewPath('header.php') ?>
    
    <main class="container">
<!--make the header dont block my view first-->
  </br></br></br>
  <?php 
  $db->connect();
          while ($row3 = $db->fetch_array($result3)){
            $elective_name = $row3['elective_name'];
            echo "<button type=\"button\" class=\"collapsible\">".$elective_name."</button><div class=\"content\">";
            $sql4 = "SELECT * FROM module m INNER JOIN electivemodule em ON m.module_id = em.module_id INNER JOIN elective e ON em.elective_id = e.elective_id WHERE e.elective_name= '$elective_name' ORDER BY m.module_name ASC";
            $result4 = $db->query($sql4);
              while ($row4 = $db->fetch_array($result4)){
                echo "<p>".$row4['module_name']."</p></br>";
              }
            echo "</div>";
            }
            echo "</br></br>";
            while ($row = $db->fetch_array($result)){
              $module_year = $row['module_year'];
              echo "<button type=\"button\" class=\"collapsible\">".$module_year."</button><div class=\"content\">";
              $db->connect();
              $sql2 = "SELECT * FROM Module m INNER JOIN CourseModule cm ON m.module_id = cm.module_id WHERE cm.id= $val AND cm.module_year ='$module_year' ORDER BY module_name ASC";
              $result2 = $db->query($sql2);
              while ($row2 = $db->fetch_array($result2)){
                echo "<p>".$row2['module_name']."</p></br>";
              }
            echo "</div>";
             }
             $db->close();
            ?>
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