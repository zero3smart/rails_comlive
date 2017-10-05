var ready;

var build_uoms = function(uoms){
    var arr = []

    uoms.forEach(function(uom){
        var option = $('<option>').val(uom[1]).text(uom[0]);
        arr.push(option);
    });

    $("select#specification_uom").html(arr);
}

var allUoms = function () {
    uoms = new Array();

    $.each($.unitwiseAtoms ,function(key,arrays){
        $.each(arrays, function(index,value){
            uoms.push(value);
        });
    });
    build_uoms(uoms);
}

function specificationPropertyCallbacks() {
    $("select#type_of_measure").change(function () {
        var select = $(this);
        var selected = $(this).find(":selected");
        var key = selected.val();
        var property = selected.text();

        if(key == ""){
            allUoms();
        } else {
            var data = $.unitwiseAtoms[key];
            if(data == undefined){
                $.ajax({
                    url: select.data("url"),
                    type: "GET",
                    data: { property: property },
                    success: function (data) {
                        build_uoms(data);
                    }
                });
            } else {
                build_uoms(data);
            }
        }
    });
}
ready = function(){
    specificationPropertyCallbacks();
    allUoms();
}

$(document).ready(ready);