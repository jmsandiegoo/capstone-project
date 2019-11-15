
// Index.php javascript fullpagejs

new fullpage('#fullpage', {
    //options here
    licenseKey: 'CD50B0E4-F5FD4F8C-AF7C78F1-5B645B1D',
    slidesNavigation: true,
    scrollHorizontally: true,        
    navigation:true,
    scrollOverflow:true,
    resetSliders:true,
    //controlArrows:false,
    // navigationTooltips: ['01', '02', '03'],
    anchors: ['home', 'overview', '1', '2','3','4','5','footer'],
    onLeave: function(origin, destination, direction) {
        addStickyNav(destination, direction); 
        var dest = fullpage_api.getActiveSection().index -1 
        if(destination.index > 1 && destination.item.id != "sectionfooter" && fullpage_api.getActiveSlide().index > 0 ){
            fullpage_api.silentMoveTo(dest,0);    
            }          
        
        
        // add more functions here
    },
    afterLoad: function(origin, destination, direction) {
        removeStickyNav(destination, direction);        
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





