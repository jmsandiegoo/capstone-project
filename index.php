<?php 
    include_once __DIR__.'/helpers/mysql.php';
    include_once __DIR__.'/helpers/helper.php';
    
    $helper = new Helper();

    // Retrieving the course details
    $db = new Mysql_Driver();
    $db->connect();

    $sql = "SELECT * FROM Course WHERE course_name NOT LIKE '%Common%'"; // this is the sql query for this loop
    $result = $db->query($sql);// connect to the database to get the info
    
    $resultArray = []; // instantiate empty array 

    while ($row = $db->fetch_array($result)) { // while loop based on connection 
        $resultArray[] = $row; // append results into the array
    }
    $sql4 = "SELECT * FROM Course WHERE course_name LIKE '%Common%'";
    $result9 = $db->query($sql4);
    $resultArray2 = [];

    while ($row = $db->fetch_array($result9)) {
        $resultArray2[] = $row;
    }
    $sql6 = "SELECT * FROM Course";
    $result1 = $db->query($sql6);
    $resultArray3 = [];

    while ($row = $db->fetch_array($result1)) {
        $resultArray3[] = $row;
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
        <?php include $helper->subviewPath('fullpageNav.php') ?>
        <div id="fullpage">
            <div class="section" id="section-header">
                <div class="container">
                    <div class="card flex-row flex-wrap intro">
                        <div class="card-header intro" style="float:left;">
                            <img class="img-fluid" src="assets/img/General/BG_Logo.png" alt="Logo Image" data-holder-rendered="true">                                                                  
                        </div>
                        <div class="card-block px-2 justify-content-center" style="float:right; padding-top:50px;">
                            <h1 >OPEN HOUSE</h1>
                            <h2><span class="welcome-text">WELCOME TO ICT,</span><span class="short-text"> Taking IT Higher </span></h2>
                            <h2 class="hidden-text"> Taking IT Higher </h2>
                                        
                        </div>
                    </div>
                    <br>
                </div>
            </div>
            
            <div class="section" id="section-overview">
                <div class="container cour">
                <?php foreach ($resultArray3 as $key => $row): ?>
                    <div class="card courses">
                        <a href="#<?php echo $row["id"]?>">
                        <div class="row no-gutters">
                        
                        <?php 
                            $db = new Mysql_Driver();
                            $db->connect();
                            $sql3 = "SELECT * FROM Item WHERE course_id = " . $row['id'] . " AND item_path LIKE '%BG_1.jpg'";
                            $result3 = $db->query($sql3);
                            $db -> close();
                            while ($row3 = $db->fetch_array($result3)): 
                        ?>
                            <div class="col-auto">
                                <img style="height:100px" src="<?php echo $row3["item_path"] ?>" class="img-fluid" alt="">
                            </div>
                                                         
                            <?php endwhile; ?>
                            <div class="col info">
                                    <script>courseName.push("<?=$row['course_name']?>")</script>
                                    <script>cid.push("<?=$row['id']?>")</script>
                                <div class="card-block px-2">
                                        <h5 class="card-title"><?php echo $row['course_name'] ?></h5>
                                        <h6 class="card-subtitle"><?php echo $row['course_short_description'] ?></h6>
                                </div>
                            </div>
                        </div>
                        </a>
                    </div>
                        
                    <?php endforeach; ?>
                </div>
            </div>
            <!-- For Courses except Common ICT -->
            <?php foreach ($resultArray as $key => $row): ?>
                <div class="section" id="<?php echo 'section-' . $row['id']?>">
                    <!-- Slide 1 -->
                    <div class="slide" id="<?php echo 'slide1-' . $row['id']?>" data-anchor="0">
                            <div class="container courseTitle" >
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
                    <div class="slide" id="<?php echo 'slide2-' . $row['id']?>" data-anchor="1">
                        <div class="container-fluid">
                            <div class="course-information">
                                <div class="container">
                                    <h1><i class="question-icon"></i> Course Information</h1>
                                    <p><?php echo $row['course_description'] ?></p>
                                </div>
                            </div>
                            
                            <div class="course-career">
                                <div class="container container-fluid py-2">
                                    <h1><i class="binoculars-icon"></i> Career Prospects</h1>
                                    <div class="d-flex flex-row flex-wrap">
                                            <?php 
                                                $db = new Mysql_Driver();
                                                $db->connect();
                                                $sql3 = "SELECT * FROM CategoryJob A INNER JOIN Category B ON A.category_id = B.category_id WHERE B.id =" . $row['id']. " GROUP BY A.category_id";
                                                $result3 = $db->query($sql3);
                                                $db -> close();
                                                $resultArray4 = [];
                                                while ($row20 = $db->fetch_array($result3)){
                                                    $resultArray4[] = $row20;
                                                }
                                            ?>

                                            <?php foreach ($resultArray4 as $key => $row2): ?>
                                                <div class="card card-body1 category">
                                                    <div class="align-self-center">     
                                                    <?php 
                                                        $db = new Mysql_Driver();
                                                        $db->connect();
                                                        $sql3 = "SELECT * FROM Item WHERE category_id = " . $row2['category_id'];
                                                        $result4 = $db->query($sql3);
                                                        $db -> close();
                                                        while ($row3 = $db->fetch_array($result4)):
                                                    ?>
                                                    <img class="rounded-circle" src="<?php echo $row3["item_path"] ?>" alt="Category Image" data-holder-rendered="true">                                    
                                                    <?php endwhile?>
                                                    </div>
                                                    <h6 class="card-title text-center text-dark" id="categoryjob"><?php echo $row2['category_name'] ?></h5>
                                                    <?php
                                                        $db = new Mysql_Driver();
                                                        $db->connect();
                                                        $sql13 = "SELECT * FROM CategoryJob A INNER JOIN job B ON A.job_id = B.job_id WHERE A.category_id = $row2[category_id]";
                                                        $result13 = $db->query($sql13);

                                                        $resultArray3 = [];
                                                        while ($row19 = $db->fetch_array($result13)){
                                                            $resultArray3[] = $row19;
                                                        }
                                                        $db->close();
                                                        
                                                    ?>
                                                    <div id="categoryjobname">
                                                    <?php foreach ($resultArray3 as $key => $row1): 
                                                        ?>
                                                        <?php if($row1["job_name"] != ""): ?>
                                                        <li class="text-dark"><?php echo $row1['job_name']?></br></li>
                                                        <?php endif;?>                                                 
                                                    <?php endforeach;?>
                                                        </div>
                                                </div>
                                            <?php endforeach; ?>
                                    </div> 
                                </div>
                            </div>
                            
                        </div>
                    </div>
                    <!-- Slide 3-->
                    <div class="slide" id="<?php echo 'slide3-' . $row['id']?>" data-anchor="2">
                    <div class="overlay">
                        <div class="container">
                            <div class="course-entry">
                                <h1><i class="question-icon"></i> Entry Requirements</h1>
                                <h3> <u>For Students with 'O' Levels:</u> </h3>
                                <h6>Range of Net ELR2B2 for 2020 JAE: <strong><?php echo $row['course_requirements'] ?></strong></h5>
                                <h6>Planned Intake (2020): <strong><?php echo $row['course_intake'] ?></strong></h5>  
                                <br>
                                <h3><u> Aggregate Type ELR2B2-C </u></h3>
                                <p><i> To be eligible for consideration, candidates must have the following GCE 'O' Level Examination results </i> </p>
                                <h6 style="width:50%; float:left;"> Subjects </h6>
                                <h6 style="width:50%; float:right;">'O' Level Grade </h6>
                                <?php 
                                    $db = new Mysql_Driver();
                                    $db->connect();
                                
                                    $sql2 = "SELECT * FROM Requirement r INNER JOIN CourseReq cr ON r.req_id = cr.req_id WHERE cr.course_id = $row[id]";
                                    $result2 = $db->query($sql2);
                                    $db -> close();
                                    while ($row2 = $db->fetch_array($result2)): 
                                ?>
                                <div class="subject-wrapper">
                                    <p style="width:60%; float:left;"><?php echo "+ " . $row2['req_subject']?></p>
                                    <p style="width:40%; float:right; text-align: center;"><?php echo $row2['req_grade']?></p>
                                </div>
                                <?php endwhile; ?>
                                <!-- </br>
                                <p style="width:80%;">You must also have sat for a Science or Design & Technology or Food & Nutrition or relevant OSIE/Applied Subject and fulfil the aggregate computation requirements. </p>
                                <p>Candidates with severe vision deficiency should not apply for the course.</p>
                                </br> -->
                                <p style="width:80%; float:left;">
                                    <em>* You must also have sat for a Science or Design & Technology or Food & Nutrition or relevant OSIE/Applied Subject and fulfil the aggregate computation requirements.<br/>
                                    * Candidates with severe vision deficiency should not apply for the course.</em>
                                </p><br/>
                                
                            </div>
                            
                        </div>
                        <a id="learn-more-btn" class="btn btn-light" href="<?php echo $helper->pageUrl("modules.php") . "?id=$row[id]" ?>">
                                    Learn More
                                </a>
                    </div>
                </div>
            </div>
            <?php endforeach; ?>

            <!-- Common ICT section -->                           
            <?php foreach ($resultArray2 as $key => $row): ?>
                <div class="section" id="<?php echo 'section-' . $row['id']?>">
                    <!-- Slide 1 -->
                    <div class="slide" id="<?php echo 'slide1-' . $row['id']?>" data-anchor="0">
                            <div class="container courseTitle">
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
                    <div class="slide" id="<?php echo 'slide2-' . $row['id']?>" data-anchor="1">
                        <div class="container-fluid">
                            <div class="course-information">
                                <div class="container courseInfo">
                                    <h1><i class="question-icon"></i> Course Information</h1>
                                    <p><?php echo $row['course_description'] ?></p>
                                </div>
                            </div>
                            
                            <div class="course-career">
                                <div class="container">
                                    <h1><i class="binoculars-icon"></i> Course Pathway</h1>
                                    <div class="course-wrapper">
                                        <p>In Year 1, Students are given an opportunity to learn modules from other courses in ICT.</br>
                                        Upon completion of Year 1 modules, Students are to continue their education by selecting the following courses:</br>
                                        </p> 
                                        <div class="referModule">
                                        <?php foreach($resultArray as $key => $row1): ?>
                                            <a id="course-btn" class="btn btn-light" href="<?php echo "index.php#".$row1["id"]."/1"?>"><?php echo $row1["course_name"]?></a>   
                                        <?php endforeach; ?>    
                                        </div>                         
                                    </div>
                                </div>
                            </div>                           
                        </div>
                    </div>
                    <!-- Slide 3-->
                    <div class="slide" id="<?php echo 'slide3-' . $row['id']?>" data-anchor="2">
                    <div class="overlay">
                        <div class="container">
                            <div class="course-entry">
                                <h1><i class="question-icon"></i> Entry Requirements</h1>
                                <h3> <u>For Students with 'O' Levels:</u> </h3>
                                <h6>Range of Net ELR2B2 for 2020 JAE: <strong><?php echo $row['course_requirements'] ?></strong></h5>
                                <h6>Planned Intake (2020): <strong><?php echo $row['course_intake'] ?></strong></h5>  
                                <br>
                                <h3><u> Aggregate Type ELR2B2-C </u></h3>
                                <p><i> To be eligible for consideration, candidates must have the following GCE 'O' Level Examination results </i> </p>
                                <h6 style="width:50%; float:left;"> Subjects </h6>
                                <h6 style="width:50%; float:right;">'O' Level Grade </h6>
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
                                <!-- </br>
                                <p style="width:80%;">You must also have sat for a Science or Design & Technology or Food & Nutrition or relevant OSIE/Applied Subject and fulfil the aggregate computation requirements. </p>
                                <p>Candidates with severe vision deficiency should not apply for the course.</p>
                                </br> -->
                                <p style="width:80%; float:left;">
                                    <em>* You must also have sat for a Science or Design & Technology or Food & Nutrition or relevant OSIE/Applied Subject and fulfil the aggregate computation requirements.<br/>
                                    * Candidates with severe vision deficiency should not apply for the course.</em>
                                </p>
                                <?php 
                                    $db = new Mysql_Driver();
                                    $db->connect();
                                
                                    $sql = "SELECT * FROM Course WHERE course_name LIKE '%Common%'";
                                    $result = $db->query($sql);
                                    $db -> close();
                                    while ($row = $db->fetch_array($result)): 
                                ?><br/>
                                <a id="learn-more-btn" class="btn btn-light" href="<?php echo $helper->pageUrl("modules.php") . "?id=$row[id]" ?>">
                                    Learn More
                                </a>

                                <?php endwhile; ?>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <?php endforeach;?>                            

        </div>
    </main>
    <?php include $helper->subviewPath('footer.php') ?>
</html>

