<answervideo class="play">
    <div class="forword" onclick="{ gohistory }">
        <div class="back"><span>医生回答</span></div>
    </div>
    <video-box></video-box>
    <!-- <comment></comment> -->
    <token id="token" token="" userId=""></token>
    <!-- <video-more></video-more> -->

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
            var userid = (url.split("vid=")[1]).split("uid")[1].split("=")[1];

            self.vid = self.vid || postid;
            self.userid = self.userid || userid;




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
</answervideo>

    <!--video播放-->
<video-box class="video-box">
    <div class="myself">
        <video id="video" class="video-js vjs-default-skin" preload="auto" controls type="video/mp4" poster="{ video.vcover }" src="{ video.video }" postid="{ video._id }" onclick="{ videoplay }">
        </video>
        
        <div class="totalClick" style="display: none;" value="1"></div>

        <div class="msg">
            <div style="padding: 10px;font-size: 1.6rem;">{ video.title }</div>

            
            <div class="prompt"></div>
        </div>
        <p>{ video.content }</p>
    </div>

    <div class="videoDesc">
        <div class="doctorDesc" style="border-bottom: 0;border-top: 1px solid #ebebeb;">
            <a class=" headIcon docMsg">

                <div><img src="{ video.answer_user.avatar[0] }" alt="" ></div>
                <div>
                    <div>
                        <div>
                            <span class="name">{ video.answer_user.nickname }</span>
                            <span class="professionalitle">{ video.answer_user.title }</span>
                        </div>
                        <div>
                            <span class="addr">{ video.answer_user.hospital }</span>
                            <span class="administrative">{ video.answer_user.room }</span>
                        </div>
                    </div>

                </div>
            </a>
            <div class="toquestion">
                <div onclick="{ questiontodoctor }">向他提问</div>
            </div>
        </div>
    </div>
    <div class="cantask">
        <div>此医生暂未开通问答功能</div>
    </div>
    <style>
        .cantask{
            display: none;
            width: 80%;
            margin: 0 auto;
            height: 40px;
            border: 1px solid #ed4542;
            border-radius: 5px;
            text-align: center;
            line-height: 40px;
        }
        .cantask >div{
            font-size: 1.4rem;
            color: #434343;
        }
    </style>
<script>
        var self = this;
        var videoWidth = document.body.clientWidth;
            $("#video").css("height",videoWidth);
            //console.log(self.parent.vid);
        var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));
        var infos = {
            "questionid" : self.parent.vid,
            "userid": dfs_cookie.userId
        }
        RiotControl.trigger("getPayVideoList",infos);
        RiotControl.on("payVideoListChanged",function(data){
            console.log(data);
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

        self.doctorlink = "doctorDetail.html?doctorid=" + self.parent.userid;
        

        questiontodoctor(){
            if(self.video.answer_user.can_ask == null || self.video.answer_user.can_ask=="false"){
                $(".cantask").show();
            }else{
                var url="http://weixin.daifushuo.com/test/html/userQuestion.html?doctorid="+ self.parent.userid;
                window.location.href = url;  
            }
            
        }
</script>
<style>
    .toquestion{
        float: right;
        margin-top: 35px;
        width: 30%;
        text-align: center;
    }
    .toquestion >div{
        width: 80%;
        padding: 5px;
        margin: 0 auto;
        border: 1px solid #ed4542;
        border-radius: 5px;
        color: #ed4542;
        font-size: 1.6rem;
    }
</style>

</video-box>


