<personal class="personal">
    <div class="forword" onclick="{ gohistory }">
        <div class="back"><span>{ userinfo.nickname }</span></div>
    </div>
    <div>
        <div class="dfs_headpng">
            <img src='{ userinfo.avatar[0] }' id="dfs_user_img" />
        </div>
        <div class="dfs_name">
            <span id="dfs_user_name">{ userinfo.nickname }</span>
        </div>
    </div>
    <script>

        var self = this;
        self.userid = location.href.split("userid=")[1].split("&")[0];
        RiotControl.trigger("getUserInformation",self.userid);
        RiotControl.on("userInformationChanged",function(data){
            self.userinfo = data;
            console.log(data);
            self.update();

        });
        gohistory(){
            if(document.referrer.indexOf("topic")!=-1){
                window.location.href = document.referrer;
            }else if(document.referrer == ""){
                window.location.href = "http://weixin.daifushuo.com";
            }else{
                window.history.go(-1);
            }
        }
    </script>
</personal>