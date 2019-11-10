<?php 
    include_once __DIR__.'/../helpers/mysql.php';
    include_once __DIR__.'/../helpers/helper.php';
    $helper = new Helper();

    // Retrieving the course details
    $db = new Mysql_Driver();
    $db->connect();

    $sql = "SELECT * FROM Module m INNER JOIN CourseModule cm ON m.module_id = cm.module_id WHERE cm.id= '1'";
    $result = $db->query($sql);

    $db->close();
?>

<!DOCTYPE html>
<html lang="en">
    <?php include $helper->subviewPath('header.php') ?>
    <main class="container">
        <h1>Course Modules</h1>
		<button type="button" class="collapsible">Year 1</button>
		<div class="content">
			<?php while ($row = $db->fetch_array($result)): ?>
			<p><?php echo "<button type=\"button\">+ " . $row['module_name']."</button>"?></p>
			
			<?php endwhile; ?>
        </div>                            
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