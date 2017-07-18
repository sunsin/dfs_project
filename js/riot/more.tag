<more class="doctorMoreVideo">
    <div class="forword" onclick="{ gohistory }">
        <div class="back"><span>{ doctors[0]._data.user.nickname }</span></div>
    </div>
    <more-item each="{ doctors }" item="{ this }"></more-item>
    <page></page>
    <script>
        var self = this;
        riot.route( function(){
            var q = riot.route.query();
            self.doctorid = q.doctorid;
            self.page = q.page;
            //console.log(self.doctorid);
            self.update();
        });
        riot.route.stop();
        riot.route.start(true);

        if(typeof(self.page) == "undefined"){
            self.page = 0;
        }
        if(location.search == ""){
            self.page = 0;
        }

        self.doctorid = self.doctorid || location.search.split("doctorid=")[1];
        if(location.href.indexOf("page") != -1){
            self.page = location.search.split("page=")[1].split("&")[0];
        };
        

        self.doctorMeaage = {
            doctorid: self.doctorid,
            page: self.page
        }
        RiotControl.trigger("getMoreVideoDetail",self.doctorMeaage);
        RiotControl.on("videoMoreDetailChanged",function(data){
            $(data).each(function(){
                if(this.media == "4"){
                    this.media = "专题号";
                }else{
                    this.media = "大夫号";
                }
            });
            self.doctors = data;
            //console.log(data);
            if(data.length < 1){
                $(".doctorMoreVideo").append("<div class='nodata' style='background: #fff;'><div>没有数据了</div></div>");
                $(".pager").hide();
            }
            self.update();
        });
        this.gohistory = function(){
            window.history.go(-1);
        }

    </script>
</more>

<more-item class="video-item">
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
        self.data = opts.vitem;
        playVideoUrl(){
            let videoUrl = "videoDetail.html?vid=" + self._id + "&uid=" + self.userid;
            window.location.href = videoUrl;
        }
    </script>
</more-item>

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
    }

    self.pageNextUrl = "more.html?page="+ pageNext+"&doctorid="+self.parent.doctorid;
    self.pagePreUrl = "more.html?page="+ pagePre+"&doctorid="+self.parent.doctorid;


    </script>
</page>