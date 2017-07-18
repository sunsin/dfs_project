<collect class="collectList">
    <collect-item each={ collect } vitem="{ this }"></collect-item>
    <script>
        var self = this;

        this.on("mount",function(){
            Test();
        });
        var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));
        //console.log(dfs_cookie);

        var collect = {
            userid : dfs_cookie.userId,
            accessToken : dfs_cookie.id
        };

        RiotControl.trigger("getCollectList",collect);
        RiotControl.on("collectListChanged",function(data){
            self.collect = data;
            console.log(data);
            self.update();
        });


    </script>
</collect>


<collect-item class="video-item">
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
            let videoUrl = "videoDetail.html?vid=" + self.data._id + "&uid=" + self.userid;
            window.location.href = videoUrl;
        }
        
    </script>
</collect-item>