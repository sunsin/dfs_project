<disease class='' style="display: block;margin-bottom: 55px;">
    <div class="forword" onclick="{ gohistory }">
        <div class="back"><span>{ disease }</span></div>
    </div>
    <div class="nodata" style="height: 240px"><div>没有数据</div></div>
    <disease-list-item each={ list } vitem="{ this }"></disease-list-item>
    <page></page>
    <script>

        var self = this;
    //返回按钮
        this.gohistory = function(){
            window.history.go(-1);
        };
        self.list= [];
    //路由
        riot.route(function(){
            var q = riot.route.query()
            self.disease = decodeURI(q.disease);
            self.page = q.page;
            //console.log(self.room);
            self.update();
        });
        riot.route.stop();
        riot.route.start(true);



        self.disease = self.disease || location.href.split("disease=")[1].split("&")[0];

        if(location.search.indexOf("page") != -1){
            self.page = self.page || location.href.split("page=")[1].split("&")[0];
        }else{
            self.page = 0;
        }
        //

        self.disease = decodeURI(self.disease);
        //console.log(self.roomList);
        var query = {
            "query": decodeURI(self.disease),
            "size": 10,
            "page": self.page
        };

        RiotControl.trigger("getDiseaseVideoList",query);
        RiotControl.on("diseaseListChanged",function(data){
            console.log(data);
            $(data).each(function(){
            if(this.media == "4"){
                this.media = "专题号";
            }else{
                this.media = "大夫号";
            }
            });
            self.list = data;

            if(data.length < 1){
                $(".nodata").show();
                $(".page").hide();
            }else{
                $(".nodata").hide();
            }

            self.update();
        });

        

    </script>
</disease>

<disease-list-item>
     <div class="videoDetail1" onclick="{ playVideoUrl }">
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
        playVideoUrl(){
            self.videoUrl = "videoDetail.html?vid=" + self._id + "&uid=" + self.userid;
            window.location.href = self.videoUrl;
       }
       
    </script>

</disease-list-item>
<page class='page'>
    <ul class="pager" style="padding: 10px 0 20px 0">
        <li><a href="{ pagePreUrl }">上一页</a></li>
        <li><a href="{ pageNextUrl }">下一页</a></li>
    </ul>
    <script>
        var self = this;


        var pageNext = Number(self.parent.page)+1;
        var pagePre = Number(self.parent.page)-1;

        if(pagePre == -1){
            pagePre = 0;
        }
        self.pageNextUrl = "disease.html?disease="+ decodeURI(self.parent.disease) +"&page="+ pageNext;
        self.pagePreUrl = "disease.html?disease="+ decodeURI(self.parent.disease) +"&page="+ pagePre;


    </script>
</page>
