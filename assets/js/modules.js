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
openPage('Year 1');

function openPage(pageName, button = null) {
    // Hide all elements with class="tabcontent" by default */
    var i, tabcontent, tablinks;

    // Hide all tabs first and remove active
    tabcontent = document.getElementsByClassName("tab-content");

    for (i = 0; i < tabcontent.length; i++) {
      tabcontent[i].style.display = "none";
    }

    if (!button) {
        var tabBtns = document.querySelectorAll(".tabs .tab-link");
        tabBtns[0].classList.add("active");
    }

    // Show the specific tab content
    document.getElementById(pageName).style.display = "block";
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

    var moduleOverlay = document.querySelector(".moduleInfoOverlay");
    var moduleName = document.querySelector(".moduleInfoOverlay .module-name");
    var moduleDescription = document.querySelector(".moduleInfoOverlay .module-description");

    moduleName.innerHTML = moduleObj.module_name;
    moduleDescription.innerHTML = moduleObj.module_description;
    moduleOverlay.classList.add("show");
}

var closeBtn = document.querySelector(".moduleInfoOverlay .close-overlay")

closeBtn.addEventListener("click", function() {
    closeModuleOverlay()
})

// close overlay
function closeModuleOverlay() {
    var moduleOverlay = document.querySelector(".moduleInfoOverlay");

    moduleOverlay.classList.remove("show");
}