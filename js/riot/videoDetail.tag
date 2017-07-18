<play class="play">
    <video-box></video-box>
    <doctor-description></doctor-description>
    <comment></comment>
    <token id="token" token="" userId=""></token>
    <video-more></video-more>

    <script>
            var self = this;
            riot.route( function(){
                var q = riot.route.query();
                self.vid = q.vid;
                self.userid = q.uid;
                //console.log(self.userid);
                //console.log(self.vid);
                self.update();
            });
            riot.route.stop();
            riot.route.start(true);

            //避免有时路由无反应
            var url = location.search;
            var postid = (url.split("vid=")[1]).split("&")[0];
            var userid = url.split("uid=")[1].split("&")[0];

            self.vid = self.vid || postid;
            self.userid = self.userid || userid;
            /*
            var maxRandom,add_sum;
            //console.log(tatalClickNum%2);
            $.get("http://api.daifushuo.com:80/api/tools/dfs_double_click",function(data){
                
                maxRandom = data.max;
                console.log(maxRandom);
                add_sum = Math.ceil(Math.random()*maxRandom);
                var sum = {
                    sum: add_sum
                };
                $.get("http://api.daifushuo.com:80/api/oposts/dfs_add_viewsum?postid="+self.vid,sum,function(data){
                  //alert("0");
                  //console.log(data);
                });
            });

            */
            this.on("mount",function(){
                //Test();
            });

    </script>
</play>

    <!--video播放-->
<video-box class="video-box">
    <!--第三方-->
    <div class="third">
        <iframe src="{ thirdPart.vlink }" frameborder="0"></iframe>
        <div class="totalClick" style="display: none;" value="1"></div>

        <div class="link">
            <a class="linked" href="{ linked }">打开大夫说,提升3倍流畅度</a>
            <a href="{ thirdPart.reportUrl }" class='report-link'><img src="../images/icon/report.png"></a>
            <a class="third-link" href="{ thirdPart.vsource_url }"><img src="../images/icon/link.png"></a>
        </div>
        <div class="msg">
            <span>{ thirdPart.title }</span>

            <span class="share" onclick="{ share1 }" num="{ thirdPart.dfs_share_sum?thirdPart.dfs_share_sum:0 }">{ thirdPart.dfs_share_sum?thirdPart.dfs_share_sum:0 }</span>
            <span class="collect" onclick="{ collect1 }" num="{ thirdPart.dfs_mark_sum?thirdPart.dfs_mark_sum:0 }">{ thirdPart.dfs_mark_sum?thirdPart.dfs_mark_sum:0 }</span>
            <div class="prompt"></div>
        </div>
        <p>{ thirdPart.content }</p>
    </div>
    <!--自产-->
    <div class="myself">
        <video id="video" class="video-js vjs-default-skin" preload="auto" controls type="video/mp4" poster="{ video.vcover }" src="{ video.vlink }" postid="{ video._id }" onclick="{ videoplay }">
        </video>
        <!--<div id='playicon' onclick="{ playicon }"><img src="../images/login/play.png"></div>-->
    <!--
    //自定义控制条
        <div id="controls">

            <button id="playpause" class="start" title="play"></button>

            <div id="progressBar"><span id="progress"></span></div>
            <span id="time">0:00</span>
            <span id="fullTime"></span>
            <button id="fullscreen"></button>
        </div>
      -->
        <div class="link">
           <a class="linked" href="{ linked }">打开大夫说,提升3倍流畅度</a>
           <a href="{ video.reportUrl }" class='report-link'><img src='../images/icon/report.png'></a>
       </div>
        <div class="totalClick" style="display: none;" value="1"></div>

        <div class="msg">
            <span>{ video.title }</span>

            <span class="share" onclick="{ share }" num="{ video.dfs_share_sum?video.dfs_share_sum:0 }">{ video.dfs_share_sum?video.dfs_share_sum:0 }</span>
            <span class="collect" onclick="{ collect }" num="{ video.dfs_mark_sum?video.dfs_mark_sum:0 }">{ video.dfs_mark_sum?video.dfs_mark_sum:0 }</span>
            <div class="prompt"></div>
        </div>
        <p>{ video.content }</p>
    </div>
<script>
    //linkedme
    var self  = this;
    var url = location.search;
    var postid = (url.split("vid=")[1]).split("&")[0];
    var userid = (url.split("vid=")[1]).split("uid")[1].split("=")[1];
    linkedme.init("linkedme_live_d88f9589ee225d010c0210b7944c550e", {type: "test"}, null);
    var data = {};
    data.type = "test";

    data.params = '{"View":"Post","id":"'+postid+'"}';

    linkedme.link(data, function(err, data){
        if(err){
            alert("error");
        } else{
            self.linked = data.url;
        }
    },false);

