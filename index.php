<?php 
    include_once __DIR__.'/helpers/mysql.php';
    include_once __DIR__.'/helpers/helper.php';
    
    $helper = new Helper();

    // Retrieving the course details
    $db = new Mysql_Driver();
    $db->connect();

    $sql = "SELECT * FROM Course";
    $result = $db->query($sql);
    
    $result2 = $db->query($sql);
   
    $db->close();

    $img = "https://images.unsplash.com/photo-1461749280684-dccba630e2f6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80";
?>

<!DOCTYPE html>
<html lang="en">
    <?php include $helper->subviewPath('header.php') ?>
    
    <main>
        <div id="fullpage">
            <div class="section fp-scrollable" id="section0">
                <div class="container-fluid">
                    <div class="row justify-content-center">
                        <?php while ($row = $db->fetch_array($result)): ?>
                            <div class="col-xs-6 col-md-4">
                                <div class="card text-center course-card">
                                    <img class="img-fluid" src="<?php echo $img ?>" alt="Course Image">
                                    <div class="card-body">
                                        <h5 class="card-title" ><?php echo $row['course_name'] ?></h5>
                                        <h6 class="card-subtitle">(<?php echo $row['course_id'] ?>)</h6>
                                    </div>
                                </div>
                            </div>
                            <?php endwhile; ?>
                    </div>
                </div>
            </div>
            <div class="section" id="section1">
                <div class="slide" id="slide1">
                    <div class="intro">
                        <h1 style="color:white;">Information Technology</h1></div>
                        <p style="color:white;">Learn everything related to IT here!</p>
                    </div>

                    
                <div class="slide" id="slide2"><h1>Course Description</h1></div>
                <div class="slide" id="slide3"><h1>Course Requirements</h1></div>
            </div>
            <?php 
            while ($row1 = $db->fetch_array($result2)): 
            ?>
                    <div class="section" id="<?php echo $row['course_id'] . '-section'?>">
                    <div class="slide" id="slide1">
                    <div class="intro">
                        <h1 style="color:white;"><?php echo $row1['course_name'] ?></h1></div>
                        <p style="color:white;"><?php echo $row1['course_short_description'] ?></p>
                    </div>
                    <div class="slide" id="slide2"><p><?php echo $row1['course_description'] ?></p></div>
                    <div class="slide" id="slide3"><h1><?php echo $row1['course_requirements'] ?></h1></div>
                </div>
            <?php endwhile; ?>
        </div>
    </main>

    <?php include $helper->subviewPath('footer.php') ?>
</html>