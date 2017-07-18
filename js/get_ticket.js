/**
 * get ticket
 *
 * **/


//wechat config
var app_id = "wx068ee0d254ecf088";



function get_tickit(url, callback) {
    $.getJSON("http://wx.daifushuo.com/get-ticket?url=" + url, function (data) {
        callback(data);
    });
}


$(function () {
    var encode_url = encodeURIComponent(location.href.split('#')[0]);
    var url = location.href.split('#')[0]
    var video = document.getElementById("#video");
    var postid = $("#video").attr("postid");
    var share_url = location.search;
    var postid = (share_url.split("vid=")[1]).split("&")[0];
    var userid = (share_url.split("vid=")[1]).split("uid")[1].split("=")[1];
    var post_url = "http://api.daifushuo.com:80/api/oposts/dfs_load_post_by_id?postid="+postid;
    var share_title,share_content,share_img;
    $.get(post_url,function(data){
        //console.log(data);
        share_title  = data.title;
        share_content  = data.content;
        share_img = data.vcover;
    });
    //server config
    get_tickit(encode_url, function(data) {

        //console.log(data);
        //console.log(typeof data);

        wx.config({
            debug: false, // 开启调试模式,调用的所有api的返回值会在客户端console.log出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
            appId: app_id, // 必填，公众号的唯一标识
            timestamp: data.timestamp, // 必填，生成签名的时间戳
            nonceStr: data.nonceStr, // 必填，生成签名的随机串
            signature: data.signature,// 必填，签名，见附录1
            jsApiList: ['onMenuShareTimeline', 'onMenuShareAppMessage'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
        });

        wx.ready(function(){
            // wx.hideAllNonBaseMenuItem();

            // wx.showMenuItems({
            //     menuList: ["menuItem:share:appMessage", "menuItem:share:timeline",  "menuItem:favorite"] // 要显示的菜单项，所有menu项见附录3
            // });
//分享到朋友圈
            //console.log(share_title);
            // console.log(share_content);
            wx.onMenuShareTimeline({
                title: share_title, // 分享标题
                link: url, // 分享链接
                desc: share_content,
                imgUrl: share_img, // 分享图标
                success: function () {
                    $.post(dfs.apiPostUrl+"/dfs_add_sharesum",function() {

                    });
                    //console.log('share success');
                },
                cancel: function () {
                    //console.log('share cancel');
                    // 用户取消分享后执行的回调函数
                }
            });

//分享给朋友
            wx.onMenuShareAppMessage({
                title: share_title, // 分享标题
                desc: share_content, // 分享描述
                link: url, // 分享链接
                imgUrl: share_img, // 分享图标
                type: 'link', // 分享类型,music、video或link，不填默认为link
                dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
                success: function () {
                    // 用户确认分享后执行的回调函数
                    $.post(dfs.apiPostUrl+"/dfs_add_sharesum",postid,function() {

                    });
                    
                    //console.log('share success message');
                },
                cancel: function () {
                    //console.log('share cancel');
                    // 用户取消分享后执行的回调函数
                }
            });


            // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
        });

        wx.error(function(res){
            //console.log('wx config error');
            //console.log(res);
            //console.log(res);

            // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。

        });


    });
});