</script>
<script>
        var self = this;
            //console.log(self.parent.vid);
        RiotControl.trigger("getVideoPlay",self.parent.vid);
        RiotControl.on("videoPlayChanged",function(data){
            // console.log(data);
            if(data.media == 4){
                self.thirdPart = data;
                self.thirdPart.reportUrl = "report.html?postid="+self.parent.vid;
                $(".myself").hide();
            }else{
                self.video = data;
                self.video.reportUrl = "report.html?postid="+self.parent.vid;
                $(".third").hide();
            }
            self.update();
        });



    var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));
    console.log(dfs_cookie);
    
    zhuge.track("videoShow",{
        viewuserid: self.parent.userid,
        postid : self.parent.vid,
        userid: dfs_cookie.userId
    });
    

    //zhuge没有load方法(不能调试)
    //window.zhuge.load('80166cfa7cc74f929f7af3368f5291e3', {debug:true});
    //zhuge.track("用户",dfs_cookie.userId);


    //播放次数统计
    this.videoplay = function(){


    //添加观看记录
        var viewblog = {
            user_id : dfs_cookie.userId,//用户ID
            post_id: self.parent.vid,
        }
        $.post("http://api.daifushuo.com:80/api/viewlog?access_token="+dfs_cookie.id,viewblog,function(data){
            //console.log(data);
        }
    );


    //增加播放次数
        var video = videojs("video");
        var tatalClickNum = Number($(".totalClick").attr("value"));
        var maxRandom,add_sum;
        //console.log(tatalClickNum%2);
        $.get("http://api.daifushuo.com:80/api/tools/dfs_double_click",function(data){
            //console.log(typeof(data));
            maxRandom = data.max;
        });
        if(tatalClickNum%2 == 1){
            video.play();
        //viewsum++(视频播放次数增加)
            //random();


            
            $.get("http://api.daifushuo.com:80/api/tools/dfs_double_click",function(data){
                
                maxRandom = data.max;
                add_sum = Math.ceil(Math.random()*maxRandom);
                var sum = {
                    sum: add_sum
                };
                 $.get("http://api.daifushuo.com:80/api/oposts/dfs_add_viewsum?postid="+self.parent.vid,sum,function(data){
                    //console.log(data);
                });
            });
           

        }else{
            video.pause();
        }
        tatalClickNum = tatalClickNum+add_sum;
        $(".totalClick").attr("value",tatalClickNum);

    };


    //自产视频收藏
    this.collect = function(){
        Test();

        var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));
        if(dfs_cookie != null ){
          var collectNum = Number($(".myself").find(".collect").attr("num"));
          $(".collect").toggleClass("collectChecked");
          var collectVideo = {
              title: self.title,
              url: window.location.href,
              postid: self.parent.vid,
              userid: dfs_cookie.userId
          };

          if($(".collect").hasClass("collectChecked")){
              collectNum++;
              $(".myself").find(".collect").attr("num",collectNum);

              $(".collect").text(collectNum);
              //收藏
              $.post("http://api.daifushuo.com:80/api/obookmarks/dfs_bookmark_add?access_token="+dfs_cookie.id,collectVideo,function(result) {
                  //console.log(result);
                  $(".prompt").text("收藏成功");
                  $(".prompt").fadeOut(2000);
              });
          }else{
              collectNum--;
              $(".myself").find(".collect").attr("num",collectNum);

              $(".collect").text(collectNum);
              //取消收藏
              $.post("http://api.daifushuo.com:80/api/obookmarks/dfs_bookmark_del?access_token="+dfs_cookie.id,collectVideo,function(result) {
                  //console.log(result);
                  $(".prompt").text("取消收藏");
                  $(".prompt").fadeOut(2000);
              });
          }
          $(".prompt").removeAttr("style");
          $(".prompt").css("display","block");
          // if($(this).hasClass("collectChecked")){

          //     $(".prompt").text("收藏成功");
          //     $(".prompt").fadeOut(1000);
          // }else{
          //     $(".prompt").text("取消收藏");
          //     $(".prompt").fadeOut(1000);
          // }
        }

    };
    //第三方视频收藏
    this.collect1 = function(){
      Test();

        var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));
        if(dfs_cookie != null){
          var collectNum = Number($(".third").find(".collect").attr("num"));
          $(".collect").toggleClass("collectChecked");
          var collectVideo = {
              title: self.title,
              url: window.location.href,
              postid: self.parent.vid,
              userid: dfs_cookie.userId
          };

          if($(".collect").hasClass("collectChecked")){
              collectNum++;
              $(".third").find(".collect").attr("num",collectNum);

              $(".collect").text(collectNum);
              //收藏
              $.post("http://api.daifushuo.com:80/api/obookmarks/dfs_bookmark_add?access_token="+dfs_cookie.id,collectVideo,function(result) {
                  //console.log(result);
                  $(".prompt").text("收藏成功");
                  $(".prompt").fadeOut(2000);
              });
          }else{
              collectNum--;
              $(".third").find(".collect").attr("num",collectNum);

              $(".collect").text(collectNum);
              //取消收藏
              $.post("http://api.daifushuo.com:80/api/obookmarks/dfs_bookmark_del?access_token="+dfs_cookie.id,collectVideo,function(result) {
                  //console.log(result);
                  $(".prompt").text("取消收藏");
                  $(".prompt").fadeOut(2000);
              });
          }
          $(".prompt").removeAttr("style");
          $(".prompt").css("display","block");
          if($(this).hasClass("collectChecked")){

              
          }else{
              
          }
        }

    };
  
    <!--点赞-->

    this.share = function(){
        Test();

        var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));
        if(dfs_cookie != null){
            var collectNum = Number($(".myself").find(".share").attr("num"));
            //console.log(collectNum);

            var userlike = {
                postid : self.parent.vid,
                userid : dfs_cookie.userId
            };

            $(".share").toggleClass("shareChecked");

            if($(".share").hasClass("shareChecked")){
                collectNum++;
                $(".myself").find(".share").attr("num",collectNum);

                $(".share").text(collectNum);
            //点赞
                $.post(dfs.apiPostUrl+"/ilike?access_token="+dfs_cookie.id,userlike,function(data){
                    //console.log(data);
                    $(".prompt").text("点赞成功");
                    $(".prompt").fadeOut(2000);
                });

            }else{
                collectNum--;
                $(".myself").find(".share").attr("num",collectNum);
                $(".share").text(collectNum);
            //取消点赞
                $.post(dfs.apiPostUrl+"/dislike?access_token="+dfs_cookie.id,userlike,function(data){
                    console.log(data);
                    $(".prompt").text("取消点赞");
                    $(".prompt").fadeOut(2000);
                });
            }
            $(".prompt").removeAttr("style");
            $(".prompt").css("display","block");
            if($(this).hasClass("shareChecked")){

                
            }else{
                
            }
        }


    }
    this.share1 = function(){

      Test();

      var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));
      if(dfs_cookie != null){
          var collectNum = Number($(".third").find(".share").attr("num"));
          //console.log(collectNum);

          var userlike = {
              postid : self.parent.vid,
              userid : dfs_cookie.userId
          };

          $(".share").toggleClass("shareChecked");

          if($(".share").hasClass("shareChecked")){
              collectNum++;
              $(".third").find(".share").attr("num",collectNum);

              $(".share").text(collectNum);
          //点赞
              $.post(dfs.apiPostUrl+"/ilike?access_token="+dfs_cookie.id,userlike,function(){
                  //console.log(data);
                  $(".prompt").text("点赞成功");
                  $(".prompt").fadeOut(2000);
              });

          }else{
              collectNum--;
              $(".third").find(".share").attr("num",collectNum);
              $(".share").text(collectNum);
          //取消点赞
              $.post(dfs.apiPostUrl+"/dislike?access_token="+dfs_cookie.id,userlike,function(){
                  //console.log(data);
                  $(".prompt").text("取消点赞");
                  $(".prompt").fadeOut(2000);
              });
          }
          $(".prompt").removeAttr("style");
          $(".prompt").css("display","block");
          // if($(this).hasClass("shareChecked")){

          //     $(".prompt").text("点赞成功");
          //     $(".prompt").fadeOut(1000);
          // }else{
          //     $(".prompt").text("取消点赞");
          //     $(".prompt").fadeOut(1000);
          // }
      }


    }

    </script>

    <script>
            var self = this;
            RiotControl.trigger("getVideoDetail",self.parent.userid);
            RiotControl.on("videoDetailChanged",function(data){
                self.doctors = data;
                //console.log(data);
                for(var i = 0;i < data.length;i++){
                    if( data[i]._id == self.parent.vid){
                        self.postid = data[i]._id;
                        self.vsrc = data[i].vlink;
                        self.vcontent = data[i].content;
                        self.title = data[i].title;
                        self.dfs_share_sum = data[i].dfs_share_sum;
                        self.forward_num = data[i].forward_num;
                    }
                }
                self.update();
            });

