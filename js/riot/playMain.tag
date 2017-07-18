<videoList class='list-group'>
    <a class="toChannel" href="channel.html">
        <span>{ room1 }</span>
    </a>
    <div class="nodata" style="height: 240px"><div>没有数据</div></div>
    <video-list-item each={ list } vitem="{ this }"></video-list-item>
    <page></page>
    <script>

        var self = this;
    //返回按钮
        this.forword  = function(e){
          if(document.referrer.indexOf("topic")!=-1){
              window.location.href = document.referrer;
          }else if(document.referrer == ""){
              window.location.href = "http://weixin.daifushuo.com";
          }else{
              window.history.go(-1);
          }
        }.bind(this);
        self.list= [];
    //路由
        riot.route(function(){
            var q = riot.route.query()
            self.room = q.room;
            self.page = q.page;
            //console.log(self.room);
            self.update();
        });
        riot.route.stop();
        riot.route.start(true);

        self.room = self.room || location.search.split("room=")[1].split("&")[0];
        if(location.search.indexOf("page") != -1){
            self.page = self.page || location.search.split("page=")[1].split("&")[0];
        }else{
            self.page = 0;
        }
        //

        self.roomList = decodeURI(self.room);
        self.room1 = (self.roomList).split(" ")[0];
        //console.log(self.roomList);
        var query = {
            "query": decodeURI(self.room),
            "size": 10,
            "page": self.page
        };

    RiotControl.trigger("getRoomVideoList",query);
    RiotControl.on("videoListChanged",function(data){
        console.log(data);
    $(data).each(function(){
    if(this.media == "4"){
    this.media = "专题号";
    }else{
    this.media = "大夫号";
    }
    });
        self.list = data;

        if(data.length < 1){
            $(".nodata").show();
            $(".page").hide();
        }else{
            $(".nodata").hide();
        }
            self.update();
        });

    </script>
</videoList>

<video-list-item>
    <div class="list-group">
        <div vid={ _id } userid="{ userid }" class="vlink list-group-item" >
            <a  href="{ videoUrl }" >
                <div class="col-md-6 col-xs-6">
                    <div class="listTitle">{ title }</div>
                    <div class="listTxt">{ content }</div>
                    <div class="mediaType">{ media }</div>
                    <div class="ilikecnt">{ _data.comments.length }</div>
                    <div class="viewNum">{ viewersnum }</div>
                </div>
                <div class="col-md-6 col-xs-6">

                    <img src="{ vcover }" alt=""  class="more-video-img">
                    <span class='watermark'><img src="../images/login/play.png"></span>

                </div>
            </a>
        </div>
    </div>

    <script>
       var self = this;
       self.videoUrl = "/html/videoDetail.html?vid=" + self._id + "&uid=" + self.userid ;
    </script>

</video-list-item>
<page class='page'>
    <ul class="pager" style="padding: 10px 0 20px 0">
        <li><a href="{ pagePreUrl }">上一页</a></li>
        <li><a href="{ pageNextUrl }">下一页</a></li>
    </ul>
    <script>
        var self = this;


        var pageNext = Number(self.parent.page)+1;
        var pagePre = Number(self.parent.page)-1;

        if(pagePre == -1){
            pagePre = 0;
        }
        self.pageNextUrl = "playMain.html?room="+ decodeURI(self.parent.room) +"&page="+ pageNext;
        self.pagePreUrl = "playMain.html?room="+ decodeURI(self.parent.room) +"&page="+ pagePre;


    </script>
</page>
