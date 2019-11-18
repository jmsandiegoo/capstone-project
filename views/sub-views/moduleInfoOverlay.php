<!-- This is the pop up / overlay page -->
<?php 
    include_once __DIR__.'/../../helpers/mysql.php';
    include_once __DIR__.'/../../helpers/helper.php';
    $helper = new Helper();
	  $id = $_GET['id'];
    // Retrieving the module information
    $db = new Mysql_Driver();
    $db->connect(); 
    $sql = "SELECT * FROM Module WHERE module_id=$id";
    $moduleInfoResult = $db->query($sql);
    $moduleInfo = [];
    while ($row = $db->fetch_array($moduleInfoResult)): 
?>
<h1><?php echo $row['module_name']?></h1>     
<h1><?php echo $row['module_description']?></h1>              
<?php endwhile; ?>  