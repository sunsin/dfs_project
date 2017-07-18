<history class="historyList">
    <history-item each={ history } vitem="{ this }"></history-item>
    <script>
        var self = this;

        this.on("mount",function(){
        Test();
        });
        var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));
        //console.log(dfs_cookie);

        var history = {
            userid : dfs_cookie.userId,
            accessToken : dfs_cookie.id
        };

        RiotControl.trigger("getHistoryList",history);
        RiotControl.on("historyListChanged",function(data){
            self.history = data;
            //console.log(data);
            self.update();
        });


    </script>
</history>


<history-item class="video-item">
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
        self.playVideoUrl = "videoDetail.html?vid=" + self._id + "&uid=" + self.userid;
    </script>
</history-item>