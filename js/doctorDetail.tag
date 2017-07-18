<doctor class="doctor">
    <doctor-message></doctor-message>
    <recommend></recommend>
    <video-more></video-more>

    <script>
        var self = this;
        riot.route(function(){
            var q = riot.route.query()
            self.userid = q.doctorid;
            //console.log(self.userid);
            self.update();
        });

        riot.route.stop();
        riot.route.start(true);

        self.userid = self.userid || location.search.split("doctorid=")[1].split("&")[0];

        this.on("mount",function(){
            Test();
        });
    </script>
</doctor>

<doctor-message>
    <div class="forword" onclick="{ gohistory }">
        <div class="back"><span>{ msg.info.type }</span></div>
    </div>
    <!--
    <div class='headMag'>
        <img src={ msg.info.avatar[0] } alt="">
        <div class="name">{ msg.info.nickname }</div>
        <div class="msg">
            <div class='col-md-6 col-xs-6'>
                <span>粉丝</span>
                <span class="beingConcerned">{  msg.post }</span>|
            </div>
            <div class='col-md-6 col-xs-6'>
                <span>视频</span>
                <span class="originalVideo">{ msg.video }</span>
            </div>
        </div>
        <div class="description2">
            <div class="addr" >
                <a onclick="{ hospitalUrl }">{ msg.info.hospital }>></a>
                <a onclick="{ roomUrl }">{ msg.info.room }>></a>
            </div>
            <div class="hospitalDefault" style="display: none">医院资料未设置</div>
            <div class="roomDefault" style="display: none">科室资料未设置</div>
        </div>

        <div class="focus" onclick="{ focused }">
            <span>+关注</span>
        </div>
        -->
        <div class="doctorInfo">
        <div class='bg'>
            <div></div>
            <img src="{ msg.info.backgroundimg }" alt="">
        </div>
        <div class="description1">
            <div>
                <img src={ msg.info.avatar[0] } alt="">
            </div>
            <div>
                <div class="mainInfo">
                    <div>{ msg.info.nickname }</div>
                    <span>粉丝{  msg.post }</span>｜
                    <span>原创视频{ msg.video }</span>
                </div>
                <div class="focus" onclick="{ focused }">
                    <span>+关注</span>
                </div>
            </div>
        </div>
        <div class="description2">
            <div class="addr" >
                <a onclick="{ hospitalUrl }">{ msg.info.hospital }></a>
                <a onclick="{ roomUrl }">{ msg.info.room }></a>
            </div>
            <div class="hospitalDefault" style="display: none">医院资料未设置</div>
            <div class="roomDefault" style="display: none">科室资料未设置</div>
        </div>
        <div class="inDesc">
            <div class="adept">
                <div>擅长领域</div>
                <div>{ msg.info.profile[0] }</div>
            </div>
            <div class="experience">
                <div>执业经历</div>
                <div>{ msg.info.profile[1] }</div>
            </div>
        </div>
    </div>
    <style>
        .doctorInfo .bg img{
            width: 100%;
            height: 150px;
        }
        .description1 img{
            width: 75px;
            height: 75px;
        }
        .description1{
            overflow: hidden;
            margin-top: -40px;
            z-index: 222;
            position: relative;
            padding-left: 10px;
        }
        .description1 >div{
            float: left;
        }
        .description1 >div:nth-child(1){
            width: 30%;
        }
        .description1 >div:nth-child(2){
            width: 70%;
        }
        .description1 >div:nth-child(2) .mainInfo{
            color: #fff;
            font-size: 1.4rem;
        }
        .description1 >div:nth-child(2) .mainInfo span{
            width: 30%;
        }
        .description1 >div:nth-child(2) .mainInfo span:nth-child(1){
            font-size: 2rem;
            padding-right: 10px;
        }
        .description2{
            text-align: left;
            padding: 10px
        }
        .description2 a{
            display: block;
            padding: 6px 0px 6px 25px;
            color: #2196f3 !important;
            font-size: 1.5rem;
        }
        .description2 a:nth-child(1){
            background: url(../images/icon/doctor_hospital.png) no-repeat 0 center;
            background-size: 20px 20px;
        }
        .description2 a:nth-child(2){
            background: url(../images/icon/doctor_departments.png) no-repeat 0 center;
            background-size: 20px 20px;
        }

    </style>
    <script>
        var self = this;
        var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));
        self.msg = [];

        RiotControl.trigger("getDoctorMessage",self.parent.userid);
        RiotControl.on("doctorMessage",function(data){

        //console.log(data);
            if(data.info.type == "room"){
                data.info.type = "科室主页";
            }else if(data.info.type == "nurse"){
                data.info.type = "护理主页";
                $(".inDesc").hide();
            }else if(data.info.type == "pgc"){
                data.info.type = "主页";
                $(".inDesc").hide();
            }else{
                data.info.type = "医生主页";
            }
            self.msg = data;
            //self.hospitalUrl = "hospital.html?hospitalid="+ data.info.hospital_id;
            //self.roomUrl = "room.html?roomid="+ data.info.room_id;
            self.update();
        });
        this.hospitalUrl = function(){
            if(self.msg.info.hospital_id == null){
                $(".hospitalDefault").show();
                $(".roomDefault").hide();
            }else{
                var hospUrl = "hospital.html?hospitalid="+ self.msg.info.hospital_id;
                window.location.href = hospUrl;
            }

        }

        this.roomUrl = function(){
            if(self.msg.info.room_id == null){
                $(".roomDefault").show();
                $(".hospitalDefault").hide();
            }else{
                var roomsUrl = "room.html?roomid="+ self.msg.info.room_id;
                window.location.href = roomsUrl;
            }
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

        //判断是否已经关注

        var focus = {
            "follower": dfs_cookie.userId,//粉丝
            "followee": self.parent.userid
        };
        $.post("http://api.daifushuo.com:80/api/ofriends/haveit?access_token="+dfs_cookie.id,focus,function(data){
            //console.log(data);
            if(data.ret == "yes"){
                $(".focus").find("span").addClass("change");
                $(".focus").find("span").text("已关注");
            }else{
                $(".focus").find("span").removeClass("change");
                $(".focus").find("span").text("+关注");
            }
        });
        //点击关注按钮
        this.focused = function(){
        //console.log(focus);
            $(".focus").find("span").toggleClass("change");
            $(".focus").find("span").text("已关注");

            if($(".focus").find("span").hasClass("change")){
                $(".focus").find("span").text("已关注");
            //关注
                $.post("http://api.daifushuo.com:80/api/ofriends/dfs_follow?access_token="+dfs_cookie.id,focus,function(data){
                    //console.log(data);
                });
            }else{
            //取消关注
                $(".focus").find("span").text("+关注");
                $.post("http://api.daifushuo.com:80/api/ofriends/dfs_unfollow?access_token="+dfs_cookie.id,focus,function(data){
                    //console.log(data);
            });
        }

        }
    </script>
</doctor-message>
        <!--推荐-->
<recommend class="recommend">
    <div class="recommendTitle" >
        <div class="tit">他的推荐</div>
        <recommendList each="{ recommendVideo }" vitem="{ this }"></recommendList>
        <div class="moreRecommend" onclick="{ moreRecommend }">更多推荐</div>
    </div>
    <script>
        var self = this;
        self.hotVideo = [];
        self.parent = this.parent;
        self.recommend = {
            doctorid: self.parent.userid,
            page: "0"
        };
        RiotControl.trigger("getRecommendList",self.recommend);
        RiotControl.on("recommendVideoChange",function(data){
            if(data.length >=2 ){
                data.length = 2;
            }
            if(data.length == 0){
                $(".recommend").hide();
            }
            self.recommendVideo = data;
            //console.log(data);
            self.update();
        });
        this.moreRecommend = function(){
            var moreRecommendUrl = "recommend.html?doctorid=" + self.parent.userid;
            window.location.href = moreRecommendUrl;
        }

    </script>
    <style>
    .recommend .tit{
        padding: 9px 0 7px 30px;
        margin-bottom: 0;
        border-bottom: 1px solid #eee;
        background: #fff url(../images/icon/ic_forwarding.png) no-repeat 10px center;
        background-size: 16px 16px;
    }
    .recommend .moreRecommend{
        background: #ebebeb;
        color: #6f6f6f;
        text-align: center;
        padding: 0px 0 7px 30px;
        margin-bottom: 0;
        border-bottom: 1px solid #eee;
    }
    </style>
</recommend>


<recommendList class="hotlist">
    <div class="list-group">
        <a href="{ playUrl }" class="list-group-item vlink">

            <div class="col-md-6 col-xs-6">
                <div class="listTitle">{ title }</div>
                <div class="listTxt">{ content }</div>
                <div class="mediaType">{ media }</div>
                <div class="ilikecnt">{ _data.comments.length }</div>
                <div class="viewNum">{ viewersnum }</div>
            </div>
            <div class="col-md-6 col-xs-6">
                <img src="{ vcover }" alt="" class="more-video-img">
                <span class='watermark'><img src="../images/login/play.png"></span>
            </div>
        </a>
    </div>
    <script>
        var self = this;
        self.recommendList = opts.vitem;
        self.playUrl = "videoDetail.html?vid=" + self.origin_id + "&uid=" + self._data.user._id;

    </script>
</recommendList>



<video-more class="video-more">
    <div class="videoList">
        <div class="tit">他的视频</div>
        <more-video-list  each={ doctors } vitem={ this }></more-video-list>
        <a href="{ moreUrl }">查看更多</a>
    </div>
    <script>
        var self = this;
        self.data = opts.vitem;
        self.moreUrl = "more.html?doctorid="+self.parent.userid;

        RiotControl.trigger("getVideoDetail",self.parent.userid);
        RiotControl.on("videoDetailChanged",function(data){
            $(data).each(function(){
                if(this.media == "4"){
                    this.media = "专题号";
                }else{
                    this.media = "大夫号";
                }
            });
            self.doctors = data;
            self.update();
        });
    </script>
</video-more>


<more-video-list class="more-video-list">
    <div class="list-group">
        <a href="{ playUrl }" class="list-group-item vlink" vid="{ _id }" userid="{ userid }">
            <div class="col-md-6 col-xs-6">
                <div class="listTitle">{ title }</div>
                <div class="listTxt">{ content }</div>
                <div class="mediaType">{ media }</div>
                <div class="ilikecnt">{ _data.comments.length }</div>
                <div class="viewNum">{ viewersnum }</div>
            </div>
            <div class="col-md-6 col-xs-6">
                <img src="{ vcover }" alt="" class="more-video-img">
                <span class='watermark'><img src="../images/login/play.png"></span>
            </div>
        </a>
    </div>
    <script>
        var self = this;
        self.data = opts.vitem;
        //console.log(self.data);
        self.playUrl = "videoDetail.html?vid=" + self.data._id + "&uid=" + self.data.userid;
        //console.log(self.playUrl);
    </script>
</more-video-list>
