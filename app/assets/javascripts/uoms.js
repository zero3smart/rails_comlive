var ready;

var build_uoms = function(uoms){
    var arr = []

    uoms.forEach(function(uom){
        var option = $('<option>').val(uom[1]).text(uom[0]);
        arr.push(option);
    });

    $("select#specification_uom").html(arr);
}

function specificationPropertyCallbacks() {
    $("select#type_of_measure").change(function () {
        var select = $(this);
        var selected = $(this).find(":selected");
        var property = selected.val();

        $.ajax({
            url: select.data("url"),
            type: "GET",
            data: {property: property},
            success: function (data) {
                build_uoms(data);
            }
        });
    });
}
ready = function(){
    specificationPropertyCallbacks();
}

$(document).ready(ready);