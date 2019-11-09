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
                            <div class="col-xs-6 col-md-4 d-flex align-items-stretch justify-content-center">
                                <div class="card text-center course-card" style="cursor: pointer;" onclick="window.location='#<?php echo $row['id']?>';">
                                    <?php 
                                        $db = new Mysql_Driver();
                                        $db->connect();
                                        $sql3 = "SELECT * FROM Item WHERE course_id = " . $row['id'] . " AND item_path LIKE '%BG_Card.png'";
                                        $result3 = $db->query($sql3);
                                        $db -> close();
                                        while ($row3 = $db->fetch_array($result3)): 
                                    ?>
                                    <img class="img-fluid" src="<?php echo $row3["item_path"] ?>" alt="Course Image">                                    
                                    <?php endwhile; ?>
                                    <div class="card-body">
                                    <script>courseName.push("<?=$row['course_name']?>")</script>
									<script>cid.push("<?=$row['id']?>")</script>
                                        <h5 class="card-title" style="font-size:1.1vw;"><?php echo $row['course_name'] ?></h5>
                                        <h6 class="card-subtitle" style="font-size:0.8vw; color:#A9A9A9;"><?php echo $row['course_short_description'] ?></h6>
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
                            <div class="container" id ="courseTitle">
                                <div class="row">
                                    <div class="col-md-7">                      
                                        <h1>Diploma in </br> <?php echo $row['course_name'] ?></h1>
                                        <h2><?php echo $row['course_id'] ?></h2>
                                        <!-- <p><?php echo $row['course_short_description'] ?></p> -->
                                    </div>
                                </div>
                           
                        </div>
                    </div>
                    <!-- Slide 2 -->
                    <div class="slide" id="<?php echo 'slide2-' . $row['id']?>">
                        <div class="container-fluid">
                            <div class="course-information">
                                <div class="container" id="courseInfo">
                                    <h1><i class="question-icon"></i> Course Information</h1>
                                    <p><?php echo $row['course_description'] ?></p>
                                </div>
                            </div>
                            
                            <div class="course-career">
                                <div class="container" id="careerPathway">
                                    <h1><i class="binoculars-icon"></i> Career Pathway</h1>
                                    <?php 
                                        $db = new Mysql_Driver();
                                        $db->connect();
                                    
                                        $sql1 = "SELECT * FROM Job j INNER JOIN CourseJob cj ON j.job_id = cj.job_id WHERE cj.id =" . $row['id'];
                                        $result1 = $db->query($sql1);
                                        $db -> close();
                                        while ($row1 = $db->fetch_array($result1)): 
                                    ?>
                                    <p><?php echo "+ ". $row1['job_name']?></p>
                                    <?php endwhile; ?>
                                </div>
                            </div>
                            
                        </div>
                    </div>
                    <!-- Slide 3-->
                    <div class="slide" id="<?php echo 'slide3-' . $row['id']?>">
                    <div class="overlay">
                        <div class="container">
                            <div id="courseEntry">
                                <h1><i class="question-icon"></i> Entry Requirements</h1>
                                <h3> <u>For Students with 'O' Levels:</u> </h3>
                                <h5>Range of Net ELR2B2 for 2020 JAE:<strong><?php echo $row['course_requirements'] ?></strong></h5>
                                <h5>Planned Intake (2020): <strong><?php echo $row['course_intake'] ?></strong></h5>  
                                <br>
                                <h3><strong> Aggregate Type ELR2B2-C </strong></h3>
                                <h6> To be eligible for consideration, candidates must have the following GCE 'O' Level Examination results </h6>
                                <h5  style="width:50%; float:left;"> Subjects </h5>
                                <h5  style="width:50%; float:right;">'O' Level Grade </h5>
                                <?php 
                                    $db = new Mysql_Driver();
                                    $db->connect();
                                
                                    $sql2 = "SELECT * FROM Requirement r INNER JOIN CourseReq cr ON r.req_id = cr.req_id WHERE cr.course_id =" . $row['id'];
                                    $result2 = $db->query($sql2);
                                    $db -> close();
                                    while ($row2 = $db->fetch_array($result2)): 
                                ?>
                                <div class="subject-wrapper">
                                    <p style="width:60%; float:left;"><?php echo "+ " . $row2['req_subject']?></p>
                                    <p style="width:40%; float:right; text-align: center;"><?php echo $row2['req_grade']?></p>
                                </div>
                                <?php endwhile; ?>
                                    </br>
                                <p style="width:80%;">You must also have sat for a Science or Design & Technology or Food & Nutrition or relevant OSIE/Applied Subject and fulfil the aggregate computation requirements. </p>
                                <p>Candidates with severe vision deficiency should not apply for the course.</p>
                            </div>
                        </div>
                    </div>
                    </div>
                    </div>
            <?php endforeach; ?>
<!-- 
            <div class="section" id="sectionquiz">
                <div class="slide" id="slide1">
                    <div class="intro">
                        <h1 style="color:white;">Quiz</h1></div>
                        
                    </div>
            </div> -->
            <div class="section fp-auto-height">
                <footer id="section-footer">
                    <div class="container">
                        <h1>Not sure which course to take?</h1>
                        <p>Don't worry! We have prepared a quiz for you, it will guide you to find the courses you might be interested in!</p>
                        <a href="<?php echo $helper->pageUrl("quiz.php") ?>"class="btn bg-light">Take Quiz</a>
                    </div>
                </footer>
            </div>
        </div>
    </main>

    <?php include $helper->subviewPath('footer.php') ?>
</html>