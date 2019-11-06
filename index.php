<?php 
    include_once __DIR__.'/helpers/mysql.php';
    include_once __DIR__.'/helpers/helper.php';
    
    $helper = new Helper();

    // Retrieving the course details
    $db = new Mysql_Driver();
    $db->connect();

    $sql = "SELECT * FROM Course";
    $result = $db->query($sql);
    
    $resultArray = [];

    while ($row = $db->fetch_array($result)) {
        $resultArray[] = $row;
    }

    $db->close();

    $img = "https://images.unsplash.com/photo-1461749280684-dccba630e2f6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80";


?>
<!DOCTYPE html>
<html lang="en">
    <?php include $helper->subviewPath('header.php') ?>
    <a href="" id="floatingBtn"><div id="floatingBtnTxt"></div></a>
	<script>var courseName = [];</script>
	<script>var cid = [];</script>
    <script>
    courseName.unshift("")
    </script>

    <main>
        <div id="fullpage">
            <div class="section" id="section-header">
                <div class="container">
                    <h2>WELCOME TO</h2>
                    <h1>THE SCHOOL OF INFOCOMM </br> TECHNOLOGY</h1>
                </div>
            </div>
            <div class="section" id="section-overview">
                <div class="container">
                    <div class="row justify-content-center">
                        <?php foreach ($resultArray as $key => $row): ?>
                            <div class="col-xs-6 col-md-4 ">
                                <div class="card text-center course-card">
                                    <img class="img-fluid" src="<?php echo $img ?>" alt="Course Image">
                                    <div class="card-body">
                                    <script>courseName.push("<?=$row['course_name']?>")</script>
									<script>cid.push("<?=$row['id']?>")</script>
                                        <h5 class="card-title" style="font-size:1.1vw"><?php echo $row['course_name'] ?></h5>
                                        <h6 class="card-subtitle" style="font-size:0.6vw">(<?php echo $row['course_id'] ?>)</h6>
                                    </div>
                                </div>
                            </div>
                        <?php endforeach; ?>
                    </div>
                </div>
            </div>
 
            <?php foreach ($resultArray as $key => $row): ?>
                <div class="section" id="<?php echo 'section-' . $row['id']?>">
                    <!-- Slide 1 -->
                    <div class="slide" id="<?php echo 'slide1-' . $row['id']?>">
                        <div class="overlay">
                            <div class="container">
                                <div class="row">
                                    <div class="col-md-7">                      
                                        <h1>Diploma in </br> <?php echo $row['course_name'] ?></h1>
                                        <h2><?php echo $row['course_id'] ?></h2>
                                        <!-- <p><?php echo $row['course_short_description'] ?></p> -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="slide" id="<?php echo 'slide2-' . $row['id']?>">
                        <div class="container-fluid">
                            <div class="course-information">
                                <div class="container">
                                    <h1><i class="question-icon"></i> Course Information</h1>
                                    <p><?php echo $row['course_description'] ?></p>
                                </div>
                            </div>
                            <div class="course-career">
                                <div class="container">
                                    <h1><i class="binoculars-icon"></i> Career Pathway</h1>
                                    <p><?php echo $row['course_description'] ?></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="slide" id="<?php echo 'slide3-' . $row['id']?>"><h1><?php echo $row['course_requirements'] ?></h1></div>
                </div>
            <?php endforeach; ?>

            <div class="section" id="section1">
                <div class="slide" id="slide1">
                    <div class="intro">
                        <h1 style="color:white;">Quiz</h1></div>
                        
                    </div>
            </div>
        </div>
    </main>

    <?php include $helper->subviewPath('footer.php') ?>
</html>