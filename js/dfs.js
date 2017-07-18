var dfs = {};

dfs.protocols = 'http://';
dfs.Dn = 'api.daifushuo.com';
dfs.Port = '80';
dfs.cookie_domain = 'www.test.com';  // App Cookie domain setting

dfs.Url = dfs.protocols + dfs.Dn;
dfs.BaseUrl = dfs.Url + ':' + dfs.Port;

dfs.locals = {};
dfs.locals.images = [];
dfs.locals.videos = [];
dfs.locals.me = null;
dfs.pages = 0;
dfs.accessToken = null;
dfs.userId = null;

dfs.WaterMark = '大夫说';
//dfs.WaterMark = 'http://www.dfs.com/images/logo.png';
dfs.persistentNotifyUrl = dfs.BaseUrl + '/qn/notify';
// URL CONST VAR
dfs.apiBaseUrl = dfs.BaseUrl + '/api';
dfs.apiPostUrl = dfs.apiBaseUrl + '/oposts';
dfs.apiImageUrl = dfs.apiBaseUrl + '/oimages';
dfs.apiUserUrl = dfs.apiBaseUrl + '/ousers';
dfs.apiCommentUrl = dfs.apiBaseUrl + '/ocomments';
dfs.apiTagUrl = dfs.apiBaseUrl + '/otags';
dfs.apiFriendUrl = dfs.apiBaseUrl + '/ofriends';
dfs.apiBookmarkUrl = dfs.apiBaseUrl + '/obookmarks';
dfs.apiPmessageUrl = dfs.apiBaseUrl + '/opmessages';
dfs.apiPsessionUrl = dfs.apiBaseUrl + '/opsessions';
dfs.apiSearchUrl = dfs.apiBaseUrl + '/search';

dfs.apiToolUrl = dfs.apiBaseUrl + '/tools';
dfs.apiStreamUrl = dfs.apiBaseUrl + '/streamVideo';


var addEvent = function(dom, type, handle, capture) {   
    if(dom.addEventListener) {   
        dom.addEventListener(type, handle, capture);   
    } else if(dom.attachEvent) {   
        dom.attachEvent("on" + type, handle);   
    } 
};


//诸葛IO

window.zhuge = window.zhuge || [];
window.zhuge.methods = "_init debug identify track trackLink trackForm page".split(" ");
window.zhuge.factory = function(b) {
    return function() {
        var a = Array.prototype.slice.call(arguments);
        a.unshift(b);
        window.zhuge.push(a);
        return window.zhuge;
    }
};
for (var i = 0; i < window.zhuge.methods.length; i++) {
    var key = window.zhuge.methods[i];
    window.zhuge[key] = window.zhuge.factory(key);
}
window.zhuge.load = function(b, x) {
    if (!document.getElementById("zhuge-js")) {
        var a = document.createElement("script");
        var verDate = new Date();
        var verStr = verDate.getFullYear().toString()
            + verDate.getMonth().toString() + verDate.getDate().toString();

        a.type = "text/javascript";
        a.id = "zhuge-js";
        a.async = !0;
        a.src = (location.protocol == 'http:' ? "http://sdk.zhugeio.com/zhuge-lastest.min.js?v=" : 'https://zgsdk.zhugeio.com/zhuge-lastest.min.js?v=') + verStr;
        var c = document.getElementsByTagName("script")[0];
        c.parentNode.insertBefore(a, c);
        window.zhuge._init(b, x)
    }
};
window.zhuge.load('80166cfa7cc74f929f7af3368f5291e3');




//+===++++==
$(function(){
    //PC OR MOBILE
    var domain = document.domain;
    if(domain == "pc.daifushuo.com"){
        // alert("pc");
        $("body").css("width","80%");
        $("body").css("margin","0 auto");
        $(".linkin").attr("href","css/index_pc.css");

        $(".videoDetail").attr("href","../css/videoDetail_pc.css");
        $(".wechatcss").attr("href","../css/wechat_pc.css");
        $(".doctorDetail").attr("href","../css/doctorDetail_pc.css");
        $(".publiccss").attr("href","../css/public_pc.css");

    }

    //回退
    $(".forword").click(function(){
        //回退事件,因为回退到topic首页会在URL后面加上"#",所以对回退到topic页进行判断
        if(document.referrer.indexOf("topic")!=-1){
            window.location.href = document.referrer;
        }else if(document.referrer == ""){
            window.location.href = "http://weixin.daifushuo.com";
        }else if(typeof(document.referrer) == "undefined"){
            window.location.href = "http://weixin.daifushuo.com";
        }else{
            window.history.back();
        }


    });


    //二维码显示及隐藏
    $(".erweima").click(function(e){
        $(".erweima-img").show();
        console.log();
        e.stopPropagation();
    });
    $(document).click(function(){
        $(".erweima-img").hide();
    });


    $(".koko").each(function(){
        console.log(this);
    });

});



dfs.getCookie = function (nameCookie) {

    if (document.cookie.length >=0)
    {
        var begin = document.cookie.indexOf(nameCookie+"=");
        if (begin != -1)
        {
            begin += nameCookie.length+1;
            var end = document.cookie.indexOf(";", begin);
            if (end == -1) end = document.cookie.length;
            return unescape(document.cookie.substring(begin, end));
        }
    }
    // cookie不存在返回null
    return null;
};



