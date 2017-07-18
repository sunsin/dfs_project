<mine class="mine">
        <div class="mineTitle">我的</div>
        <div class="head">
            <div>
                <img src="{ myinfo.avatar[0] }" id="headimage">
                <span id="nickname" style="display: block;">{ myinfo.nickname }</span>
            </div>
            <div class="myinfo">
                <div>
                    <div>{ userMetadata.video || 0 }</div>
                    <div>原创视频</div>
                </div>
                <div onclick="{ goTofans }">
                    <div>{ userMetadata.follower || 0}</div>
                    <div>粉丝</div>
                </div>
            </div> 
        </div>
        <div class="func">
            <div class="answer">
                <a href="myquestion.html">
                    <img src="../images/version2/2/icon_my_ask.png" alt="">
                    <span>我的提问</span>
                </a>
            </div>
            <div class="myanswer" if={ myinfo.can_ask }>
                <a href="myanswer.html">
                    <img src="../images/version2/2/icon_my_answer.png" alt="">
                    <span>我的回答</span>
                </a>
            </div>
            <div class="mywallet" if={ myinfo.can_ask }>
                <a href="mywallet.html">
                    <img src="../../images/version2/2/icon_my_cash.png" alt="">
                    <span>我的钱包</span>
                </a>
            </div>
            
            <div class="collect">
                <a href="collect.html">
                    <img src="../images/version2/icon/shoucang.png" alt="">
                    <span>我的收藏</span>
                </a>
            </div>
            <div class="myfocus">
                <a href="focus.html">
                    <img src="../images/version2/icon/guanzhu.png" alt="">
                    <span>我的关注</span>
                </a>
            </div>
            <div class="myhistory">
                <a href="history.html">
                    <img src="../images/version2/icon/lishi3.png" alt="">
                    <span> 播放历史</span>
                </a>
            </div>
            <div class="doctorAttestation">
                <a href="" id="edge">
                    <img src="../images/version2/icon/attention.png" alt="">
                    <span>医生认证  (认证请下载APP)</span>
                </a>
            </div>
        </div>
    </div>
    <script>
        var self = this;
        var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));
        RiotControl.trigger("getMyselfInfo",dfs_cookie);
        RiotControl.on("myselfInfoChanged",function(data){
            self.myinfo = data;
            //console.log(data);
            RiotControl.trigger("getUserMetadata",data.id);
            RiotControl.on("userMetadataChanged",function(meta){
                self.userMetadata = meta;
                console.log(meta);
                self.update();
            });
            self.update();
        });

        

        linkedme.init("linkedme_live_d88f9589ee225d010c0210b7944c550e", {type: "live"}, null);
        var data = {};
        data.params = '{"View":"Certify"}';
        linkedme.link(data, function(err, data){
            if(err){
                // 生成深度链接失败，返回错误对象err
            } else {

                console.log(data);
                var a = document.getElementById("edge");
                a.setAttribute("href",data.url);
            }
        },false);
        goTofans(){
            var url = "myfans.html?userid="+self.myinfo.id;
            location.href = url;
        }
    </script>
</mine>
