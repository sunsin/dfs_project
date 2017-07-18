<hotVideo class='hotVideo'>
    <a class="search" href="html/search.html">
        <span>搜索医生、视频</span>
    </a>




    <navList class='nav'></navList>
    <carousel></carousel>

    <!--<span>热门推荐</span>-->
    <videolist class="videolist"></videolist>

    <page></page>

    <script>
        var self = this;
    //路由解析
        riot.route(function(){
        var q = riot.route.query();
            self.page = q.page;
            self.topic = decodeURI(q.topic);
            //console.log(self.page);
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
        if(isNaN(self.page)){
            self.page = 0;
        }
        if(self.topic== "undefined"){
            self.topic = "热门";
        }
        //console.log(self.topic);
    </script>

</hotVideo>
<!--轮播Carousel-->

<carousel id="carousel-example-generic" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
        <ol class="carousel-indicators"></ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">
        <!--<carousel-item class="item active" each="{ carousel }"></carousel-item>-->
    </div>

    <!-- Controls -->
    <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right"></span>
        <span class="sr-only">Next</span>
    </a>
    <script>
        var self = this;
        RiotControl.trigger("getCarouselList",self.parent.page?self.parent.page:0);
        RiotControl.on("carouselListChanged",function(data){
            self.carousel = data;
            if(data.length == 0){
                $("#carousel-example-generic").hide();
            }
            console.log(data);
            for(var i=0;i<data.length;i++){

                var slide = "<div class='item'><a href='"+data[i].link_url+"'><img src='"+data[i].img_url+"' alt='大夫说'><div class='carousel-caption'>"+data[i].title+"</div></a></div>";
                $(".carousel-inner").append(slide);
                var slideOli = "<li data-target='#carousel-example-generic' data-slide-to='"+i+"'></li>";
                $(".carousel-indicators").append(slideOli);
            }
            $(".item").eq(0).addClass("active")


            self.update();
        });
    </script>
</carousel>
<!--导航-->
<navList>
    <ul class="line">
        <li each={ navLists }></li>
    </ul>
    <script>
        var self = this;
        RiotControl.trigger("getTopicList",self.parent.page?self.parent.page:0);
        RiotControl.on("topicListChanged",function(data){
            self.navLists = data;
            console.log(data);

            self.update();

        });

        //《导航标签颜色
        this.on('updated', function() {
            // 标签模板更新后
            if(window.location.href == ""){
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
                    $(".line").find("li").eq(i).addClass("ko");
                }
            }

        })
        //导航标签颜色》
    </script>
</navList>

<li class="nav-item" onclick="{ topic }" topic="{ name }">
        <span>{ name }</span>
        <script>
            var self = this;


        this.topic = function(){
                self.parent.parent.topic = self.description;
                //console.log(self.parent.parent.topic);
                var topicUrl = "index.html?topic="+self.description;
                window.location.href = topicUrl;
                riot.update(true);

            }

        </script>
</li>

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
        var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));
        console.log(dfs_cookie);
    //topic滚动条依据不同topic获取不同的接口内容
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
        }else if(self.parent.topic == "关注"){
            var page ={
                userid : dfs_cookie.userId || null,
                access_token : dfs_cookie.id || null,
                page: self.parent.page?self.parent.page:0
            };
            RiotControl.trigger("getFocusVideoList",page);
            RiotControl.on("videoFocusListChanged",function(data){
                self.ilist = data;
                console.log(data);
                if(data.length<1){
                    $(".hotVideo").append("<div class='nodata'><div>暂无数据</div></div>");
                    $(".page").hide();
                }
                self.update();
            });
        }else{
            var topicQuery = {
                size: 10,
                page: self.parent.page || 0,
                query: self.parent.topic
            };
            RiotControl.trigger("getOtherVideoList",topicQuery);
            RiotControl.on("videoOtherListChanged",function(data){
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

    <!--时间倒序video列表-->
<video-item class="video-item">
        <a href="{ playUrl }" vid="{ data._id }" id="vlink" class="linkvideo" userid="{ data.userid }">
            <img src="{ data.vcover }" alt="">
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
        self.pageNextUrl = "index.html?topic="+self.parent.topic+"&page="+ pageNext;
        self.pagePreUrl = "index.html?topic="+self.parent.topic+"&page="+ pagePre;
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