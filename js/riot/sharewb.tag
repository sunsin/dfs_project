<play class="play">
    <video-box></video-box>
    <doctor-description></doctor-description>
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
            <!-- <a class="linked" href="{ linked }">打开大夫说,提升3倍流畅度</a> -->
            <!-- <a href="{ thirdPart.reportUrl }" class='report-link'><img src="../images/icon/report.png"></a> -->
            <a class="third-link" href="{ thirdPart.vsource_url }"><img src="../images/icon/link.png"></a>
        </div>
        <div class="msg">
            <div style="padding: 10px;font-size: 1.6rem;">{ thirdPart.title }</div>

            
            <div class="prompt"></div>
        </div>
        <p>{ thirdPart.content }</p>
    </div>
    <!--自产-->
    <div class="myself">
        <video id="video" class="video-js vjs-default-skin" preload="auto" controls type="video/mp4" poster="{ video.vcover }" src="{ video.vlink }" postid="{ video._id }" onclick="{ videoplay }">
        </video>
        
        <div class="link">
           
       </div>
        <div class="totalClick" style="display: none;" value="1"></div>

        <div class="msg">
            <div style="padding: 10px;font-size: 1.6rem;">{ video.title }</div>

            
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
            //console.log(data);
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


    
    this.videoplay = function(){


    
    //增加播放次数
        var video = videojs("video");
        var tatalClickNum = Number($(".totalClick").attr("value"));
        var maxRandom,add_sum;
        //console.log(tatalClickNum%2);
        $.get("http://api.daifushuo.com:80/api/tools/dfs_double_click",function(data){
            console.log(data);
            maxRandom = data.max;
        });
        if(tatalClickNum%2 == 1){
            video.play();
        //viewsum++(视频播放次数增加)
            //random();


            add_sum = Math.ceil(Math.random()*100);
            var sum = {
                sum: add_sum
            };
            $.get("http://api.daifushuo.com:80/api/oposts/dfs_add_viewsum?postid="+self.parent.vid,sum,function(data){
                console.log(data);
            });

        }else{
            video.pause();
        }
        tatalClickNum = tatalClickNum+add_sum;
        $(".totalClick").attr("value",tatalClickNum);

    };


    

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
        <div class="doctorDesc" style="border-bottom: 0;border-top: 1px solid #ebebeb;">
            <a class=" headIcon docMsg">

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
        </div>
    </div>
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
    </script>
</doctor-description>

