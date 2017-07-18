<commen style="display: block;margin-bottom: 55px;">
	<div class="forword" onclick="{ gohistory }">
        <div class="back"><span>{ pageTitle }</span></div>
    </div>
    <video-item each="{ recommends }"></video-item>
    <healthy-item each="{ healthy }"></healthy-item>
    <script>
    	var self = this;
    //路由解析
        riot.route(function(){
            var q = riot.route.query();
            self.commen = decodeURI(q.commen);
            //console.log(self.topic);
            self.update();
        });
        riot.route.stop();
        riot.route.start(true);

        var page = 0;

        self.commen = self.commen || location.href.split("=")[1];

        if(self.commen == "healthy"){
        	self.pageTitle = "健康专题"
        	RiotControl.trigger("getHealthyList",page);
	        RiotControl.on("healthyListChanged",function(data){
	            self.healthy = data;
	            console.log(data);
	            self.update();    
	        });
        }else{
        	self.pageTitle = "推荐视频";
        	RiotControl.trigger("getRecommendList",page);
	        RiotControl.on("recommendListChanged",function(data){
	        	console.log(data);
	            self.recommends = data;
	            
	            self.update();
	        });
        }

        this.gohistory = function(){
            window.history.go(-1);
        };

    </script>
</commen>


<video-item class="video-item" onclick="{ toVideoPlay }">
	<div class="txt">
		<div class='title'>{ title }</div>
		<div class='info'>
			<span>{ _data.comments.length }</span>
			<span>{ viewersnum }</span>
		</div> 
	</div>
	<div class='cover'>
		<img src="{ vcover }" alt="">
        <span class='watermark'><img src="../images/login/play.png"></span>
	</div>
	<script>
		var self = this;
		toVideoPlay(){
            var toVideoPlayUrl = "videoDetail.html?vid="+ self._id +"&uid=" + self.userid;
            window.location.href = toVideoPlayUrl;
        }
	</script>
</video-item>


<healthy-item class="health-item" onclick="{ healthy }">
	<div class='cover'>
        <img src="{ cover }" alt="">
        <div class="bg"></div>
    </div>
    <div class='title'>{ title }</div>
    
    <script>
        var self = this;
        healthy(){
        	var toHealthyUrl = "healthy.html?healthy=" + self.keyword + "&banner=" + self.banner + "&bannerurl=" + self.banner_url;
            window.location.href = toHealthyUrl;
        }
    </script>
    <style>
        .health-item:last-child{
            padding-bottom: 60px;
        }
    </style>
</healthy-item>
