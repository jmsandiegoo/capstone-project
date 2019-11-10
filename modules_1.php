<?php 
  //course number passed on from previous page to this
  //put as session from previous page
  //for testing
  $courseID="1";
   // Retrieving the course details
   include_once __DIR__.'/helpers/mysql.php';
   include_once __DIR__.'/helpers/helper.php';
   
  ?>
<!DOCTYPE html>
<html lang="en">
  <body>
    <?php
      echo "Favorite color is " . $courseID . ".<br>";
      $db = new Mysql_Driver();
      $db->connect();
      $sql = "SELECT *
      FROM course
      WHERE id=$courseID";
      $result = $db->query($sql);
      $resultArray = [];
      while ($row = $db->fetch_array($result)) {
          $resultArray[] = $row;
          echo $row['course_name'];
          echo "<button type=\"button\">".$row['course_name']."</button>";
      }
      $db->close();
    ?>
    <table>
    <tr>
      <th><button type="button" onclick="alert('Hello world!')">All</button></th>
      <th><button type="button" onclick="alert('Hello world!')">Click Me!</button></th>
      <th><button type="button" onclick="alert('Hello world!')">Click Me!</button></th>
      <th><button type="button" onclick="alert('Hello world!')">Click Me!</button></th>
      <th><button type="button" onclick="alert('Hello world!')">Click Me!</button></th>
    </tr>
    <tr>
      <td><button type="button" onclick="alert('Hello world!')">Click Me!</button></td>
      <td><button type="button" onclick="alert('Hello world!')">Click Me!</button></td>
      <td><button type="button" onclick="alert('Hello world!')">Click Me!</button></td>
    </tr>
    </table>
    <p>Collapsible Set:</p>
    <button type="button" class="collapsible">Year 1</button>
    <div class="content">
      <p>1</p>
    </div>
    <button type="button" class="collapsible">Year 2</button>
    <div class="content">
      <p>2</p>
    </div>
    <button type="button" class="collapsible">Year 3</button>
    <div class="content">
      <p>3</p>
    </div>
  </body>
  
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
</html>