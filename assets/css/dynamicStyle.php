<?php
    header("Content-type: text/css; charset: UTF-8");
    header("Cache-Control: must-revalidate");

    include_once dirname(__DIR__,2).'/helpers/mysql.php';
    include_once dirname(__DIR__,2).'/helpers/helper.php';
    
    $helper = new Helper();

    // Retrieving the course details
    $db = new Mysql_Driver();
    $db->connect();

    $sql = "SELECT * FROM Course";
    $coursesResult = $db->query($sql);
    $courses = [];
    while ($row = $db->fetch_array($coursesResult)) {
        $courses[] = $row;
    }
    $db -> close();
?>
<?php
foreach ($courses as $key => $row): 
?>
/* Dynamic style for each course sections and its respective slides */

    /* Section styles */
    #<?php echo 'section-' . $row['id']?>{
        color: white;
    }

    #<?php echo 'section-' . $row['id'] . ' h1'?>, #<?php echo 'section-' . $row['id'] . ' h2'?> {
        letter-spacing: 0.2rem;
        margin-bottom:16px;
        text-shadow: 2px 4px 3px rgba(0,0,0,0.3);
    }

    #<?php echo 'section-' . $row['id'] . ' h1'?> {
        font-size: 3.5vw;
        font-weight: 650;
    }

    #<?php echo 'section-' . $row['id'] . ' h2'?> {
        font-size: 2.5em;
        font-weight: 600;
    }    
    <?php
        $db = new Mysql_Driver();
        $db->connect();
        $sql2 = "SELECT * FROM Item WHERE course_id = " . $row['id'] . " AND item_path LIKE '%BG_1.jpg'";
        $courseItemResult = $db->query($sql2);
        $db -> close();
        while ($row2 = $db->fetch_array($courseItemResult)):
            $itemPath = '../../' . $row2['item_path'];
    ?>
    /* Slide 1 styles*/
    #<?php echo 'slide1-' . $row['id'] ?>{
        background-size: cover;
        background-image: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)),url(<?php echo $itemPath?>);
    }

    <?php endwhile; ?>


    #<?php echo 'slide1-' . $row['id'] . ' .overlay' ?>{
        background-color: rgba(0, 0, 0, 0.35);
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        position: relative;
        display: flex;
        align-items: center;
    }

    #<?php echo 'slide1-' . $row['id'] . ' h2' ?> {
        border-top: 4px solid white;
        display: inline-block;
        padding: 1rem 3.5rem 0 0;
    }

    /* Slide 2 styles */
    #<?php echo 'slide2-' . $row['id'] . ' .container-fluid' ?>{
        <!-- display: flex; -->
        flex-wrap: wrap;
        align-items: stretch;
        height: 100%;
        padding: 0;
    }

    

    /* Slide 3 styles */
    #<?php echo 'slide3-' . $row['id'] ?>{

        background: #380E7F;
        background-size:cover;
        background-image: url(../img/General/bg_1.jpg);

    }

    #<?php echo 'slide3-' . $row['id'] . ' .subject-wrapper' ?> {
        border-top: 0.3vw dashed white;
        padding-top: 5px; 
        clear:both;
        width: 70%;
    } 


    @media only screen and (max-width: 767px) { 
        #<?php echo 'section-' . $row['id'] . ' h1'?> {
            font-size: 10vw;
            width: 80%;
            letter-spacing: 0;
        }
        #<?php echo 'section-' . $row['id'] . ' h2'?> {
            font-size: 6vw;
            border-top: 2px solid white;
        }

        #<?php echo 'section-' . $row['id'] . ' p'?> {
            font-size: 3vw;
        }
    }

<?php endforeach; ?>