// SetUp datepicker for all data-behaviour
$(document).ready(function(){
    $('[data-behaviour~="datepicker"]').datepicker({
        autoclose: true,
        format: 'dd/mm/yyyy',
        language: 'pt-BR',
        startDate: 'today'
    });
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