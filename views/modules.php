<?php 
    include_once __DIR__.'/../helpers/mysql.php';
    include_once __DIR__.'/../helpers/helper.php';
    $helper = new Helper();
	$id = $_GET['id'];
    // Retrieving the current course information
    $db = new Mysql_Driver();
    $db->connect(); 
    $sql = "SELECT * FROM Course WHERE id=$id";
    $courseInfoResult = $db->query($sql);
    $courseInfo = [];
    while ($row = $db->fetch_array($courseInfoResult)) {
      $courseInfo[] = $row;
    }
    $courseInfo = $courseInfo[0];

    // Fetch the background
    $sql = "SELECT * FROM Item WHERE course_id = " . $id . " AND item_path LIKE '%BG_1.jpg'";
    $courseItemResult = $db->query($sql);
    $row = $db->fetch_array($courseItemResult);
    $backgroundPath = '../' . $row['item_path'];

    // Fetch courses and items
    $sql = "SELECT c.id, c.course_name, c.course_short_description, i.item_path FROM Course c INNER JOIN Item i ON c.id = i.course_id WHERE item_path LIKE '%BG_1.jpg'";
    $coursesResult = $db->query($sql);
    $coursesArray = [];
    while ($row = $db->fetch_array($coursesResult)) {
        $coursesArray[] = $row;
    }

    // Fetch Category
    // $sql = "SELECT j.job_name FROM Job j INNER JOIN CourseJob cj ON j.job_id = cj.job_id WHERE cj.id = $id";
    $sql = "SELECT cat.category_name FROM Category cat WHERE cat.id = $id";
    $categoryNameResults = $db->query($sql);
    $categoryName = [];
    while ($row = $db->fetch_array($categoryNameResults)) {
        $categoryName[] = $row;
    }

    // Retrieving the project information
    $db = new Mysql_Driver();
    $db->connect(); 
    $sql = "SELECT * FROM Item i INNER JOIN Project p ON i.project_id = p.project_id WHERE p.id=$id";
    $projectInfoResult = $db->query($sql);
    $projectInfo = [];
    while ($row = $db->fetch_array($projectInfoResult)) {
      $projectInfo[] = $row;
    }


    // Fetch Module_Year for Courses
    $sql = "SELECT DISTINCT module_year FROM CourseModule WHERE id=$id ORDER BY module_year ASC";
    $moduleYearResult = $db->query($sql);
    $moduleYear = [];
    while ($row = $db->fetch_array($moduleYearResult)) {
        $moduleYear[] = $row;
    }
    

    $courseModule = [];

    foreach ($moduleYear as $key => $row) {
        $sql = "SELECT m.module_id, m.module_name, i.item_path FROM Module m INNER JOIN CourseModule cm ON m.module_id = cm.module_id INNER JOIN Item i ON m.module_id = i.module_id WHERE cm.id = $id AND cm.module_year ='$row[module_year]' ORDER BY module_name ASC";
        $courseModuleResult = $db->query($sql);
        $modules= [];
        while ($row2 = $db->fetch_array($courseModuleResult)) {
            // $sql = "SELECT j.job_name FROM Module m INNER JOIN CourseModule cm ON m.module_id = cm.module_id INNER JOIN ModuleJob mj ON mj.module_id=m.module_id INNER JOIN Job j ON j.job_id=mj.job_id WHERE cm.id=$id AND m.module_id='$row2[module_id]'ORDER BY module_name ASC";
            $sql = "SELECT cat.category_name FROM Module m INNER JOIN CourseModule cm ON m.module_id = cm.module_id INNER JOIN CategoryModule catm ON catm.module_id = m.module_id INNER JOIN Category cat ON catm.category_id = cat.category_id WHERE cm.id=$id AND m.module_id='$row2[module_id]'";
            $categoryResult = $db->query($sql);
            $categoryArray = [];
            while ($row3 = $db->fetch_array($categoryResult)) {
                array_push($categoryArray, $row3['category_name']);
            }
            $row2['category_string'] = implode(",", $categoryArray);
            $modules[] = $row2;
        }
        $courseModule["$row[module_year]"] = $modules;
    }

    $db->close();

    // echo '<pre>';
    // print_r($courseModule);
    // echo '</pre>';
    // Fetch the module name to display for each courses
