var login_value;
var check_user_url;
var picture_url;
var avatar;

$(function(){
    avatar = $('#avatar');
    var login_input = $('input[name="user[login]"]');
    login_input.keyup(function(){
        // Vars
        login_value = this.value;
        check_user_url = 'https://graph.facebook.com/'+login_value;
        picture_url = 'https://graph.facebook.com/'+login_value+'/picture?type=large';

        // Ajax
        $.get(check_user_url)
            .success(function(resp){profile_success(resp);})
            .error(function(resp){profile_error(resp);});
    });
});

function profile_success(resp) {
    avatar.addClass('custom_avatar');
    avatar.attr('src', picture_url);
}

function profile_error(resp) {
    avatar.removeClass('custom_avatar');
    avatar.attr('src', '/assets/thumb/logo-acronym-spacing.png');
}