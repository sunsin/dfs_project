<hospital class="hospital-box">
    <div class="forword" onclick="{ gohistory }">
        <div class="back"><span>医院</span></div>
    </div>

    <hospital-message></hospital-message>

    <div class='hospital-title'>科室</div>
    <hospital-room></hospital-room>

    <script>
        var self = this;
        riot.route(function(){
            var q = riot.route.query()
            self.hospitalid = q.hospitalid;
            //console.log(self.hospitalid);
            self.update();
        });

        riot.route.stop();
        riot.route.start(true);

        if(location.search.indexOf("hospitalid") != -1){
            if(location.search.indexOf("&") != -1){
                self.hospitalid = self.hospitalid || location.search.split("hospitalid=")[1].split("&")[0];
            }else{
                self.hospitalid = self.hospitalid || location.search.split("hospitalid=")[1];
            }
            
        }else{
            self.hospitalid = self.hospitalid;
        }
        //console.log(self.hospitalid);

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
</hospital>

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
        <div class="profile lines" id="content">{ information.profile[0] }</div>
        <div class="textmore glyphicon glyphicon-chevron-down showmore"></div>
        <div class="textmore glyphicon glyphicon-chevron-up hidemore"></div>

    </div>
    <script>
        var self = this;
        var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));

        var hos = {
            hospitalid: self.parent.hospitalid,
            token: dfs_cookie.id
        };

        RiotControl.trigger("getHospitalInformation",hos);
        RiotControl.on("hospitalInformationChanged",function(data){
            self.information = data;
            //console.log(data);
            if(data.profile == "" || data.profile[0] ==""){
                //console.log("null");
                $(".link-detail").hide();
            }
            self.update();
        });

        this.jianjie = function(){
            $(".profile").toggle();
        }
        $(function(){


            $(".showmore").click(function(){
                var lines = $(".profile").height()/20;
                if(lines > 4){
                    $(".hidemore").show();
                    $(".profile").removeClass("lines");
                    
                }else{
                    $(".hidemore").hide();
                }
                $(this).hide();
                
            });
            $(".hidemore").click(function(){
                $(this).hide();
                $(".showmore").show();
                $(".profile").addClass("lines");
            })
        })
            
            


    </script>
    <style>
        .link-detail{
            
        }
        .textmore{
            text-align: center;
            width: 100%;
            height: 35px;
            background: rgba(0,0,0,0.1);
            bottom: 0px;
        }
        .profile{
            line-height: 20px;
        }
        .lines{
            display:-webkit-box;
            -webkit-line-clamp: 5;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .hidemore{
            display: none;
        }
    </style>
</hospital-message>


<hospital-room class="hospital-room">
    <hospital-room-item each="{ rooms }"></hospital-room-item>
    <script>
        var self = this;

        RiotControl.trigger("getHospitalRoomList",self.parent.hospitalid);
        RiotControl.on("hospitalRoomListChanged",function(data){
            self.rooms = data;
            //console.log(data);
            self.update();
        });

    </script>
</hospital-room>

<hospital-room-item class="hospital-room-item">
    <div class="item" onclick="{ roomUrl }">
            <div><img src="{ avatar[0] }"></div>
            <div>{ nickname }</div>
        </div>
    </div>
    <script>
        var self = this;
        this.roomUrl = function(){
            var url="room.html?roomid="+ self._id;
            window.location.href = url;
        }
    </script>
</hospital-room-item>
