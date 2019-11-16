// Index.php javascript fullpagejs

var runOnce = true;

new fullpage('#fullpage', {
    //options here
    licenseKey: 'CD50B0E4-F5FD4F8C-AF7C78F1-5B645B1D',
    slidesNavigation: true,
    scrollHorizontally: true,
    navigation: true,
    scrollOverflow: true,
    resetSliders: true,
    //controlArrows:false,
    // navigationTooltips: ['01', '02', '03'],
    anchors: ['home', 'overview', '1', '2', '3', '4', '5', 'footer'],
    onLeave: function(origin, destination, direction) {
        console.log("onleave occured");
        addStickyNav(destination, direction);
        if (runOnce === false) {
            return runOnce;
        } else {
            runOnce = false;
            return !runOnce;
        }
    },
    afterLoad: function(origin, destination, direction) {
        console.log("afterload occured")
        removeStickyNav(destination, direction);
        if (origin.index > 1 && origin.item.id != "sectionfooter") {
            fullpage_api.resetSlides(origin.item.id, 0);
        }
        runOnce = true;
    }

});

//methods

// method for fullpagejs page such as Index php
function addStickyNav(destination, direction) {
    var navbar = document.getElementsByClassName("navbar")[0];
    var navbarPlaceholder = document.getElementsByClassName("navbar-placeholder")[0];

    if (direction === "down") {
        navbar.classList.add("sticky-top");
        navbar.style.opacity = "90%";
        navbarPlaceholder.style.height = "0px";
    } else if (direction === "up" && destination.item.id === "section-header") {
        navbar.style.opacity = "100%";
        navbarPlaceholder.style.height = "56px";
    }
}

function removeStickyNav(destination, direction) {
    var navbar = document.getElementsByClassName("navbar")[0];

    if (direction === "up" && destination.item.id === "section-header") {
        navbar.classList.remove("sticky-top");
    }
}

// fullpage_api.setAllowScrolling(true);


// Custom JS for sticky navbar

document.onscroll = function() {
    toggleStickyNav();
};

// for non-fullPage js php page e.g module.php
function toggleStickyNav() {
    var navbar = document.getElementsByClassName("navbar")[0];
    var navbarPlaceholder = document.getElementsByClassName("navbar-placeholder")[0];
    var offsetTop = navbar.offsetTop;

    if (window.pageYOffset > offsetTop) {
        navbar.classList.add("sticky-top");
        navbarPlaceholder.style.height = "56px";
    } else {
        navbar.classList.remove("sticky-top");
        navbarPlaceholder.style.height = "56px";
    }
}



/* Modules.php scripts */

/*collapsible button(module_year)*/
var coll = document.getElementsByClassName("collapsible");
var i;

for (i = 0; i < coll.length; i++) {
    coll[i].addEventListener("click", function() {
        this.classList.toggle("active");
        var content = this.nextElementSibling;
        if (content.style.display === "none") {
            content.style.display = "block";
        } else {
            content.style.display = "none";
        }
        if (content.style.maxHeight) {
            content.style.maxHeight = null;
        } else {
            content.style.maxHeight = content.scrollHeight + "px";
        }
    });
}

/* filter */
filterSelection("all")

function filterSelection(c) {
    var x, i;
    x = document.getElementsByClassName("filterDiv");
    if (c == "all") c = "";
    for (i = 0; i < x.length; i++) {
        w3RemoveClass(x[i], "show");
        if (x[i].className.indexOf(c) > -1) w3AddClass(x[i], "show");
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

// Add active class to the current button (highlight it)
var btnContainer = document.getElementById("myBtnContainer");
var btns = btnContainer.getElementsByClassName("btn");
for (var i = 0; i < btns.length; i++) {
    btns[i].addEventListener("click", function() {
        var current = document.getElementsByClassName("active");
        current[0].className = current[0].className.replace(" active", "");
        this.className += " active";
    });
}