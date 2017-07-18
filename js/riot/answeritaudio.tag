<answeritaudio class="answerit">
    <div class="forword" onclick="{ gohistory }">
        <div class="back"><span>语音回答</span></div>
    </div>
    
	<div class="top">
		<div>
			<div class="asktitle">{ question.title }</div>
			<div class="created">{ question.created }</div>
			<div style="overflow-x: scroll;overflow-y: inherit;">
				<div class="pics">
					<pictures each="{ question.pictures }" class="pic-item"></pictures>
				</div>
			</div>
		</div>
		
	</div>
	<script>
		var self = this;
		self.id = location.href.split("id=")[1].split("&")[0];
		var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));
        var infos = {
            "questionid" : self.id,
            "userid": dfs_cookie.userId
        }
		RiotControl.trigger("getPayVideoList",infos);
        RiotControl.on("payVideoListChanged",function(data){
            self.question = data;
            // console.log(data);
            self.update();
            var bodyHeight = document.body.scrollHeight;
            var aHeight = document.getElementsByClassName("answerit")[0].offsetHeight;
            var record = document.getElementsByClassName("record")[0];
            var recordHeight = bodyHeight - aHeight - 60;
            record.style.height = recordHeight+"px";
            // `console.log(aHeight);
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
	</script>
	<script>
		var self = this;
        /*
		var currentUrl = location.href.split('#')[0];
		RiotControl.trigger("getWxConfig",currentUrl);
        RiotControl.on("wxConfigChanged",function(data){
            self.wxconfig = data;
            console.log(data);
            wx.config({
    		    debug: false, 
    		    appId: data.appId, 
    		    timestamp: data.timestamp, 
    		    nonceStr: data.nonceStr, 
    		    signature: data.signature,
    		    jsApiList: data.jsApiList 
    		});
            self.update();
        });
        */
	</script>
</answeritaudio>