</script>


</video-box>
    <!--医生信息-->
<doctor-description class="doctor-description">
    <div class="videoDesc">
        <div class="doctorDesc">
            <a class=" headIcon docMsg" href="{ doctorlink }">

                <div><img src={ msg.info.avatar[0] } alt="" ></div>
                <div>
                    <div>
                        <div>
                            <span class="name">{ msg.info.nickname }</span>
                            <span class="professionalitle">{ msg.info.title }</span>
                        </div>
                        <div>
                            <span class="addr">{ msg.info.hospital }</span>
                            <span class="administrative">{ msg.info.room }</span>
                        </div>
                    </div>

                </div>
            </a>
            <div class="focus" onclick="{ todoctor }"><span>查看资料</span></div>
    <!--
            <div class="focus" onclick="{ focused }">
                <span>+关注</span>
            </div>
    -->
        </div>
    </div>
    <script>
    var self = this;

    // <!--关注-->
    /*
    var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));

    //判断是否已经关注
    if(dfs_cookie != null){
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

    };


*/



    </script>
    <script>

        var self = this;
        self.parent = this.parent;
        self.msg = [];

        self.doctorlink = "doctorDetail.html?doctorid=" + self.parent.userid;

        RiotControl.trigger("getDoctorMessage",self.parent.userid);
        RiotControl.on("doctorMessage",function(data){
            self.msg = data;
            self.update();
        });

        todoctor(){
            window.location.href = self.doctorlink;
        }

    </script>
