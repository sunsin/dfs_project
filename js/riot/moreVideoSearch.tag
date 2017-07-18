<search class='video-search video-search-box'>
    <video-search each="{ videoSearch }"></video-search>
    <page></page>
    <script>
        var self = this;
        riot.route(function(){
            var q = riot.route.query();
            self.query = decodeURI(q.query);
            self.page = q.page;
            //console.log(self.page);
            self.update();
        });
        riot.route.stop();
        riot.route.start(true);

        if(location.search.indexOf("&") != -1){
            self.query = self.query || location.search.split("query=")[1].split("&")[0];
        }else{
            self.query = self.query || location.search.split("query=")[1];
        }
        if(location.search.indexOf("page") != -1){
            self.page = self.page || location.search.split("page=")[1];
            if(location.search.indexOf("&") != -1){
                self.page = self.page || location.search.split("page=")[1].split("&")[0];
            }else{
                self.page = self.page || location.search.split("page=")[1];
            }
        }else{
            self.page = 0;  
        }

        self.query = decodeURI(self.query);
        if(typeof(self.page) == "undefined"){
            self.page = 0;
        }
        if(isNaN(self.page)){
            self.page = 0;
        }

        

        var message = {
            query: self.query,
            page: self.page
        };

        RiotControl.trigger("getSearchList",message);
        RiotControl.on("searchChanged",function(data){
        console.log(data);
            $(data[1]).each(function(){
                if(this.media == "4"){
                    this.media = "专题号";
                }else{
                    this.media = "大夫号";
                }
            });
            self.doctorSearch = data[0];
            self.videoSearch = data[1];
            if(data[1].length<1){
                $(".video-search-box").append("<div class='nodata'><div>暂无数据</div></div>");
                $(".page").hide();
            }

            self.update();
        });
    </script>
</search>
<video-search onclick="{ playVideoUrl }" class='video-item'>
    <div class="videoDetail">
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
    playVideoUrl(){
        self.playVideoUrl = "videoDetail.html?vid=" + self._id + "&uid=" + self.userid;
        window.location.href = self.playVideoUrl;
    }
    
    </script>
</video-search>

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
    self.pageNextUrl = "moreVideoSearch.html?query="+self.parent.query+"&page="+ pageNext;
    self.pagePreUrl = "moreVideoSearch.html?query="+self.parent.query+"&page="+ pagePre;
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
        background: #f3f3f3;
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