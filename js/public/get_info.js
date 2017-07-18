'use strict';
//wechat config
var app_id = "wx068ee0d254ecf088";

function get_code(redirect_uri) {
    var redirect_uri = encodeURIComponent(redirect_uri);
    var auth_url_template = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=' + app_id + '&redirect_uri=' + redirect_uri + '&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect';
    window.location = auth_url_template;
    return;
}

function get_userinfo(code, callback) {
    $.getJSON("http://wx.daifushuo.com/get-token?code=" + code, function (data) {
        callback(data);
    });
}
//server config


//help function get parameter from url
var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
};


$(function () {

    // get user info
    $.cookie.json = true;

    var flag = $.cookie('userinfo');
    var code = getUrlParameter('code');

    if (flag) {
        $('#nickname').text(flag.nickname);
        $('#headimage').attr('src', flag.headimgurl);
    } else {
        if (!code) {
            var current_url = window.location.href;
            get_code(current_url);
        } else {
            get_userinfo(code, function(data) {
                alert(data);
                $.cookie('userinfo', data, { expires: 5 });
                $('#nickname').text(data.nickname);
                $('#headimage').attr('src', data.headimgurl);
            })
        }
    }
alert(flag);

});