</doctor-description>
    <!-- 视频评论-->
<comment class="comment">
    <div class="videoCommentTotal">
        <div><img src="{ msg.avatar[0] }" id="userImg"></div>
        <div class="total"><a href="{ commentUrl }">已有<span>{ allCommentsLength?allCommentsLength:0 }</span>条评论,快来说出你的感想</a></div>
    </div>
    <div class='commentTitle'>用户评论</div>
    <comment-item each="{ comments }" item="{ this }"></comment-item>
    <div class='coms'></div>
    <div class="alink"><a href="{ commentUrl }">查看全部<span>{ allCommentsLength?allCommentsLength:0 }</span>条评论></a></div>
    <script>

        var self =this;
        var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));
        self.comments = [];
        if(dfs_cookie != null){
          self.commentUrl = "allComments.html?postid=" + self.parent.vid;
          //console.log(self.commentUrl);
          //personal message
          var msg={
              id: dfs_cookie.userId,
              token: dfs_cookie.id
          };

          RiotControl.trigger("getPersonalMessage",msg);
          RiotControl.on("personalMessageChanged",function(data){
              //console.log(data);
              self.msg = data;
          });
        }


    //
        RiotControl.trigger("getVideoComment",self.parent.vid);
        RiotControl.on("videoCommentChanged",function(data){
            self.comments = data._data.comments;
            self.allCommentsLength = data._data.comments.length;

            //少于3条隐藏

            if(self.comments.length>3){
                self.comments.length = 3;
                //$(".comment").find(".alink").show();
            }


            if(self.comments.length <= 0){
                $(".coms").append("<div class='nocomment'>暂无评论</div>");
                $(".commentTitle").hide();
                $(".coms").hide();
                $(".alink").hide();

            }
            //console.log(self.comments);
            self.update();
        });

    </script>
</comment>
    <!--更多视频-->
<comment-item>
    <div class="comment-item">
        <div class='commentHeadPng'>
            <img src='{ user.avatar[0] }'>
        </div>
        <div class="commentMessage">
            <div class="commentUserName">{ user.nickname }</div>
            <div class="created" style='color: #999;font-size: 1.2rem'>{ created }</div>
            <div class="commentContent">
                <span class='replyTitle'> { con1 }<span>{ con }</span> </span>
                <span>{ content }</span>
            </div>
        </div>
    </div>
    <style>
        .replyTitle{
            font-size: 1.2rem;
            color: #999;
        }
        .replyTitle span{
            color: #0076EF;
        }
    </style>
    <script>
        var self = this;
        if(this.reply_comment != null){
            this.con1 = "回复:";
            this.con =  this.reply_comment.nickname;
        }
    </script>
</comment-item>
<!--评论列表-->

<video-more >
    <div class="moreVideo">

        <div class="tit">他的视频</div>
        <more-video-list each={ doctors } vitem="{ this }"></more-video-list>
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
                  this.viewersnum = Number(this.viewersnum/10000).toFixed(1)+"w+";                }
            });

            self.doctors = data;
            //console.log(self.doctors);
            self.update();
        });

    </script>
</video-more>
    <!--更多视频列表-->
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
        self.commentLength = self._data.comments.length;
        self.data = opts.vitem;
        playVideoUrl(){
            let videoUrl = "videoDetail.html?vid=" + self._id + "&uid=" + self.userid;
            window.location.href = videoUrl;
        }

    </script>
</more-video-list>
