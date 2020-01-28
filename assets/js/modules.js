filterSelection("all")

function filterSelection(c) {
    console.log(c);
    var x, i;
    x = document.getElementsByClassName("filterDiv");
    if (c == "all") c = "";
    for (i = 0; i < x.length; i++) {
        w3RemoveClass(x[i], "highlight");
        if (x[i].className.indexOf(c) > -1) w3AddClass(x[i], "highlight");
    }
}

function w3AddClass(element, name) {
    var i, arr1, arr2;
    arr1 = element.className.split(" ");
    arr2 = name.split(" ");
    for (i = 0; i < arr2.length; i++) {
        if (arr1.indexOf(arr2[i]) == -1) { element.className += " " + arr2[i]; }
    }
}

function w3RemoveClass(element, name) {
    var i, arr1, arr2;
    arr1 = element.className.split(" ");
    arr2 = name.split(" ");
    for (i = 0; i < arr2.length; i++) {
        while (arr1.indexOf(arr2[i]) > -1) {
            arr1.splice(arr1.indexOf(arr2[i]), 1);
        }
    }
    element.className = arr1.join(" ");
}

// Add active class to the current button filters (highlight it)
var btnContainer = document.getElementById("myBtnContainer");
var btns = btnContainer.getElementsByClassName("filter-btn");
for (var i = 0; i < btns.length; i++) {
    btns[i].addEventListener("click", function() {
        var current = document.getElementsByClassName("active");
        current[0].className = current[0].className.replace(" active", "");
        this.className += " active";
    });
}

// Add active class to the clicked tab btn
var tabBtns = document.querySelectorAll(".tabs .tab-link");
for (var i = 0; i < tabBtns.length; i++) {
    tabBtns[i].addEventListener("click", function() {
        var current = document.querySelectorAll(".tab-link.active");
        current[0].className = current[0].className.replace(" active", "");
        this.className += " active";
    })
}

// Event for tablinks
openTab('year-1', true);

function openTab(tabName, firstLoad = false) {
    // Set the default current tab-link
    if (firstLoad) {
        var tabBtns = document.querySelectorAll(".tabs .tab-link");
        tabBtns[0].classList.add("active");
    }

    // Hide all elements with class="tabcontent" by default 
    $(".tab-content").hide();
    console.log(`.${tabName}`);
    $(`.${tabName}`).fadeIn(800);
}

// Adding on click in module cards
var moduleCards = document.querySelectorAll(".filterDiv .card-body");

for (var i = 0; i < moduleCards.length; i++) {
    moduleCards[i].addEventListener("click", function() {
        var module_id = this.id;
        getAjaxModuleInfo(module_id);
    });
}

function getAjaxModuleInfo(module_id) {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', `../process/fetchModuleInfo.php?module_id=${module_id}`)
    xhr.onload = function() {
        var response = JSON.parse(xhr.response);
        console.log(response)
        if (response.status === 200) {
            var moduleObj = response.data;
            populateModuleOverlay(moduleObj)
        } else { // if response is 400 or 404
            // redirect to server error TO-DO*
        }
    }
    xhr.send()
}

function populateModuleOverlay(moduleObj) {

    var moduleName = document.querySelector(".module-modal .modal-body .title");
    var moduleImg = document.querySelector(".module-modal .modal-body .image");
    var moduleDescription = document.querySelector(".module-modal .modal-body .description");

    moduleName.innerHTML = moduleObj.module_name;
    moduleImg.src = `../${moduleObj.item_path}`;
    moduleDescription.innerHTML = moduleObj.module_description;

    // check if it is scrollable


    // modalBody.addEventListener("scroll", function() {
    //     if (this.offsetHeight > this.clientHeight) {
    //         scrollArrows.style.opacity = 1;
    //     } else {
    //         scrollArrows.style.opacity = 0;
    //     }
    // });
    $('.module-modal').on('show.bs.modal', function (e) {
        // do something...
        var scrollArrows = document.querySelector('.module-modal .scrolldown');
        scrollArrows.style.opacity = 0;
    })
    $('.module-modal').on('shown.bs.modal', function (e) {
        // do something...
        var modalBody = document.querySelector('.module-modal .modal-body');
        var scrollArrows = document.querySelector('.module-modal .scrolldown');
        console.log(modalBody);
        console.log(`offset: ${modalBody.offsetHeight} client: ${modalBody.clientHeight}`);
        if (modalBody.scrollHeight > modalBody.clientHeight) {
            scrollArrows.style.opacity = 1;
        } else {
            scrollArrows.style.opacity = 0;
        }
    })
    $('.module-modal').modal('show');

}

var closeBtn = document.querySelector(".module-modal .close-modal")

closeBtn.addEventListener("click", function() {
    $('.module-modal.in').modal('hide');
})