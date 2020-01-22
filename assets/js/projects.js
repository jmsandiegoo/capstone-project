// Adding on click in project poster
var projectPoster = document.querySelectorAll(".btcarousel-item .card-body");

for (var i = 0; i < projectPoster.length; i++) {
    projectPoster[i].addEventListener("click", function() {
        var project_id = this.id;
        getAjaxProjectInfo(project_id);
    });
}

function getAjaxProjectInfo(project_id) {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', `../process/fetchProjectInfo.php?project_id=${project_id}`)
    xhr.onload = function() {
        var response = JSON.parse(xhr.response);
        console.log(response)
        if (response.status === 200) {
            var projectObj = response.data;
            populateProjectOverlay(projectObj)
        } else { 
            
        }
    }
    xhr.send()
}

function populateProjectOverlay(projectObj) {

    var projectName = document.querySelector(".module-modal1 .modal-body .title");
    var projectImg = document.querySelector(".module-modal1 .modal-body .image");
    var projectDescription = document.querySelector(".module-modal1 .modal-body .description");

    projectName.innerHTML = projectObj.project_name;
    projectImg.src = `../${projectObj.item_path}`;
    projectDescription.innerHTML = projectObj.project_desc;
    $('.module-modal1').modal('show');
}

var closeBtn = document.querySelector(".module-modal1 .close-modal")

closeBtn.addEventListener("click", function() {
    $('.module-modal1.in').modal('hide');
})