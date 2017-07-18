<healthy style="display: block;margin-bottom: 55px;">
	<div class="forword" onclick="{ gohistory }">
        <div class="back"><span>{ health }</span></div>
    </div>
    <div class="bannerbox" if={ banner!= "undefined" }>
        <a href="{ banner_url }">
            <img src="{ banner }" alt="">
        </a>
    </div>
    <videoItem each="{ recommends }"></videoItem>
	<videoItem each="{ recommendPage }"></videoItem>
    <page></page>
    <style>
        .bannerbox{
            width: 100%;
            margin-bottom: 10px;
        }
        .bannerbox img{
            width: 100%;
            height: 150px;
        }
    </style>
	<script>
		var self = this;

        var page = 0;

        self.healthy = decodeURI(location.href.split("healthy=")[1].split("&")[0]);
        self.health = self.healthy.split("tag")[1];


        if(location.href.indexOf("banner") != -1){
            self.banner = decodeURI(location.href.split("banner=")[1].split("&")[0]);
            self.banner_url = decodeURI(location.href.split("bannerurl=")[1].split("&")[0]);
        }
        console.log(self.banner);
        if(location.href.indexOf("page") != -1){
            self.page = decodeURI(location.href.split("page=")[1].split("&")[0]);
        }else{
            self.page = 0;
        }

        var dfs_token = jQuery.parseJSON(dfs.getCookie('dfs_token'));
        //console.log(dfs_token);

        var healthy = {
        	token: dfs_token.id,
        	page: self.page,
        	keyword : self.healthy
        };
        

		this.gohistory = function(){
            window.history.go(-1);
        };
        RiotControl.trigger("getHealthyVideoList",healthy);
        RiotControl.on("healthyVideoListChanged",function(data){
        	// console.log(data);
            $(data).each(function(){
                if(this.media == "4"){
                    this.media = "专题号";
                }else{
                    this.media = "大夫号";
                }
                if(this.viewersnum >= 10000){
                    this.viewersnum = Number(this.viewersnum/10000).toFixed(1)+"w+";                    }
            });
            self.recommends = data;
            self.update();
        });

        $(window).scroll(function () {
            //$(window).scrollTop()这个方法是当前滚动条滚动的距离
            //$(window).height()获取当前窗体的高度
            //$(document).height()获取当前文档的高度
            var bot = 50; //bot是底部距离的高度
            if ((bot + $(window).scrollTop()) >= ($(document).height() - $(window).height())) {
                var healthy = {
                    token: dfs_token.id,
                    page: self.page+1,
                    keyword : self.healthy
                };
                RiotControl.trigger("getHealthyVideoList",healthy);
                RiotControl.on("healthyVideoListChanged",function(data){
                    
                    $(data).each(function(){
                        self.recommends.push(this);
                    });
                    console.log(self.recommends);
                    self.update();
                    
                });
            }
            
        });
        
        
	</script>
</healthy>
<videoItem class="video-item" onclick="{ toVideoPlay }">
	<div class="videoDetail" onclick="{ playVideoUrl }">
        <div class="videoInfo" >
            <div class="videoTitle">{ title }</div>
            <div class="videoTxt">{ content }</div>
            <div class="videoData">
                <div class="mediaType col-md-4 col-xs-4"><span>{ media }</span></div>
                <div class="ilikecnt col-md-4 col-xs-4">{ _data.comments.length }</div>
                <div class="viewNum col-md-4 col-xs-4">{ viewersnum }</div>
            </div>
        </div>
        <div class="videoVcover">
                <img src="{ vcover }" alt=""  class="more-video-img">
                <div class='watermark'><img src="../images/version2/icon/icon_play_home.png"></div>
        </div>
    </div>
	<script>
		var self = this;
		toVideoPlay(){
            var toVideoPlayUrl = "videoDetail.html?vid="+ self._id +"&uid=" + self.userid;
            window.location.href = toVideoPlayUrl;
        }
        
	</script>
</videoItem>

<page class="page">
    <span onclick="{ pre }">上一页</span>
    <span onclick="{ next }">下一页</span>
    <script>
        var self = this;
        var pageNext = Number(self.parent.page)+1;
        var pagePre = Number(self.parent.page)-1;

        if(pagePre == -1){
            pagePre = 0;
        };
        self.pageNextUrl = "healthy.html?healthy="+self.parent.healthy+"&banner=" + self.parent.banner +"&bannerurl="+self.parent.banner_url+"&page="+ pageNext;
        self.pagePreUrl = "healthy.html?healthy="+self.parent.healthy+"&banner=" + self.parent.banner +"&bannerurl="+self.parent.banner_url+"&page="+ pagePre;
        this.next=function(){
            window.location.href = self.pageNextUrl;
        }
        this.pre=function(){
            window.location.href = self.pagePreUrl;
        }

    </script>
    <style>
        .page{
            display: block;
            height: 50px;
            line-height: 50px;
            text-align: center;
            overflow: hidden;
        }
        .page span{
            background: #fff;
            text-align: center;
            margin: 0 10px;
            padding: 5px 15px;
            border: 1px solid #999;
            border-radius: 15px;
        }
        .ko{
            color: #ed4542;
        }
    </style>
</page>