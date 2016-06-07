var ready;

var build_uoms = function(uoms){
    var arr = []

    uoms.forEach(function(uom){
        var option = $('<option>').val(uom[1]).text(uom[0]);
        arr.push(option);
    });

    $("select#measurement_uom").html(arr);
}

ready = function(){
    $("select#measurement_property").change(function(){
        var select = $(this);
        var selected = $(this).find(":selected");
        var property = selected.val();

        $.ajax({
            url: select.data("url"),
            type: "GET",
            data: { property: property },
            success: function(data){
                build_uoms(data);
            }
        });
    });
}
$(document).on('turbolinks:load', ready);