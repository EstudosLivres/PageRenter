var login_value;
var check_user_url;
var picture_url;
var avatar;

$(function(){
    avatar = $('#avatar');
    var login_input = $('.username_avatar');
    login_input.keyup(function(){
        check_profile_img(this);
    });

    setTimeout(function(){
        login_input.trigger('keyup');
    }, 500);
});

function check_profile_img(input){
    // Vars
    login_value = input.value;
    check_user_url = 'https://graph.facebook.com/'+login_value;
    picture_url = 'https://graph.facebook.com/'+login_value+'/picture?type=large';

    // Ajax
    $.get(check_user_url)
        .success(function(resp){profile_success(resp);})
        .error(function(resp){profile_error(resp);});
}

function profile_success(resp) {
    avatar.addClass('custom_avatar');
    avatar.attr('src', picture_url);
}

function profile_error(resp) {
    avatar.removeClass('custom_avatar');
    avatar.attr('src', '/assets/thumb/logo-acronym-spacing.png');
}