<doctor class="doctor">

    <doctor-message></doctor-message>
    <recommend></recommend>
    <video-more></video-more>

<script>
    var self = this;

    riot.route( function(){

        var q = riot.route.query();
        self.userid = q.doctorid;
        self.loginid = q.loginid;
        self.update();

    });

    riot.route.stop();
    riot.route.start(true);

    self.userid = self.userid || location.search.split("doctorid=")[1].split("&")[0];
    if(location.search.indexOf("loginid") != -1){
        self.loginid = self.loginid || location.search.split("loginid=")[1].split("&")[0];

        var login = {
            userid : self.loginid 
        };

        $.post("http://api.daifushuo.com:80/api/ousers/dfs_add_showtimes",login,function(data){
            //console.log(data);
        });
    }
    

    //个人主页浏览记录
    RiotControl.trigger("addViewSum",self.userid);
    RiotControl.on("viewsumChange",function(data){
        //console.log(data);
    });
</script>
</doctor>

<doctor-message>
    <div class="forword" onclick="{ gohistory }">
        <div class="back"><span>{ msg.info.type }</span></div>
    </div>
    <div class="doctorInfo">
        <div class='bg' style="position: relative;">
            <div style="position: absolute;width: 100%;height: 150px;background: rgba(0,0,0,0.5)"></div>
            <img src="{ msg.info.backgroundimg }" alt="">
        </div>
        <div class="description1">
            <div>
                <img src={ msg.info.avatar[0] } alt="">
            </div>
            <div>
                <div class="mainInfo">
                    <div>{ msg.info.nickname }</div>
                    <span>粉丝 {  msg.post }</span>｜
                    <span>视频 { msg.video }</span>
                </div>
                <div class="module1">
                    <div class="focus" onclick="{ focused }">
                        <span>+关注</span>
                    </div>
                    <div class="toanswerquestion canask" onclick="{ toanswerquestion }">
                        <span>问答</span>
                    </div>
                </div>   
                
            </div>
        </div>
        <div class="cantask">
            <div>此医生暂未开通问答功能</div>
        </div>
        <div class="description2">
            <div class="addr" >
                <a onclick="{ hospitalUrl }">{ msg.info.hospital }></a>
                <a onclick="{ roomUrl }">{ msg.info.room }></a>
            </div>
            <div class="hospitalDefault" style="display: none">医院资料未设置</div>
            <div class="roomDefault" style="display: none">科室资料未设置</div>
        </div>
    </div>
    <div class="inDesc">
        <div class="Doctorvisit">
            <div>出诊公告</div>
            <div>{ msg.info.announcement }</div>
        </div>
        <div class="adept">
            <div>擅长领域</div>
            <div class="str"></div>
        </div>
        <div class="experience">
            <div>执业经历</div>
            <div class="str1"></div>
        </div>
    </div>
</div>
    <script>
        var self = this;
        var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));
        self.msg = [];
        var profile,profile1    ;
        RiotControl.trigger("getDoctorMessage",self.parent.userid);
        RiotControl.on("doctorMessage",function(data){

              console.log(data);
    //科室医院为空时隐藏
            if(data.info.hospital == null){
                $(".addr").children("a").eq(0).hide();
            }
            if(data.info.room == null){
                $(".addr").children("a").eq(1).hide();
            }

            if(data.info.type == "room"){
                data.info.type = "科室主页";
            }else if(data.info.type == "nurse"){
                data.info.type = "护理主页";
                $(".inDesc").hide();
            }else if( data.info.type == "pgc"){
                data.info.type = "专题号主页";
                $(".experience").hide();
                $(".adept").find("div").eq(0).text("简介");
            }else{
                data.info.type = "医生主页";
            }
            
            $(".str").html(data.info.profile[0]);
            $(".str1").html(data.info.profile[1]);
            self.msg = data;
            self.update();

        });
        $(function(){
            
        })
        
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

        toanswerquestion(){
            if(self.msg.info.can_ask == null || self.msg.info.can_ask == false){
                $(".cantask").show();
            }else{
                var url = "doctoranswer.html?doctorid=" + self.parent.userid;
                window.location.href = url;  
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


<recommendList class="video-item">
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
                if(this.viewersnum >= 10000){
                    this.viewersnum = Number(this.viewersnum/10000).toFixed(1)+"w+";
                }
            });
            self.doctors = data;
            self.update();
        });
    </script>
</video-more>


<more-video-list class="video-item">
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
</more-video-list>
