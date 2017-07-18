<myfans class="fansList">
	<div class="forword" onclick="{ gohistory }">
	    <div class="back"><span>我的粉丝</span></div>
	</div>
	<fans each="{myinfo }"></fans>	
	<script>
		var userid = location.href.split("userid=")[1].split("&")[0];
		var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));
		var ew = {
			"userid": userid,
			"token": dfs_cookie.id
		};
		var self = this;
		RiotControl.trigger("getDoctorFansList",ew);
        RiotControl.on("doctorFansChanged",function(data){
            self.myinfo = data;
            console.log(data);
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
	</script>
	
</myfans>

<fans class="fans-item" onclick="{ toPersonal }">
	<div>
		<img src={ avatar[0] }>
	    <div>
	        <div class='nickname'>{ nickname }</div>
	        <div></div>
	    </div>
	</div>
    <script>
    	var self = this;
    	toPersonal(){
    		var url = "personal.html?userid=" + self._id;
    		location.href = url;
    	}
    	
    </script>
</fans>