var ready, select2For;

select2For = function(select){
    var url = select.data("url");

    select.select2({
        ajax: {
            url: url,
            dataType: 'json',
            delay: 250,
            data: function (params) {
                return {
                    q: params.term || "", // search term
                    page: params.page || 1
                };
            },
            processResults: function (data, params) {
                // parse the results into the format expected by Select2
                // since we are using custom formatting functions we do not need to
                // alter the remote JSON data, except to indicate that infinite
                // scrolling can be used
                params.page = params.page || 1;

                return {
                    results: $.map(data.items, function(item){
                        return {
                            text: item.name,
                            id: item.id
                        }
                    }),
                    pagination: {
                        more: !data.last_page
                    }
                };
            },
            cache: true,
        },
        // minimumInputLength: 3,
        width: '100%'
    })
}

ready = function(){
    // $("input#commodity_generic").change(function(){
    //     var checkbox = $(this);
    //     var checked = checkbox.is(":checked");
    //     var ref_select = $("select#commodity_reference_brand_id");
    //     var com_select = $("select#commodity_brand_id");
    //     var div = $("div#commodity-brand");
    //
    //     if(checked){
    //         ref_select.prop("selectedIndex", 0);
    //         com_select.prop("selectedIndex", 0);
    //         div.hide();
    //         checkbox.parent().css("margin-bottom","40px");
    //     } else {
    //         checkbox.parent().css("margin-bottom","10px");
    //         div.show();
    //     }
    // });

    // on page load
    var source_commodity = $("#reference_source_commodity_id");
    if(source_commodity.length){
        select2For(source_commodity);
    }
    // Textarea auto resize
    $('textarea.autoresize').each(function () {
        this.setAttribute('style', 'height:' + (this.scrollHeight) + 'px;overflow-y:hidden;');
    }).on('input', function () {
        this.style.height = 'auto';
        this.style.height = (this.scrollHeight) + 'px';
    });
    var standardization_select = $("#standardization_standard_id");
    if(standardization_select.length){
        select2For(standardization_select);
    }
}

$(document).ready(ready);

