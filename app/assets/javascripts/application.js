// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
// require bootstrap TODO add GoogleMaps GEM (UPDATE)
// require gmaps/google TODO add GoogleMaps GEM
//= require angular
//= require zeroclipboard
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.pt-BR.js
//= require app.js

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