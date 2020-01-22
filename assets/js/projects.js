function populateProjectOverlay(projectObj) {

    var projectName = document.querySelector(".module-modal .modal-body .title");
    var projectImg = document.querySelector(".module-modal .modal-body .image");
    var projectDescription = document.querySelector(".module-modal .modal-body .description");

    projectName.innerHTML = projectObj.project_name;
    projectImg.src = `../${projectObj.item_path}`;
    projectDescription.innerHTML = projectObj.project_desc;
    $('.module-modal1').modal('show');
}