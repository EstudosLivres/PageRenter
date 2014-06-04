// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

function show_campaign_image(input) {
    if (input.files && input.files[0])
    {
        var reader = new FileReader();
        reader.onload = function (e)
        {
            $('#new_campaign_image')
                .attr('src',e.target.result);
        };
        reader.readAsDataURL(input.files[0]);
    }
}