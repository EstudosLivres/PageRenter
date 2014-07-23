// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

// nome do arquivo em PT por causa do adblock
function show_ad_image(input) {
    if (input.files && input.files[0])
    {
        var reader = new FileReader();
        reader.onload = function (e)
        {
            $('#new_ad_image')
                .attr('src',e.target.result);
        };
        reader.readAsDataURL(input.files[0]);
    }
}