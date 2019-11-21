<!-- This is the pop up / overlay page -->
<?php 
    // include_once __DIR__.'/../../helpers/mysql.php';
    // include_once __DIR__.'/../../helpers/helper.php';
    // $helper = new Helper();
	//   $id = $_GET['id'];
    // // Retrieving the module information
    // $db = new Mysql_Driver();
    // $db->connect(); 
    // $sql = "SELECT * FROM Module WHERE module_id=$id";
    // $moduleInfoResult = $db->query($sql);
    // $moduleInfo = [];
    // while ($row = $db->fetch_array($moduleInfoResult)): 
?>
<div class="moduleInfoOverlay">
    <div class="overlay-content container">
        <div class="blackOverlay">
        <i class="close-overlay fas fa-times"></i>
    </div>
    <div class="moduleInfo">
        <h1 class="module-name"></h1>
        <p class="module-description"></p>
    </div>
    </div>
</div>