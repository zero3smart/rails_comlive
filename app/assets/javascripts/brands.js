var ready,setLogo;

setLogo = function(url,input){
    var img = $('<img>').attr('src', url).addClass("img-responsive");
    var preview = "<div style='height: 100px; width: 100px; margin-bottom: 15px;'></div>";
    $("#"+ input).val(url);
    $("#"+ input).before($(preview).html(img));
}

ready = function(){
    $("[data-toggle='tooltip'], [rel='tooltip']").tooltip();
    
    $("form span.help-block").each(function(){
        $(this).parents(".form-group").addClass("has-error");
    });

    $("#navbar-search .form-control").on('focus blur', function(){
        $(this).parents("#navbar-search").toggleClass('is_focused');
    });

    $("#navbar-search .btn").on('click', function(){
        $(this).parents("#navbar-search").addClass('is_focused');
    });

    setTimeout(function(){
        $('#global-alert').slideUp('slow');
    }, 3500);

}
$(document).ready(ready);
