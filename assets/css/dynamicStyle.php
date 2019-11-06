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
    $result = $db->query($sql);
    $db->close();

    $sql1 = "SELECT * FROM Course "
?>
<?php
while ($row = $db->fetch_array($result)): 
?>
/* Dynamic style for each course sections and its respective slides */

    /* Section styles */
    #<?php echo 'section-' . $row['id']?>{
        color: white;
    }

    /* Slide 1 styles*/
    #<?php echo 'slide1-' . $row['id'] ?>{
        background-size: cover;
        background-image: url(https://www.np.edu.sg/ict/PublishingImages/Pages/accountancy/3d_banner.jpg);
    }

    #<?php echo 'slide1-' . $row['id'] . ' h1' ?>, #<?php echo 'slide1-' . $row['id'] . ' h2' ?> {
        letter-spacing: 0.2rem;
        text-shadow: 2px 4px 3px rgba(0,0,0,0.3);
    }

    #<?php echo 'slide1-' . $row['id'] . ' h1' ?> {
        font-size: 3.5rem;
        font-weight: 650;
    }

    #<?php echo 'slide1-' . $row['id'] . ' h2' ?> {
        font-size: 2.5em;
        border-top: 4px solid white;
        display: inline-block;
        padding: 1rem 3.5rem 0 0;
        font-weight: 600;
    }

    /* Slide 2 styles */
    #<?php echo 'slide2-' . $row['id'] ?>{

    background-size:cover;
    background-image: url(https://www.np.edu.sg/ict/PublishingImages/Pages/accountancy/3d_banner.jpg);
    }

    /* Slide 3 styles */
    #<?php echo 'slide3-' . $row['id'] ?>{

    background-size:cover;
    background-image: url(https://www.np.edu.sg/ict/PublishingImages/Pages/accountancy/3d_banner.jpg);
    }

<?php endwhile; ?>
