<room>
    <div class="forword" onclick="{ gohistory }">
        <div class="back"><span>科室</span></div>
    </div>
    <hospital-message></hospital-message>
    <room-detail></room-detail>

    <script>
        var self = this;
        riot.route(function(){
            var q = riot.route.query()
            self.roomid = q.roomid;
            //console.log(self.roomid);
            self.update();
        });

        riot.route.stop();
        riot.route.start(true);

    //回退后URL加"#",则刷新不能用

        if(location.search.indexOf("roomid") != -1){
            if(location.search.indexOf("&") != -1){
                self.roomid = self.roomid || location.search.split("roomid=")[1].split("&")[0];
            }else{
                self.roomid = self.roomid || location.search.split("roomid=")[1];
            }
        }else{
            self.roomid = self.roomid;
        }

        this.gohistory = function(){
          if(document.referrer.indexOf("topic")!=-1){
              window.location.href = document.referrer;
          }else if(document.referrer == ""){
              window.location.href = "http://weixin.daifushuo.com";
          }else{
              window.history.go(-1);
          }
        }

    </script>
</room>

<hospital-message class="hospital-message">

    <div class="part1">
        <div class='hos-img'><img src="{ information.avatar[0] }"></div>
        <div class='hos-description' style="text-align: left;">
            <div>
                <div class='hos-name'>{ information.nickname }</div>
                <div class="hos-level">
                    <span>{ information.signature }</span>
                    <span>{ information.city }</span>
                </div>
            </div>
        </div>
    </div>
    <div class='link-detail'>
        <span onclick="{ jianjie }">简介</span>
        <div class="profile" id="content">{ information.profile[0] }</div>
    </div>
    <script>
    var self = this;

        var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));

        var room = {
            hospitalid: self.parent.roomid,
            token: dfs_cookie.id
        };

        RiotControl.trigger("getHospitalInformation",room);
        RiotControl.on("hospitalInformationChanged",function(data){
            self.information = data;
            //console.log(data);
            if(data.profile == "" || data.profile[0] ==""){
                $(".link-detail").hide();
            };
            self.update();
        });

    </script>
</hospital-message>

<room-detail class="hospital-detail">
    <!-- Nav tabs -->
    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="col-md-6 col-xs-6 active"><a href="#home" role="tab" data-toggle="tab">视频</a></li>
        <li role="presentation" class="col-md-6 col-xs-6"><a href="#profile" role="tab" data-toggle="tab">专家</a></li>
    </ul>
    <div class="tab-content">
        <div role="tabpanel" class="tab-pane active" id="home">
            <video-box each="{ video }"></video-box>
        </div>
        <div role="tabpanel" class="tab-pane" id="profile">
            <proficient each="{ doctors }"></proficient>
        </div>
    </div>
    <script>
        var self = this;
    //视频
        RiotControl.trigger("getRoomList",self.parent.roomid);
        RiotControl.on("roomVideoChanged",function(data){
            $(data).each(function(){
                if(this.media == "4"){
                    this.media = "专题号";
                }else{
                    this.media = "大夫号";
                }
            });
            self.video = data;
            console.log(data);
            self.update();
        });
    //专家
        RiotControl.trigger("getRoomDoctorsList",self.parent.roomid);
        RiotControl.on("roomDoctorsChanged",function(data){
            self.doctors = data;
            //console.log(data);
            self.update();
        });
    </script>
</room-detail>
    <!--视频部分-->
<video-box class="video-item">
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
        var self =this;
        playVideoUrl(){
            let videoUrl = "videoDetail.html?vid=" + self._id + "&uid=" + self.userid;
            window.location.href = videoUrl;
        }
    </script>

</video-box>

    <!--专家-->
<proficient class='proficient'>
    <a href='{ doctorUrl }'>
        <div>
            <img src='{ avatar[0] }'>
        </div>
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
        self.doctorUrl = "doctorDetail.html?doctorid="+self._id;
    </script>

</proficient>
