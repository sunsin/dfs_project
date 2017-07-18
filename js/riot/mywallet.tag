<mywallet class="mywallet">
    <div class="forword" onclick="{ gohistory }">
        <div class="back"><span>余额</span></div>
    </div>
	<div>
		<img src="../images/version2/2/icon_cash.png" alt="">
	</div>
	<div>￥{ total || 0}</div>
	<div>
		<a href="" id="reflect">余额大于1元可到APP中提现</a>
	</div>
	<script>
		var self = this;
		var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));
		RiotControl.trigger("getMyWalletInfomationList",dfs_cookie.userId);
        RiotControl.on("myWalletInfomationChanged",function(data){
            self.mywallet = data;
            //console.log(data);
           
            self.update();
        });
        gohistory(){
            if(document.referrer.indexOf("topic")!=-1){
                window.location.href = document.referrer;
            }else if(document.referrer == ""){
                window.location.href = "http://weixin.daifushuo.com";
            }else{
                window.history.go(-1);
            }
        }
        linkedme.init("linkedme_live_d88f9589ee225d010c0210b7944c550e", {type: "live"}, null);
        var data = {};
        data.params = '{"View":"MyCash"}';
        linkedme.link(data, function(err, data){
            if(err){
                // 生成深度链接失败，返回错误对象err
            } else {

                //console.log(data);
                var a = document.getElementById("reflect");
                a.setAttribute("href",data.url);
            }
        },false);
	</script>
</mywallet>