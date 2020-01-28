var project_id = getUrlParameter('project_id');
if (project_id) {
    var projectSection = document.querySelector('#projectWrapper');
    var heightOfHeader = document.querySelector('.navbar').offsetHeight;
    // window.scrollTo({left: 0, top: projectSection.offsetTop - heightOfHeader, behavior:'smooth'});
    var i = window.pageYOffset;
    var int = setInterval(function() {
      window.scrollTo(0, i);
      i += 10;
      if (i >= projectSection.offsetTop - heightOfHeader) {
          clearInterval(int);
          getAjaxProjectInfo(project_id);
        }
    }, 3.5);
}

// Functions
function getUrlParameter(name) {
    name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
    var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
    var results = regex.exec(location.search);
    return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
};

var drag = false;

$(document).ready(function(){
    $('.carousel').slick({
    dots: true,
    centerMode: false,
    infinite: true,
    speed: 500,
    autoplay: false,
    slidesToShow: 3,
    draggable: true,
    slidesToScroll: 3,
    cssEase: 'linear',
    // swipeToSlide: true,
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
            arrows: false,
            dots: true
        }
        }
        // You can unslick at a given breakpoint now by adding:
        // settings: "unslick"
        // instead of a settings object
    ]
    });

    $('.carousel').on('beforeChange', function(event, slick, currentSlide, nextSlide){
        console.log('Before Change')
        drag = true;
      });
      
      // On before slide change
      $('.carousel').on('afterChange', function(event, slick, currentSlide){
        console.log('After Change');
        drag = false;
      });
});

// Adding on click in project poster
var projectPoster = document.querySelectorAll(".btcarousel-item");
for (var i = 0; i < projectPoster.length; i++) {
    projectPoster[i].addEventListener("click", function() {
        if (drag){
            console.log("click fail");
            return;
        }
        var project_id = this.dataset.id
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
    var projectName = document.querySelector(".project-modal .modal-body .title");
    var projectImg = document.querySelector(".project-modal .modal-body .image");
    var projectDescription = document.querySelector(".project-modal .modal-body .description");

    projectName.innerHTML = projectObj.project_name;
    projectImg.src = `../${projectObj.item_path}`;
    projectDescription.innerHTML = projectObj.project_desc;

    $('.project-modal').on('show.bs.modal', function (e) {
        // do something...
        var scrollArrows = document.querySelector('.project-modal .scrolldown');
        scrollArrows.style.opacity = 0;
    })
    $('.project-modal').on('shown.bs.modal', function (e) {
        // do something...
        var modalBody = document.querySelector('.project-modal .modal-body');
        var scrollArrows = document.querySelector('.project-modal .scrolldown');
        console.log(modalBody);
        console.log(`offset: ${modalBody.offsetHeight} client: ${modalBody.clientHeight}`);
        if (modalBody.scrollHeight > modalBody.clientHeight) {
            scrollArrows.style.opacity = 1;
        } else {
            scrollArrows.style.opacity = 0;
        }
    })
    $('.project-modal').modal('show');
}

var closeBtn = document.querySelector(".project-modal .close-modal")

closeBtn.addEventListener("click", function() {
    $('.project-modal.in').modal('hide');
})