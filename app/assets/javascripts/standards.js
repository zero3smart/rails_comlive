$(document).ready(function(){

    //changing content view mode
    $('.btn-view-type').on('click', function(){
        var switchButton = $(this).find('i');
        if( switchButton.hasClass('fa-th-list') ){
            switchButton.removeClass('fa-th-list').addClass('fa-th-large');
            $('.grid').addClass('hide').next('.list').removeClass('hide');
        }else{
            switchButton.removeClass('fa-th-large').addClass('fa-th-list');
            $('.list').addClass('hide').prev('.grid').removeClass('hide');
        }
    });

    (function( $ ) {

        var $container = $('.grid');
        $container.imagesLoaded( function () {
            $container.masonry({
                columnWidth: '.grid-sizer',
                itemSelector: '.grid-item',
                percentPosition: true
            });
        });

        //Reinitialize masonry inside each panel after the relative tab link is clicked -
        $('a[data-toggle=tab]').each(function () {
            var $this = $(this);

            $this.on('shown.bs.tab', function () {

                $container.imagesLoaded( function () {
                    $container.masonry({
                        columnWidth: '.grid-sizer',
                        itemSelector: '.grid-item',
                        percentPosition: true
                    });
                });

            }); //end shown
        });  //end each

    })(jQuery);


});
