    <hotVideo class='hotVideo'>
        <navList class='nav'></navList>

        <a class="search" href="/html/search.html">
        <span>搜索医生、视频</span>
        <span></span>
        </a>
        <span>热门推荐</span>
        <videolist class="videolist"></videolist>
        <page></page>
        <script>
        var self = this;

        self.topic = "热门";
        riot.route(function(){
        var q = riot.route.query()
        self.page = q.page;
        //console.log(self.page);
        self.update();
        });
        riot.route.stop();
        riot.route.start(true);

        if(location.search == ""){
        self.page = 0;
        }
        if(typeof(self.page) == "undefined"){
        self.page = 0;
        }
        </script>

        </hotVideo>
        <!--导航-->
        <navList>
        <ul class="line">
        <nav-item each={ navLists }></nav-item>

        </ul>
        <script>
        var self = this;
        RiotControl.trigger("getTopicList",self.parent.page?self.parent.page:0);
        RiotControl.on("topicListChanged",function(data){
        self.navLists = data;
        //console.log(data);
        self.update();
        });

        </script>
        </navList>

        <nav-item class="ko" onclick="{ topic }">
        <li>{ name }</li>
        <script>
        var self = this;
        this.topic = function(){
        self.parent.parent.topic = self.description;
        console.log(self.parent.parent.topic);
        riot.update(true);

        }
        </script>
        </nav-item>

        <!--搜索-->
        <search>
        <input placeholder="搜索医生、视频" />
        </search>

        <!--tag viedo-list-->
        <videolist >
        <video-item each={ ilist } vitem="{ this }" ></video-item>
        <script>

        var self = this;

        this.update(self.parent.topic);
        self.ilist = [];

        console.log(self.parent.topic);

        if(self.parent.topic == "热门" || typeof(self.parent.topic) == "undefined"){
        RiotControl.trigger("getHotVideoList",self.parent.page?self.parent.page:0);
        RiotControl.on("videoHotListChanged",function(data){
        self.ilist = data;
        //console.log(data);
        self.update();
        });
        }else if(self.parent.topic == "最新"){
        RiotControl.trigger("getNewVideoList",self.parent.page?self.parent.page:0);
        RiotControl.on("videoNewListChanged",function(data){
        self.ilist = data;
        //console.log(data);
        self.update();
        });
        }else{
        var topicQuery = {
        size: 10,
        page: self.page || 0,
        query: self.parent.topic
        };
        RiotControl.trigger("getOtherVideoList",topicQuery);
        RiotControl.on("videoOtherListChanged",function(data){
        self.ilist = data;
        //console.log(data);
        self.update();
        });

        }


        </script>
        </videolist>

        <!--tag viedo-item-->

        <!--时间倒序video列表-->
        <video-item class="video-item">
        <a href="{ playUrl }" vid="{ data._id }" id="vlink" class="linkvideo" userid="{ data.userid }">
        <img src="{ data.vlink }?vframe/jpg/offset/11" alt="">
        <span class='watermark'><img src="../images/login/play.png"></span>
        <span class='viewnum'>{ data.viewersnum }次播放</span>
        </a>
        <div class="description1">
        <span class='tit'>{ data.title }</span>
        </div>
        <div class="description2">
        <span class="addr">{ data._data.user.hospital }</span>
        <span class="administrative">{ data.room }</span>
        </div>

        <script>
        var self = this;
        self.data = opts.vitem;
        self.playUrl = "html/videoDetail.html?vid="+ self.data._id + "&uid=" + self.data.userid;

        $("#vlink").click(function(){
        var url = $(this).attr("href");
        window.location.href = url;
        window.location.reload(url);
        })
        </script>

        </video-item>

        <!--分页-->
        <page>
        <ul class="pager">
        <li><a href="{ pagePreUrl }">上一页</a></li>
        <li><a href="{ pageNextUrl }">下一页</a></li>
        </ul>
        <script>
        var self = this;


        var pageNext = Number(self.parent.page)+1;
        var pagePre = Number(self.parent.page)-1;

        if(pagePre == -1){
        pagePre = 0;
        };

        self.pageNextUrl = "index.html?page="+ pageNext;
        self.pagePreUrl = "index.html?page="+ pagePre;

        </script>
        </page>
