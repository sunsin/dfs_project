<recommend class="recommendVideo">
    <div class="forword" onclick="{ gohistory }">
        <div class="back"><span>{ recommendDoctorInfo.info.nickname }的推荐</span></div>
    </div>
    <recommend-item each="{ recommend }"></recommend-item>
    <page></page>
    <script>
        var self = this;
        riot.route( function(){
            var q = riot.route.query();
            self.doctorid = q.doctorid;
            self.page = q.page;
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
        //self.page = self.page || (location.search.split("page=")[1]).split("&")[0];

    //推荐人信息
        RiotControl.trigger("getDoctorMessage",self.doctorid);
        RiotControl.on("doctorMessage",function(data){
            //console.log(data);
            self.recommendDoctorInfo = data;
            self.update();
        });

        self.recommend = {
            doctorid: self.doctorid,
            page: self.page
        }

        RiotControl.trigger("getRecommendList",self.recommend);
        RiotControl.on("recommendVideoChange",function(data){

            self.recommend = data;
            console.log(data);
            if(data.length < 1){
                $(".recommendVideo").append("<div class='nodata' style='background: #fff;'><div>没有数据了</div></div>");
                $(".pager").hide();
            }
            self.update();
        });
        this.gohistory = function(){
            window.history.go(-1);
        }
        </script>
</recommend>

<recommend-item class="video-item">
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
        //self.videoUrl = "videoDetail.html?vid=" + self.origin_id+ "&uid=" + self.userid;
        $(function(){
            $(".list-group-item").click(function(){
                var url  = "videoDetail.html?vid=" + $(this).attr("vid") + "&uid=" + $(this).attr("userid");
                window.location.href = url;
            })
        })
    </script>
</recommend-item>

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

        self.pageNextUrl = "recommend.html?page="+ pageNext+"&doctorid="+self.parent.doctorid;
        self.pagePreUrl = "recommend.html?page="+ pagePre+"&doctorid="+self.parent.doctorid;


    </script>
</page>