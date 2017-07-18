<result class="search-result">
    <div class="search" style="margin-top: 0;">
        <div class="" style="height: auto;padding: 10px 0px 0px 0px;">
            <span class="forword" onclick="{ gohistory }" style="float: left;height: 32px;padding: 10px 10px 10px 40px;"></span>
            <input type="text" placeholder="搜索视频、医生" autofocus value="" id="search-input">
            <div class="search-del" onclick="{ serachDel }"><img src="../images/icon/select_del.png"></div>
            <button onclick="{ searchbtn }"></button>
        </div>
    </div>
    <div class='doctorSearch' style="display:none">医生</div>
    <doctor-search each="{ doctorSearch }" class="doctor-search-box"></doctor-search>
    <a href="{ moreDoctorUrl }" class="more-doctor" style="display:none">更多医生>></a>

    <div class='videoSearch' style="display:none">视频</div>
    <video-search each="{ videoSearch }"></video-search>
    <a href="{ moreVideoUrl }" class="more-video" style="display:none">更多视频>></a>
    <div class="nodata" style="display: none;background: #ebebeb;">
        <div>暂无数据</div>
    </div>
    <script>
        var self = this;
        $(function(){
            $("input").bind('input propertychange',function(){
                $(".search-del").show();
            });
        });

        gohistory(){
            window.history.go(-1);

        };
        serachDel(){
            $("input").val("").focus();
            $(".search-del").hide();
        }
        searchbtn(){
            $(".more-doctor").hide();
            $(".more-video").hide();
            var query = $("#search-input").val();
            var message = {
                query: query,
                page: 0
            };
            zhuge.track("search",query);
            RiotControl.trigger("getSearchList",message);
            RiotControl.on("searchChanged",function(data){
                self.moreDoctorUrl = "moreDoctorSearch.html?query="+query;
                self.moreVideoUrl = "moreVideoSearch.html?query="+query;
                //console.log(data);
                $(data[0]).each(function(){
                    if(this.media == "4"){
                         this.media = "专题号";
                    }else{
                        this.media = "大夫号";
                    }
                });
                $(data[1]).each(function(){
                    if(this.media == "4"){
                        this.media = "专题号";
                    }else{
                        this.media = "大夫号";
                    }
                });
                self.doctorSearch = data[0];
                self.videoSearch = data[1];
                if(data[0].length>0){
                    $(".doctorSearch").show();
                }else{
                    $(".doctorSearch").hide();
                };
                if(data[1].length>0){
                    $(".videoSearch").show();
                }else{
                    $(".videoSearch").hide();
                };
                if(data[0].length>3){
                    self.doctorSearch.length = 3;
                    $(".more-doctor").show();
                };
                if(data[1].length>3){
                    self.videoSearch.length = 3;
                    $(".more-video").show();
                };

                if(data[0].length == 0 && data[1].length == 0){
                    $(".nodata").show();
                }else{
                    $(".nodata").hide();
                }

                self.update();
            });
        }


    </script>
</result>
<doctor-search>
    <a href="{ doctorUrl }">
        <img src='{ avatar[0] }'>
        <div>
            <div class='nickname'>{ nickname }</div>
            <div class='line2'>
                <span class='hospital'>{ hospital }</span>
                <span class='room'>{ room }</span>
            </div>
        </div>
    </a>
    <script>
        var self = this;
        self.doctorUrl = "doctorDetail.html?doctorid=" + self._id;
    </script>
</doctor-search>
<video-search class="video-item" onclick="{ playVideoUrl }">
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
            var videoUrl = "videoDetail.html?vid=" + self._id + "&uid=" + self.userid;
            window.location.href = videoUrl;
        }
    </script>
</video-search>
