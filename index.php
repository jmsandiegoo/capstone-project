<?php 
    include_once __DIR__.'/helpers/mysql.php';
    include_once __DIR__.'/helpers/helper.php';
    
    $helper = new Helper();

    // Retrieving the course details
    $db = new Mysql_Driver();
    $db->connect();

    $sql = "SELECT * FROM Course";
    $result = $db->query($sql);

    $db->close();

    $img = "https://images.unsplash.com/photo-1461749280684-dccba630e2f6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80";
?>

<!DOCTYPE html>
<html lang="en">
    <?php include $helper->subviewPath('header.php') ?>
    <main class="container">
        <header>
            <h1>Fullscreen Landing Page</h1>
        </header>
        <section id="courses">
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
        </section>
    </main>

    <?php include $helper->subviewPath('footer.php') ?>
</html>