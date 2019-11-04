<?php
    header("Content-type: text/css; charset: UTF-8");
    header("Cache-Control: must-revalidate");

    include_once dirname(__DIR__,2).'\helpers\mysql.php';
    include_once dirname(__DIR__,2).'\helpers\helper.php';
    
    $helper = new Helper();

    // Retrieving the course details
    $db = new Mysql_Driver();
    $db->connect();

    $sql = "SELECT * FROM Course";
    $result = $db->query($sql);
    $db->close();

?>
<?php
while ($row = $db->fetch_array($result)): 
?>

#<?php echo $row['course_id'] . '-section'?>{
    padding-top:0px !important;
}

<?php endwhile; ?>
