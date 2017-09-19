var ready;

ready = function(){

    var div = $("div#predefined-properties");
    var minMaxDiv = $("div#value-min-max");
    var filterUomsSelect = $('#type_of_measure');
    var specPropertyInput = $("#specification_property");

    $("input[name='spec-type']").change(function(){
        var selected = $(this).val();

        if(selected == "custom"){
            div.addClass("hidden");
            minMaxDiv.removeClass("hidden");
            filterUomsSelect.parents('.form-group').removeClass('hidden');
            specPropertyInput.parents('.form-group').removeClass('hidden');
        } else if(selected == "predefined"){
            div.removeClass('hidden');
            minMaxDiv.addClass("hidden");
            filterUomsSelect.parents('.form-group').addClass('hidden');
            specPropertyInput.parents('.form-group').addClass('hidden');
            $("#min-max-container").addClass('hidden');
            $("#value-container").removeClass('hidden');
        }

        var checkedRadioBtnValue = $('#predefined-properties input[type="radio"]:checked').val();
        specPropertyInput.val(checkedRadioBtnValue);
    });

    $("input[name='kind']").change(function(){
        var radioButton = $(this);
        var value = radioButton.val();
        var type = radioButton.data("type");

        specPropertyInput.val(value);
        filterUomsSelect.val(type).trigger('change');
    });
    
}

$(document).ready(ready);
