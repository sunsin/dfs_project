<hotVideo class='hotVideo'>
    <div class="topicTitle">频道</div>
    <navList class='nav'></navList>
    <videolist class="videolist"></videolist>

    <page></page>

    <script>
        var self = this;
    //路由解析
        riot.route(function(){
            var q = riot.route.query();
            self.page = q.page;
            self.topic = decodeURI(q.topic) || "热门";
            //console.log(self.topic);
            self.update();
        });
        riot.route.stop();
        riot.route.start(true);
    //对URL传入的值进行预判
        if(location.search == ""){
            self.page = 0;
        }
        if(typeof(self.page) == "undefined"){
            self.page = 0;
        }

        if(location.search.indexOf("page") != -1){
            self.page = Number(location.search.split("page=")[1].split("&")[0]);
        }else{
            self.page = 0;
        }


    //判断topic
        if(location.href.indexOf("topic")!=-1){
            self.topic = self.topic || decodeURI(location.search.split("&")[0].split("=")[1]);
        }

        var topic;
        if(decodeURI(location.search.split("=")[1]) == "undefined"){
             topic = "热门";
             self.topic = topic;
        }

        
        self.topic = self.topic  || "热门";
        //console.log(self.topic);
    </script>

</hotVideo>

<navList>
    <ul class="line">
        <li each={ navLists }></li>
    </ul>
    <script>
        var self = this;
        RiotControl.trigger("getTopicList",self.parent.page?self.parent.page:0);
        RiotControl.on("topicListChanged",function(data){
            self.navLists = data;
            //console.log(data);

            self.update();

        });

        
        this.on('updated', function() {
            
            if(location.search.indexOf("topic") == -1){
              zhuge.track("topic",self.parent.topic);
              $(".line").find("li").eq(0).addClass("ko");
            }
            var count=0;

            for(var key in self.navLists){
                count++;
            }
            //console.log(count);

            for(var i=0;i<count;i++){
                if(self.navLists[i].description == self.parent.topic){
                    //console.log(i);
                    zhuge.track("topic",self.parent.topic);
                    $(".line").find("li").eq(i).addClass("ko");
                }
            }

        })
    </script>
</navList>

<li class="nav-item" onclick="{ topic }" topic="{ name }">
        <span>{ name }</span>
        <script>
            var self = this;
            this.topic = function(){
                self.parent.parent.topic = self.description;
                //console.log(self.parent.parent.topic);
                var topicUrl = "topic.html?topic="+self.description;
                window.location.href = topicUrl;
                riot.update(true);

            }

        </script>
</li>

    <!--tag viedo-list-->

<videolist >
    <video-item each={ ilist } vitem="{ this }" ></video-item>
    <script>

        var self = this;
        this.update(self.parent.topic);
        self.ilist = [];
        //var dfs_cookie = null;
        //var userinfo = null;
        var userinfo = jQuery.parseJSON(dfs.getCookie('userinfo'));
        var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));
        //console.log(self.parent.topic);
        //topic滚动条依据不同topic获取不同的接口内容
        if(self.parent.topic == "热门" || typeof(self.parent.topic) == "undefined"){
            RiotControl.trigger("getHotVideoList",self.parent.page?self.parent.page:0);
            RiotControl.on("videoHotListChanged",function(data){
                $(data).each(function(){
                    if(this.media == "4"){
                        this.media = "专题号";
                    }else{
                        this.media = "大夫号";
                    }
                    if(this.viewersnum >= 10000){
                        this.viewersnum = Number(this.viewersnum/10000).toFixed(1)+"w+";                    }
                });
                self.ilist = data;
                console.log(data);
                self.update();
            });
        }else if(self.parent.topic == "最新"){
            RiotControl.trigger("getNewVideoList",self.parent.page?self.parent.page:0);
            RiotControl.on("videoNewListChanged",function(data){
                $(data).each(function(){
                    if(this.media == "4"){
                        this.media = "专题号";
                    }else{
                        this.media = "大夫号";
                    }
                    if(this.viewersnum >= 10000){
                        this.viewersnum = Number(this.viewersnum/10000).toFixed(1)+"w+";                    }
                });
                self.ilist = data;
                //console.log(data);
                self.update();
            });
        }else if(self.parent.topic == "关注"){
            var page ={
                userid : dfs_cookie.userId || null,
                access_token : dfs_cookie.id || null,
                page: self.parent.page?self.parent.page:0
            };
            RiotControl.trigger("getFocusVideoList",page);
            RiotControl.on("videoFocusListChanged",function(data){
                $(data).each(function(){
                    if(this.media == "4"){
                        this.media = "专题号";
                    }else{
                        this.media = "大夫号";
                    }
                    if(this.viewersnum >= 10000){
                        this.viewersnum = Number(this.viewersnum/10000).toFixed(1)+"w+";                    }
                });
                self.ilist = data;
                //console.log(data);
                if(data.length<1){
                    $(".hotVideo").append("<div class='nodata'><div>暂无数据</div></div>");
                    $(".page").hide();
                }
                self.update();
            });
        }else{
            if(self.parent.topic == "临床护理"){
              self.parent.topic = "护理";
            }
            //console.log(self.parent.topic);
            var topicQuery = {
                size: 10,
                page: self.parent.page || 0,
                query: self.parent.topic
            };
            RiotControl.trigger("getOtherVideoList",topicQuery);
            RiotControl.on("videoOtherListChanged",function(data){
                $(data).each(function(){
                    if(this.media == "4"){
                        this.media = "专题号";
                    }else{
                        this.media = "大夫号";
                    }
                    if(this.viewersnum >= 10000){
                        this.viewersnum = Number(this.viewersnum/10000).toFixed(1)+"w+";                    }
                });
                self.ilist = data;
                //console.log(data);
                if(data.length<1){
                    $(".hotVideo").append("<div class='nodata'><div>暂无数据</div></div>");
                    $(".page").hide();
                }
                self.update();
            });

        }


    </script>
</videolist>

    <!--tag viedo-item-->
<video-item class="video-item">
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
                <div class='watermark'><img src="images/version2/icon/icon_play_home.png"></div>
        </div>
    </div>
    <script>
        var self = this;
        playVideoUrl(){
            self.playVideoUrl = "html/videoDetail.html?vid=" + self._id + "&uid=" + self.userid;
            window.location.href = self.playVideoUrl;
        }
    </script>

</video-item>

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
        self.pageNextUrl = "topic.html?topic="+self.parent.topic+"&page="+ pageNext;
        self.pagePreUrl = "topic.html?topic="+self.parent.topic+"&page="+ pagePre;
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
            color: #fff;
        }
    </style>
</page>
