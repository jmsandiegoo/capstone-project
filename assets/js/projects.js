jQuery(document).ready(function(){
	jQuery(".project-product").click(function(){
		jQuery(".project-popup-div").fadeIn();
		jQuery("body").addClass("hiiden-f");
	}); 
	jQuery(".project-popup-div a").click(function(){
		jQuery(".project-popup-div").fadeOut();
		jQuery("body").removeClass("hiiden-f");
	}); 
}); 