?>

<!DOCTYPE html>
<html lang="en">
<?php include $helper->subviewPath('header.php') ?>

<main class="module-wrapper">
    <?php include $helper->subviewPath('navbar.php') ?>
	  
    <section class="main-banner container-fluid" style="background-image: linear-gradient(rgba(0, 0, 0, 0.25), rgba(0, 0, 0, 0.25)), url(<?php echo $backgroundPath ?>);">
        <div>
            <h1>Diploma in <br/> <?php echo $courseInfo['course_name']?></h1>
            <h3>Modules & Projects</h3>
        </div>
    </section>

    <section class="module-content container">
        <!-- Job Links Links -->
        <div id="myBtnContainer">
            <div class="filters">
            <button class="btn filter-btn active" onclick="filterSelection('all')">Show All</button>
                <?php foreach ($categoryName as $key => $row): ?>
                    <button class="btn filter-btn" onclick="filterSelection('<?php echo $row['category_name'] ?>')"><?php echo $row['category_name'] ?></button>
                <?php endforeach; ?>
            </div>
            <!-- <div class="fade-overlay"></div> -->
        </div>

        <?php if ($id == 5): ?>
            <div id="tabContainer">
                <div class="tabs">
                        <button class="btn tab-link" onclick="openTab('<?php echo 'year-1' ?>')"><b>Semester 1</b></button>
                        <button class="btn tab-link" onclick="openTab('<?php echo 'year-2-onwards' ?>')"><b>Semester 2 Onwards</b></button>
                </div>
                <div class="tab-contents">
                    <div class="tab-content elective year-1">
                        <h4>Description</h4>
                        <p><?php echo $courseInfo['course_year1_description'] ?></p>
                        <h4 class="pt-4">Modules</h4>
                        <div class="modules">
                        <?php foreach ($courseModule as $key => $modules): ?>
                            <?php if ($key == 1): ?>
                                <?php foreach ($modules as $key => $module): ?>
                                    <div class="card filterDiv <?php echo $module['category_string'] ?>">
                                    <a id="<?php echo $module['module_id'] ?>" class="card-body">
                                    <img class="img-fluid" style="width:50%; margin-bottom: 1rem;" src="../<?php echo $module["item_path"] ?>" alt="Module Image">
                                    <h6 class="card-title"><?php echo $module['module_name'] ?></h6>
                                    </a>
                                    </div>
                                <?php endforeach; ?>
                            <?php endif; ?>
                        <?php endforeach; ?>
                        </div>
                    </div>

                    <div class="tab-content elective year-2-onwards">
                        <h4>Description</h4>
                        <p><?php echo $courseInfo['course_year2_description']?></p>
                        <h4 class="pt-4">Respective Diploma Courses</h4>
                        <p>Select your preferred diploma below to view the respective modules</p>
                        <div class="courses pt-2">
                        <?php foreach ($coursesArray as $key => $course): ?>
                            <?php if ($course["id"] != 5): ?>
                            <div class="card">
                                <a href="<?php echo $helper->pageUrl("modules.php") . "?id=$course[id]" ?>" class="card-body">
                                <img class="img-fluid" style="width:100%; margin-bottom: 1rem;" src="../<?php echo $course["item_path"] ?>" alt="Course Image">
                                    <h6 class="card-title"><?php echo $course["course_name"] ?></h6>
                                    <p class="card-subtitle"><?php echo $course['course_short_description'] ?></p>
                                </a>
                            </div>
                            <?php endif; ?>
                        <?php endforeach; ?>
                        </div>
                    </div>

                </div>
            </div>

        <?php else: ?>
            <!-- Tab Year Links -->
            <div id="tabContainer">
                <div class="tabs">
                    <?php foreach ($moduleYear as $key => $row): 
                        $tablinkLbl = 'Elective';

                        if ($row['module_year'] !== 'Elective') {
                            $tablinkLbl = 'Year ' . $row['module_year'];
                        }
                    ?>
                        <button class="btn tab-link" onclick="openTab('<?php echo 'year-'.$row['module_year'] ?>')"><b><?php echo $tablinkLbl ?></b></button>
                    <?php endforeach; ?>
                </div>

                <div class="tab-contents">
                <?php foreach ($moduleYear as $key => $row):
                    $contentYear = "Elective";

                    $desc = "";
                    if ($row['module_year'] === '1') {
                        $desc = $courseInfo['course_year1_description'];
                    }
                    else if ($row['module_year'] === '2') {
                        $desc = $courseInfo['course_year2_description'];
                    }
                    else if ($row['module_year'] === '3') {
                        $desc = $courseInfo['course_year3_description'];
                    }
                    else if ($row['module_year'] === 'Elective') {
                        $desc = $courseInfo['course_elective_description'];
                    }
                ?>
                    <div class="tab-content elective year-<?php echo $row['module_year'] ?>">
                        <h4>Description</h4>
                        <p><?php echo $desc ?></p>
                        <h4 class="pt-4">Modules</h4>
                        <div class="modules">
                        <?php foreach ($courseModule as $key => $modules): ?>
                            <?php if ($key == $row['module_year']): ?>
                                <?php foreach ($modules as $key => $module): ?>
                                    <div class="card filterDiv <?php echo $module['category_string'] ?>">
                                    <a id="<?php echo $module['module_id'] ?>" class="card-body">
                                    <img class="img-fluid" style="width:50%; margin-bottom: 1rem;" src="../<?php echo $module["item_path"] ?>" alt="Module Image">
                                    <h6 class="card-title"><?php echo $module['module_name'] ?></h6>
                                    </a>
                                    </div>
                                <?php endforeach; ?>
                            <?php endif; ?>
                        <?php endforeach; ?>
                        </div>
                    </div>
                <?php endforeach; ?>
                </div>
            </div>
        <?php endif; ?>

    </section>

    <?php if ($id != 5): ?>
    <section id='projectWrapper' class="project-content container">
        <h1>Project Portfolio</h1>
        <div class="carousel">
            <?php foreach ($projectInfo as $key => $row): ?>
                <div class="btcarousel-item" style="background-image: url(<?php echo '../' . $row["item_path"] ?>);" data-id="<?php echo $row["project_id"]?>">
                </div>
            <?php endforeach; ?>
        </div>
    </section>  
    <?php endif; ?>
    <?php include $helper->subviewPath('projectInfoOverlay.php') ?>
    <?php include $helper->subviewPath('moduleInfoOverlay.php') ?>
</main>
<?php include $helper->subviewPath('footer.php') ?>
<script src="<?php echo $helper->jsPath("modules.js") ?>" ></script>
<script src="<?php echo $helper->jsPath("projects.js") ?>" ></script>
</html>

<script type="text/javascript">

$(document).ready(function(){
    $('.carousel').slick({
    dots: true,
    centerMode: false,
    infinite: true,
    speed: 650,
    autoplay: true,
    slidesToShow: 3,
    draggable: true,
    slidesToScroll: 3,
    cssEase: 'linear',
    responsive: [
        {
        breakpoint: 1024,
        settings: {
            centerMode: false,
            slidesToShow: 2,
            slidesToScroll: 2,
            infinite: true,
            dots: true
        }
        },
        {
        breakpoint: 480,
        settings: {
            centerMode: true,
            infinite: true,
            slidesToShow: 1,
            slidesToScroll: 1,
            arrows: false
        }
        }
        // You can unslick at a given breakpoint now by adding:
        // settings: "unslick"
        // instead of a settings object
    ]
    });
});


</script>