// SetUp datepicker for all data-behaviour
$(document).ready(function(){
    setup_currency();
    radio_img_select();
    start_base_chart();
    setup_date_picker();
    setup_tooltips_types();
    //create_shorter_links();
    focus_all_currency_mask();
    toggle_icon_orientation();
    add_alert_to_form_error();
    prevent_click_on_disabled();
    show_campaign_type_description();
    // TODO metodo que joga fixed on top MENU se tiver datepicker? Achar uma forma paleativa de por o fixed top e margin top se quebrar o Datepicker
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

// Dynamic class alert added
function add_alert_to_form_error() {
    $('#error_explanation').addClass('alert alert-danger');
}

function prevent_click_on_disabled() {
    $('.disabled').click(function(e){
        e.preventDefault();
    });
}

// show the Ad dynamic after it "upload_intent"
function show_ad_image(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e){
            $('#new_ad_image')
                .attr('src',e.target.result);
        };
        reader.readAsDataURL(input.files[0]);
    }
}

// SetUp mask for currency inputs
function setup_currency() {
    $('.currency_mask').maskMoney();
}

// Focus the first input on the form
function focus_all_currency_mask() {
    setTimeout(function(){
        masks = $('.currency_mask');
        masks.focus();

        // Focus all masks
        for(var i=0; i<masks.length; i++) $(masks[i]).focus();
    }, 500);
}

// Toggle the icons bottom to up & up to bottom
function toggle_icon_orientation(){
    $('.toggle').click(function(){
        element_toggle(this);
    });

    $('a').click(function(){
        element_toggle(this);
    });

    function element_toggle(interacted_element) {
        // Element references
        var down_icon = $($(interacted_element).find('i[class*="-down"]')[0]);
        var up_icon = $($(interacted_element).find('i[class*="-up"]')[0]);

        // Classes as String
        if(down_icon != undefined) if(down_icon.length > 0) var down_icon_classes = down_icon.attr('class').split(' ');
        if(up_icon != undefined) if(up_icon.length > 0) var up_icon_classes = up_icon.attr('class').split(' ');

        // Classes names
        var down_class_name = '';
        var up_class_name = '';

        // Getting those names
        if(down_icon != undefined) if(down_icon.length != 0) for(i=0; i<down_icon_classes.length; i++) if(down_icon_classes[i].indexOf('down') >= 0) down_class_name = down_icon_classes[i];
        if(up_icon != undefined) if(up_icon.length != 0) for(i=0; i<up_icon_classes.length; i++) if(up_icon_classes[i].indexOf('up') >= 0) up_class_name = up_icon_classes[i];

        var new_down_class = down_class_name.substring(0, down_class_name.indexOf('down'))+'up';
        var new_up_class = up_class_name.substring(0, up_class_name.indexOf('up'))+'down';

        if(down_icon != undefined) {
            down_icon.removeClass(down_class_name);
            down_icon.addClass(new_down_class);
        }

        if(up_icon != undefined) {
            up_icon.removeClass(up_class_name);
            up_icon.addClass(new_up_class);
        }
    }
}

// Toggle between well & alert, when alert is success & same Height x Width of the Well
function radio_img_select(element){
    interacted_element = $(element);
    img = interacted_element.find('img');
    interacted_element.parent().parent().find('label').removeClass('alert alert-success');
    interacted_element.addClass('alert alert-success');
}

// Find links to be shorter
function create_shorter_links() {
    // Aux vars
    var links_str = [];
    var current_url_counter = 0;
    var links_element = $('.original_link');

    // Get all Links
    for(i=0; i<links_element.length; i++) links_str.push($(links_element[i]).html());
    easy_shorter(links_str, current_url_counter);
}

// *Recursive
function easy_shorter(links, current_url_counter) {
    if (links.length == current_url_counter) return;

    // Foreach it links array
    jQuery.urlShortener({
        longUrl:links[current_url_counter],
        success: function(shortUrl){
            // SetUp pre-conditions;
            var anchor_tag = $('a[data-rel="'+links[current_url_counter]+'"]');

            // Setting the attrs values
            anchor_tag.html(shortUrl);
            anchor_tag.attr('href', shortUrl);

            // Init the recursive
            easy_shorter(links, current_url_counter+1);
        }
    });
}

function start_base_chart() {
    Chart.defaults.global.responsive = true;
    var buyers_element = document.getElementById('myChart');
    if(buyers_element == null) return;
    var buyers = buyers_element.getContext('2d');

    var buyerData = {
        labels: ["January", "February", "March", "April", "May", "June"],
        datasets: [
            {
                fillColor: "rgba(172,194,132,0.4)",
                strokeColor: "#ACC26D",
                pointColor: "#fff",
                pointStrokeColor: "#9DB86D",
                data: [203, 156, 99, 251, 305, 247]
            }
        ]
    }

    // TODO remove options to be curved
    var options = {bezierCurve:false, bezierCurveTension:0};
    new Chart(buyers).Line(buyerData, options);
}

function show_campaign_type_description() {
    $('input[type="radio"]').change(function(){
        // Base vars
        var campaign_type_selector = $('#campaign_type_select');
        var id = $(this).attr('value');

        // Remove all arrows & add it selected arrow
        campaign_type_selector.removeClass(function(index, css){
            return (css.match (/(^|\s)arrow-\S+/g) || []).join(' ');
        });

        // Add it arrow
        campaign_type_selector.addClass('arrow-'+id);

        // Show if it is not visible yet
        if(!campaign_type_selector.is(":visible")) campaign_type_selector.slideToggle();
    });
}
