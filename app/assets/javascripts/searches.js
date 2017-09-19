$(document).ready(function(){
    var commodityEngine,brandEngine,standardEngine;

    var commodities_autocomplete_url = $("#global-search-form").data("commodity-au");
    var brands_autocomplete_url = $("#global-search-form").data("brand-au");
    var standards_autocomplete_url = $("#global-search-form").data("standard-au");

    commodityEngine = new Bloodhound({
        identify: function(o) { return o.id; },
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
        dupDetector: function(a, b) { return a.id === b.id; },
        remote: {
            url:  commodities_autocomplete_url + '?query=%QUERY',
            wildcard: '%QUERY'
        }
    });

    brandEngine = new Bloodhound({
        identify: function(o) { return o.id; },
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
        dupDetector: function(a, b) { return a.id === b.id; },
        remote: {
            url:  brands_autocomplete_url + '?query=%QUERY',
            wildcard: '%QUERY'
        }
    });

    standardEngine = new Bloodhound({
        identify: function(o) { return o.id; },
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
        dupDetector: function(a, b) { return a.id === b.id; },
        remote: {
            url:  standards_autocomplete_url + '?query=%QUERY',
            wildcard: '%QUERY'
        }
    });

    $("#global-search").typeahead({
        minLength: 2,
        highlight: true,
        hint: true
    }, {
        name: 'commodities',
        source: commodityEngine,
        displayKey: 'name',
        templates: {
            suggestion: function (data) {
                return "<a href=" + data.href + ">" + data.name + "</a>";
            },
            header: '<h5 class="result-type">Commodities</h5>'
        }
    }, {
        name: 'brands',
        source: brandEngine,
        displayKey: 'name',
        templates: {
            suggestion: function (data) {
                return "<a href=" + data.href + ">" + data.name + "</a>";
            },
            header: '<h5 class="result-type">Brands</h5>'
        }
    }, {
        name: 'standards',
        source: standardEngine,
        displayKey: 'name',
        templates: {
            suggestion: function (data) {
                return "<a href=" + data.href + ">" + data.name + "</a>";
            },
            header: '<h5 class="result-type">Standards</h5>'
        }
    });
})
