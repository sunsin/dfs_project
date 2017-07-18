/*!
 * jQuery Cookie Plugin v1.4.1
 * https://github.com/carhartl/jquery-cookie
 *
 * Copyright 2013 Klaus Hartl
 * Released under the MIT license
 */
(function (factory) {
    if (typeof define === 'function' && define.amd) {
        // AMD
        define(['jquery'], factory);
    } else if (typeof exports === 'object') {
        // CommonJS
        factory(require('jquery'));
    } else {
        // Browser globals
        factory(jQuery);
    }
}(function ($) {

    var pluses = /\+/g;

    function encode(s) {
        return config.raw ? s : encodeURIComponent(s);
    }

    function decode(s) {
        return config.raw ? s : decodeURIComponent(s);
    }

    function stringifyCookieValue(value) {
        return encode(config.json ? JSON.stringify(value) : String(value));
    }

    function parseCookieValue(s) {
        if (s.indexOf('"') === 0) {
            // This is a quoted cookie as according to RFC2068, unescape...
            s = s.slice(1, -1).replace(/\\"/g, '"').replace(/\\\\/g, '\\');
        }

        try {
            // Replace server-side written pluses with spaces.
            // If we can't decode the cookie, ignore it, it's unusable.
            // If we can't parse the cookie, ignore it, it's unusable.
            s = decodeURIComponent(s.replace(pluses, ' '));
            return config.json ? JSON.parse(s) : s;
        } catch (e) {
        }
    }

    function read(s, converter) {
        var value = config.raw ? s : parseCookieValue(s);
        return $.isFunction(converter) ? converter(value) : value;
    }

    var config = $.cookie = function (key, value, options) {

        // Write

        if (value !== undefined && !$.isFunction(value)) {
            options = $.extend({}, config.defaults, options);

            if (typeof options.expires === 'number') {
                var days = options.expires, t = options.expires = new Date();
                t.setTime(+t + days * 864e+5);
            }

            return (document.cookie = [
                encode(key), '=', stringifyCookieValue(value),
                options.expires ? '; expires=' + options.expires.toUTCString() : '', // use expires attribute, max-age is not supported by IE
                options.path ? '; path=' + options.path : '',
                options.domain ? '; domain=' + options.domain : '',
                options.secure ? '; secure' : ''
            ].join(''));
        }

        // Read

        var result = key ? undefined : {};

        // To prevent the for loop in the first place assign an empty array
        // in case there are no cookies at all. Also prevents odd result when
        // calling $.cookie().
        var cookies = document.cookie ? document.cookie.split('; ') : [];

        for (var i = 0, l = cookies.length; i < l; i++) {
            var parts = cookies[i].split('=');
            var name = decode(parts.shift());
            var cookie = parts.join('=');

            if (key && key === name) {
                // If second argument (value) is a function it's a converter...
                result = read(cookie, value);
                break;
            }

            // Prevent storing a cookie that we couldn't decode.
            if (!key && (cookie = read(cookie)) !== undefined) {
                result[name] = cookie;
            }
        }

        return result;
    };

    config.defaults = {};

    $.removeCookie = function (key, options) {
        if ($.cookie(key) === undefined) {
            return false;
        }

        // Must not alter options, thus extending a fresh object...
        $.cookie(key, '', $.extend({}, options, {expires: -1}));
        return !$.cookie(key);
    };

}));

/**
 * get user-info
 *
 * **/


//wechat config
var app_id = "wx068ee0d254ecf088";

function get_code(redirect_uri) {
    var redirect_uri = encodeURIComponent(redirect_uri);
    var auth_url_template = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=' + app_id + '&redirect_uri=' + redirect_uri + '&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect';
    window.location = auth_url_template;
    return;
}

function get_userinfo(code, callback) {
    $.getJSON("http://wx.daifushuo.com/get-userinfo?code=" + code, function (data) {
        callback(data);
    });
}

function get_wxuserinfo(code, callback) {
    $.getJSON("http://wx.daifushuo.com/get-userinfo-pc?code=" + code, function (data) {
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
    //alert("das");

    // get user info
    $.cookie.json = true;

    window.flag = $.cookie('userinfo');
    var dfs_token = $.cookie('dfs_token');
    var code = getUrlParameter('code');
    var state = getUrlParameter('state');

    var openid;

    if (window.flag) {
        

    } else {
        if (!code) {
            var current_url = window.location.href;
            get_code(current_url);
        } else {
            if (state == 'pc'){
                get_wxuserinfo(code, function (data) {
                    $.cookie('userinfo', data, {expires: 3600});
                    
                    openid = data.openid;
                    //oauth2login
                    $.post("http://api.daifushuo.com/api/ousers/oauth2Login", data, function (result) {
                        var access_token = result.id;
                        dfs.userid = result.userId;
                        var url_now = window.location.href;
                        window.location.reload(url_now);
                        //console.log(url_now);
                        $("#access_token").text(access_token);
                        //console.log(result.userid);
                        // $.cookie('dfs_token', null, {expires: 3600});
                        $.cookie('dfs_token', result, {expires: 3600});
                    });
                    //$.cookie('dfs_token', result, { expires: 3600 });

                })
            }else{
                get_userinfo(code, function (data) {
                    // $.cookie('userinfo', null, {expires: 3600});
                    $.cookie('userinfo', data, {expires: 3600});
                    
                    var userinfo = data;
                    openid = data.openid;
                    //oauth2login
                    $.post("http://api.daifushuo.com/api/ousers/oauth2Login", data, function (result) {
                        var access_token = result.id;
                        dfs.userid = result.userId;
                        $.cookie('dfs_token', result, {expires: 3600});
                        if (userinfo && result) {
                            zhuge.track("用户",result.userId);
                            var gender;
                            if(userinfo.sex == 1){
                                gender = "男";
                            }else if(userinfo.sex == 2){
                                gender = "女";
                            }else{
                                gender = "未知";
                            }
                            zhuge.identify(result.userId,{
                                avatar: userinfo.headimgurl,
                                name:  userinfo.nickname,   
                                gender:  gender  
                            });
                            var access_token = result.id;
                            dfs.userid = result.userId;
                            $("#access_token").text(access_token);

                        }
                        var url_now = window.location.href;
                        window.location.reload(url_now);

                    });
                    //$.cookie('dfs_token', result, { expires: 3600 });

                })
            }
                
        }
    }
    //console.log(dfs_token.id);
    
});
