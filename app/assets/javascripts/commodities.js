var ready, table;
var renderOptions = function(options, select){
    var opts = [];
    opts.push($('<option>').val("").text('Select Chapter'));
    options.forEach(function(option){
        var opt = $('<option>').val(option.id).text(option.description);
        opts.push(opt);
    });
    select.html(opts);
}

ready = function(){
    // fix for selec2 inside bootstrap modal
    $.fn.modal.Constructor.prototype.enforceFocus = function() {};
    
    // init select2
    $('.select2').select2({
        width: '100%'
    });

    // Images slider
    $('#image-gallery').lightSlider({
        gallery:true,
        item:1,
        thumbItem:9,
        slideMargin: 0,
        speed:500,
        auto:false,
        loop:false,
        onSliderLoad: function() {
            $('#image-gallery').removeClass('cS-hidden');
        }
    });

    
    $("button#assign-hscode").click(function(e){
        e.preventDefault();

        var form = $(this).parents('.modal-content').find("form");
        form.submit();
    });

    $("select#commodity_hscode_section_id").change(function(){
        var selected = $(this).find(":selected");
        var value    = selected.val();
        var url      = $(this).data("href");

        var child_select = $("select#commodity_hscode_chapter_id");
        child_select.html('<option>Loading....</option>');
        $("select#commodity_hscode_heading_id").html('<option value="">Select Heading</option>');
        $("select#commodity_hscode_subheading_id").html('<option value="">Select Sub Heading</option>');

        $.ajax({
            type: "GET",
            url: url,
            data: { hscode_section_id: value },
            success: function(data){
                renderOptions(data, child_select);
            }
        });
    });

    $("select#commodity_hscode_chapter_id").change(function(){
        var selected = $(this).find(":selected");
        var value    = selected.val();
        var url      = $(this).data("href");

        var child_select = $("select#commodity_hscode_heading_id");
        child_select.html('<option>Loading....</option>');

        $.ajax({
            type: "GET",
            url: url,
            data: { hscode_chapter_id: value },
            success: function(data){
                renderOptions(data, child_select);
            }
        });
    });

    $("select#commodity_hscode_heading_id").change(function(){
        var selected = $(this).find(":selected");
        var value    = selected.val();
        var url      = $(this).data("href");

        var child_select = $("select#commodity_hscode_subheading_id");
        child_select.html('<option>Loading....</option>');

        $.ajax({
            type: "GET",
            url: url,
            data: { hscode_heading_id: value },
            success: function(data){
                renderOptions(data, child_select);
            }
        });
    });

    table = $('table#unspsc_segments').DataTable({
        pagingType: "full_numbers",
        bProcessing: true,
        bServerSide: true,
        sAjaxSource: $('table#unspsc_segments').data('source'),
        "order": []
    });

    $("a.load-in-modal").click(function(e){
        e.preventDefault();

        var url = $(this).attr("href");
        var title = $(this).text();

        $( "#sharedModal .modal-body" ).load(url, function(response,status,xhr) {
            var modalBody =  $( "#sharedModal .modal-body" );

            $("#sharedModal .modal-header h4.modal-title").text(title);

            // hide elements
            modalBody.find('h4.header-title').hide();
            modalBody.find("p.text-muted").hide();
            modalBody.find("form input[type='submit']").hide();

            $("#sharedModal").modal();
            
            var specificationProperty =  $("select#type_of_measure");
            if(specificationProperty.length){
                specificationPropertyCallbacks();
                allUoms();
            }

            if($("#sharedModal select.select2").length){
                $("#sharedModal select.select2").select2({
                    width: "100%"
                });
            }
        });
    });

    $("button#submit-modal-form").click(function(e){
        e.preventDefault();

        var form = $("#sharedModal").find("form");
        form.submit();
    });
    
    // autocomplete
    var engine, prefetch_url, autocomplete_url;

    prefetch_url        =  $("#commodity-search").data("prefetch-url");
    autocomplete_url    =  $("#commodity-search").data("autocomplete-url");

    if($("#commodity-search").length)

        engine = new Bloodhound({
            identify: function(o) { return o.id; },
            queryTokenizer: Bloodhound.tokenizers.whitespace,
            datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
            dupDetector: function(a, b) { return a.id === b.id; },
            prefetch: {
                url: prefetch_url
            },
            remote: {
                url: autocomplete_url + '?query=%QUERY',
                wildcard: '%QUERY'
            }
        });

        $("#commodity-search").typeahead({
            minLength: 2,
            highlight: true,
            hint: true
        }, {
            source: engine,
            displayKey: 'name',
            templates:{
                suggestion:function(data) {
                    return "<a href=" + data.href + ">"+ data.name +"</a>";
                }
            }
        });
    
    $("input[name='commodity-product']").change(function(){
        var selected = $(this).val();
        var select = $("select#commodity_brand_id");
        var div = $("div#commodity-brand");
        var checkbox =  $("input#commodity_generic");

        if(selected == "commodity"){
            select.prop("selectedIndex", 0);
            checkbox.prop("checked",true);
            div.addClass("hidden");
            $("p.commodity-desc").removeClass("hidden");
            $("p.product-desc").addClass("hidden");
        } else if(selected == "product"){
            checkbox.prop("checked",false);
            div.removeClass('hidden');
            $("p.commodity-desc").addClass("hidden");
            $("p.product-desc").removeClass("hidden");
        }
    });


}

$(document).on("click", "a.unspsc-drilldown", function(e){
    e.preventDefault();

    var url = $(this).data("href");
    var type = $(this).data("type");
    table.ajax.url(url).load();

    $('#unspsc_segments caption').text("UNSPSC " + type);
});

$(document).on("click","a.assign-unspsc", function(e){
    e.preventDefault();

    var url = $("#unspsc_segments").data("submit-url");
    var unspsc_commodity_id = $(this).data("id");

    $.ajax({
        type: "PATCH",
        url: url,
        data: { commodity: { unspsc_commodity_id: unspsc_commodity_id } }
    });
});

$(document).on("change", "input[name='value-opts']", function(){
    var radio = $(this);
    if(radio.is(":checked"))
        var value = radio.val();
        if(value == "value"){
            $("#min-max-container").addClass('hidden');
            $("#value-container").removeClass('hidden');
            $('#min-max-container').find('input[type="number"]').val('');
        }
        if(value == "min-max"){
            $("#value-container").addClass('hidden');
            $("#min-max-container").removeClass('hidden');
            $("#value-container").find('input[type="number"]').val('');
        }
});

$(document).ready(ready);
