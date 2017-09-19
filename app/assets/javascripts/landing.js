// This is a manifest file that'll be compiled into landing.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require_tree
//= require slick.min
//= require jquery.form-validator.min


function menuShowHide(){
    if( $(window).scrollTop() > 200 ){
    
      $('.landing .navbar-brand').removeClass('visible-xs');
      $('.landing.navbar-fixed-top').addClass('navbar-bg')
    }
   
    else{
      $('.landing .navbar-brand').addClass('visible-xs');
      $('.landing.navbar-fixed-top').removeClass('navbar-bg');
    }
  }

$(window).scroll(function(){
    menuShowHide();
});


//scrolling for top navigation
var ready;

ready = function(){
    $.validate({
        form : '#contact-form'
    });
    
    menuShowHide();

    $('a[href*="#"]:not([href="#"])').click(function() {
        if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
            var target = $(this.hash);
            target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
            if (target.length) {
                $('html, body').animate({
                    scrollTop: target.offset().top - $('.navbar').outerHeight()
                }, 1000);
                return false;
            }
        }
    });

    window.cookieconsent.initialise({
        "palette":{
            "popup": {
                "background":"#edeff5","text":"#838391"
            },
            "button":{
                "background":"#4b81e8"
            }
        },
        "position":"bottom-right",
        "content":{
            "message":"This website uses cookies to ensure you get the best experience when you use it."
        }
    });
}

$(document).ready(ready);

$(document).on('ready', function() {

  $(".center").slick({
    dots: true,
    infinite: true,    
    slidesToShow: 4,
    slidesToScroll: 1, 
    autoplay: true,
    autoplaySpeed: 2000,
    responsive: [
      {
        breakpoint: 769,
        settings: {
          arrows: false,
          slidesToShow: 3
        }
      },
      {
        breakpoint: 480,
        settings: {
          arrows: false,
          slidesToShow: 1
        }
      }
    ]
  });

});
