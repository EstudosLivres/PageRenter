$(function(){
    var textfield = $("input[name=username]");
    var passfield = $("input[name=password]");
    $('button[type="submit"]').click(function(e) {
        e.preventDefault();
        //little validation just to check username
        if (textfield.val()!="" && passfield.val()!="") {
            $.post('/api/users/admin_login', {username:textfield.val(), password:passfield.val()}, function(data){
                console.log(data);
                if (data.status == 'error') {
                    //remove success mesage replaced with error message
                    $("#output").removeClass(' alert alert-success');
                    $("#output").addClass("alert alert-danger animated fadeInUp").html("Username or Password incorrect or you are not ADMIN");
                }else if(data.status == 'ok') {
                    //show avatar
                    avatar_url = "https://graph.facebook.com/"+textfield.val()+"/picture?type=large";
                    avatar_img = $('#avatar');
                    avatar_img.attr('src', avatar_url);
                    avatar_img.addClass('user_avatar');
                    $(".avatar").css({"background-image":avatar_url});
                    //$("body").scrollTo("#output");
                    $("#output").addClass("alert alert-success animated fadeInUp").html("Welcome back " + "<span style='text-transform:uppercase'>" + textfield.val() + "</span>");
                    $("#output").removeClass(' alert-danger');
                    $("input").css({
                        "height":"0",
                        "padding":"0",
                        "margin":"0",
                        "opacity":"0"
                    });
                    //change button text
                    $('button[type="submit"]').html("continue")
                        .removeClass("btn-info")
                        .addClass("btn-default").click(function(){
                            $("input").css({
                                "height":"auto",
                                "padding":"10px",
                                "opacity":"1"
                            }).val("");
                        });
                }
            });
        } else {
            //remove success mesage replaced with error message
            $("#output").removeClass(' alert alert-success');
            $("#output").addClass("alert alert-danger animated fadeInUp").html("sorry enter a username ");
        }
    });
});