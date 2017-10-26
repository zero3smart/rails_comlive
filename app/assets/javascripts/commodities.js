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

var select2For = function(select){
    url = select.data("url");

    select.select2({
        ajax: {
            url: url,
            dataType: 'json',
            delay: 250,
            data: function (params) {
                return {
                    q: params.term, // search term
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
            cache: true
        },
        minimumInputLength: 1,
        width: '100%'
    });
}

ready = function(){
    // fix for selec2 inside bootstrap modal
    $.fn.modal.Constructor.prototype.enforceFocus = function() {};

    // init select2
    $('.select2').select2({
        width: '100%'
    });

    $("input#commodity_reference_generic,  input#commodity_generic").change(function(){
        var checkbox = $(this);
        var checked = checkbox.is(":checked");
        var select = $("select#commodity_reference_brand_id");
        var div = $("div#commodity-brand");

        if(checked){
            select.prop("selectedIndex", 0);
            div.hide();
            checkbox.parent().css("margin-bottom","40px");
        } else {
            checkbox.parent().css("margin-bottom","10px");
            div.show();
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

            // additional scripts
            var source_commodity = $("#reference_source_commodity_reference_id");
            var target_commodity = $("#reference_target_commodity_reference_id");
            if(source_commodity.length && target_commodity.length){
                select2For(source_commodity);
                select2For(target_commodity);
            }

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

    // on page load
    var source_commodity = $("#reference_source_commodity_reference_id");
    var target_commodity = $("#reference_target_commodity_reference_id");
    if(source_commodity.length && target_commodity.length){
        select2For(source_commodity);
        select2For(target_commodity);
    }

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