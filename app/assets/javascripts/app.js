// SetUp datepicker for all data-behaviour
$(document).ready(function(){
    setup_date_picker();
    setup_tooltips_types();
});

// Re-add it dropdown-menu event for every page:change
$(document).on("page:change", function() {
    $(".navbar .dropdown").hover((function() {
        $(this).find(".dropdown-menu").first().stop(true, true).slideDown();
    }), function() {
        $(this).find(".dropdown-menu").first().stop(true, true).slideUp();
    });
});

/*
 * placement = left,right,top,bottom
 */
function set_up_tiper(tipers, placement) {
    for(i in tipers) {
        tiper = $(tipers[i]);
        tiper.attr('data-toggle', 'tooltip');
        tiper.attr('data-placement', placement);
    }
}

// SetUp DatePicker listener event
function setup_date_picker() {
    var datepicker_input = $('[data-behaviour~="datepicker"]');
    if(datepicker_input == undefined || datepicker_input === undefined) return;

    datepicker_input.datepicker({
        autoclose: true,
        format: 'dd/mm/yyyy',
        language: 'pt-BR',
        startDate: 'today'
    });
}

// Tooltips types setup
function setup_tooltips_types() {
    tipers = $('.tooltiper.top');
    set_up_tiper(tipers, 'top');

    tipers = $('.tooltiper.bottom');
    set_up_tiper(tipers, 'bottom');

    tipers = $('.tooltiper.left');
    set_up_tiper(tipers, 'left');

    tipers = $('.tooltiper.right');
    set_up_tiper(tipers, 'right');

    $('.tooltiper').tooltip({trigger:'hover'});
}