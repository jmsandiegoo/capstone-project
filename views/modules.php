<?php 
    include_once __DIR__.'/../helpers/mysql.php';
    include_once __DIR__.'/../helpers/helper.php';
    $helper = new Helper();

    // Retrieving the course details
    $db = new Mysql_Driver();
    $db->connect();

    $sql = "SELECT * FROM Module m INNER JOIN CourseModule cm ON m.module_id = cm.module_id WHERE cm.id= " . $_GET['cid'];
    $result = $db->query($sql);

    $db->close();
?>

<!DOCTYPE html>
<html lang="en">
    <?php include $helper->subviewPath('header.php') ?>
    <main class="container">
        <h1>Course Modules</h1>
        <?php while ($row = $db->fetch_array($result)): ?>
        <p><?php echo "+ " . $row['module_name']?></p>
        
        <?php endwhile; ?>
                                    
    </main>
    <?php include $helper->subviewPath('footer.php') ?>

</html>