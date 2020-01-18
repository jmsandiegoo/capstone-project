<?php
    header("Content-Type: application/json");
    include_once __DIR__.'/../helpers/mysql.php';
    include_once __DIR__.'/../helpers/helper.php';

    $helper = new Helper();
    $db = new Mysql_Driver();

    if (isset($_GET["module_id"]))
    {
        $module_id = $_GET["module_id"];
        $db->connect();
        $query = "SELECT m.*, i.item_path FROM Module m INNER JOIN Item i ON m.module_id = i.module_id WHERE m.module_id=$module_id";
        $moduleInfoResult = $db->query($query);
        // $moduleInfo = $db->fetch_array($moduleInfoResult);

        if ($db->num_rows($moduleInfoResult) > 0) {
            $moduleInfoResult = $db->fetch_array($moduleInfoResult);
            $response = array(
                'status' => 200,
                'message' => 'Success',
                'data' => $moduleInfoResult
            );
        } else {
            $response = array(
                'status' => 404,
                'message' => 'Query Failed: Query return 0 records'
            );
        }
    } else {
        $response = array(
            'status' => 400,
            'message' => 'Error Occured: Must provide module_id query string'
        );
    }

    echo json_encode($response)
?>