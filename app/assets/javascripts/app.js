// SetUp datepicker for all data-behaviour
$(document).ready(function(){
    setup_currency();
    radio_img_select();
    start_base_chart();
    setup_date_picker();
    setup_tooltips_types();
    //create_shorter_links();
    budget_value_behaviour();
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
        $(masks[0]).focus();
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
    };

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

// Behaviours for the budget amount input
function budget_value_behaviour() {
    $('.budget_value').keyup(function(){
        update_budget();
    });
}

// Return a float based on the passed number
function currency_to_float(currency_str) {
    var cents = currency_str.slice(-2);

    //remove the dots like 1.000 to 1000
    var without_dots = currency_str.replace(/[^0-9\,]+/g, '');
    var amount = without_dots.substr(0, without_dots.indexOf(','));

    return parseFloat(amount+'.'+cents);
}

// Return a float based on the passed number
function float_to_currency(float_num, thousands, decimal) {
    if(thousands==null) thousands_separator = '.';
    else thousands_separator = thousands;
    if(decimal==null) decimal_separator = ',';
    else decimal_separator = decimal;

    var float_separator = '.';
    var cents;

    // Force to be a String
    if(typeof float_num == 'number') float_str = ''+float_num;
    else float_str = float_num;

    // SetUp vars
    if(float_str.indexOf(float_separator) >= 0) cents = float_str.substr(float_str.indexOf(float_separator)+1, float_str.length-1);
    else cents = '00';

    if(cents.length == 1) cents=cents+'0';
    if(float_str.indexOf(float_separator) < 0) amount = float_str;
    else amount = float_str.substr(0, float_str.indexOf('.'));

    // Add separators for each thousand
    amount = amount.replace(/(\d)(?=(\d\d\d)+([^\d]|$))/g, '$1'+thousands_separator);

    return amount+decimal_separator+cents;
}

function pay_it_tax(element) {
    var current_element = $(element);
    var budget_element = $('#budget_value');
    var float_budget = currency_to_float(budget_element.val());

    var new_budget = calc_budget(float_budget);
    update_budget();
    budget_element.val(new_budget);
    budget_element.focus();

    if(current_element.is(':checked')) budget_element.attr('readonly', '');
}

// Update the Budget value
function update_budget() {
    // SetUp selectors
    var current_element = $('.budget_value');
    var expected_budget = current_element.val();
    var taxes_paid = $('#budget_taxes_paid');
    var budget_result = $('#budgeted');

    // TODO Those taxes values must be on the DB in the future
    var gov_tax = 0.2;
    var card_tax = 0.05;
    var taxes = gov_tax+card_tax;
    var real_budget_amount;

    // Calculate the new budget
    if(taxes_paid.is(':checked')) real_budget_amount = expected_budget;
    else if(!taxes_paid.is(':checked')) {
        var currency_float = currency_to_float(expected_budget);
        var budget_without_pay_taxes = currency_float-(currency_float*taxes);
        real_budget_amount = float_to_currency(budget_without_pay_taxes);
    }

    // EndEvent
    budget_result.html(real_budget_amount);
}

function calc_budget(expected_value) {
    var gov_tax = 0.2;
    var card_tax = 0.05;
    var full_tax = gov_tax+card_tax;
    var full_val_const = 1;

    budget_calculated = expected_value/(full_val_const-full_tax);
    budget_calculated_str = ''+budget_calculated.toFixed(2);
    budget_calculated_without_dots = budget_calculated_str.split('.').join('');

    return budget_calculated_without_dots;
}
