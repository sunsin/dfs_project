<wechat class="wechat">
	<div  class="search" >
        <div>
            <img src="images/icon/logo.png">
        </div>
        <div class="searchBtn" onclick="{ toSearchUrl }">
            <!-- <img src="images/version2/search.png" alt=""> -->
        </div>
    </div>
   	<!-- 轮播 -->
	<carousel></carousel>
    <div class="disease">
        <a href="html/regishelp.html?topic=disease">
            疾病查询   
        </a>
    </div>
    <healthy></healthy>
	<recommended></recommended>
	<doctors></doctors>
    <hotVideo></hotVideo>
    <column></column>
    <index></index>
    
    <script>
        var self = this;
        toSearchUrl(){
            var toSearchUrl = "html/search.html";
            window.location.href = toSearchUrl;
        }
    </script>
</wechat>


<!-- 轮播 -->
<carousel id="carousel-example-generic" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
        <ol class="carousel-indicators"></ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">
        <!--<carousel-item class="item active" each="{ carousel }"></carousel-item>-->
    </div>

    <!-- Controls -->
    <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right"></span>
        <span class="sr-only">Next</span>
    </a>
    <script>
        var self = this;
        RiotControl.trigger("getCarouselList",self.parent.page?self.parent.page:0);
        RiotControl.on("carouselListChanged",function(data){
            self.carousel = data;
            if(data.length == 0){
                $("#carousel-example-generic").hide();
            }
            for(var i=0;i<data.length;i++){

                var slide = "<div class='item'><a href='"+data[i].link_url+"'><img src='"+data[i].img_url+"' alt='大夫说'><div class='carousel-caption'>"+data[i].title+"</div></a></div>";
                $(".carousel-inner").append(slide);
                var slideOli = "<li data-target='#carousel-example-generic' data-slide-to='"+i+"'></li>";
                $(".carousel-indicators").append(slideOli);
            }
            $(".item").eq(0).addClass("active")


            self.update();
        });
    </script>
</carousel>

<index class="index_tab">
    <div>
        <ul>
            <li>
                <a href="html/regishelp.html?topic=registration">
                    <div>超级挂号</div>    
                </a>
            </li>
            <li>
                <a href="html/regishelp.html?topic=help">
                    <div>医疗互助</div>    
                </a>
            </li>
        </ul>
    </div>
</index>



<!-- 热门视频 -->
<hotVideo class="wechatTab">
	<div class="topicTab">
		<span>热门视频</span>
		<a href="topic.html">更多></a>
	</div>
	<hot-item each="{ information }"></hot-item>
	<script>
		var self = this;
		var page = 0;
		RiotControl.trigger("getHotVideoList",page);
        RiotControl.on("videoHotListChanged",function(data){
        
        	data.length = 4;
            $(data).each(function(){
                if(this.viewersnum >= 10000){
                    this.viewersnum = Number(this.viewersnum/10000).toFixed(1)+"w+";
                }
            })
            self.information = data;
            self.update();
        });
	</script>
</hotVideo>
<hot-item class="hot-item" onclick="{ toVideoPlay }">
    <div class="videoDetail">
        <div class="videoVcover">
                <img src="{ vcover }" alt=""  class="more-video-img">
                <div class='watermark'><img src="images/version2/icon/icon_play_home.png"></div>
        </div>
        <div class="videoInfo" >
            <div class="videoTitle">{ title }</div>
            <!-- <div class="videoTxt">{ content }</div> -->
            <div class="videoData">
                <!-- <div class="mediaType col-md-4 col-xs-4">{ media }</div> -->
                <div class="comment col-md-6 col-xs-6">{ _data.comments.length }</div>
                <div class="views col-md-6 col-xs-6">{ viewersnum }</div>
            </div>
        </div>
        
    </div>
	
	<script>
		var self = this;
        
        self.comments = String(self._data.comments.length);
        toVideoPlay(){
            var toVideoPlayUrl = "html/videoDetail.html?vid="+ self._id +"&uid=" + self.userid;
            window.location.href = toVideoPlayUrl;
        }
	</script>
    
</hot-item>

 <!-- 入驻医生 -->
<doctors class="wechatTab doctorList">
	<div class="topicTab">
		<span>入驻医生</span>
		<a href='html/doctorList.html?topic=doctor'>更多></a>
	</div>
    <ul>
        <li each="{ doctors }">
            <doctor-item></doctor-item>
        </li>
    </ul>
	
	<script>
		var self = this;
		var page = 0;
		var dUrl = "http://api.daifushuo.com/api/ousers/recommend_doctor_list?/size=10&page=" + page;
        $.get(dUrl,function(data){
            
        	data.length = 9;
            self.doctors = data;
            self.update();
        });
	</script>
</doctors>
<doctor-item class="doctor-item">
	<div class='doctor-avatar' onclick="{ toDortorDetail }">
		<img src="{ avatar[0] }" alt="">	
	</div>
	<div class='nick'>{ nickname }</div>
	<div class='minh'>{ title }</div>
	<div class='minh'>{ hospital }</div>
	<script>
		var self = this;
        toDortorDetail(){
            var toVideoPlayUrl = "html/doctorDetail.html?doctorid=" + self._id;
            window.location.href = toVideoPlayUrl;
        }
	</script>
</doctor-item>


<!-- 推荐视频 -->
<recommended class="wechatTab recommend">
	<div class="topicTab">
		<span>推荐视频</span>
		<a href="html/commen.html?commen=video">更多></a>
	</div>
    <ul>
        <li each="{ recommends }"><recommended-item></recommended-item></li>
    </ul>
    
	
	<script>
		var self = this;
        var page = 0;
        RiotControl.trigger("getRecommendList",page);
        RiotControl.on("recommendListChanged",function(data){
            data.length = 3;
            $(data).each(function(){
                if(this.viewersnum >= 10000){
                    this.viewersnum = Number(this.viewersnum/10000).toFixed(1)+"w+";
                }
            })
            self.recommends = data;
            
            self.update();
        });
	</script>
</recommended>
<recommended-item class="recommend-item">
	<div class="videoDetail" onclick="{ toVideoPlay }">
        <div class="videoVcover">
                <img src="{ vcover }" alt=""  class="more-video-img">
                <div class='watermark'><img src="images/version2/icon/icon_play_home.png"></div>
        </div>
        <div class="videoInfo" >
            <div class="videoTitle">{ title }</div>
            <!-- <div class="videoTxt">{ content }</div> -->
            <div class="videoData">
                <!-- <div class="mediaType col-md-4 col-xs-4">{ media }</div> -->
                <div class="comment col-md-6 col-xs-6">{ _data.comments.length }</div>
                <div class="views col-md-6 col-xs-6">{ viewersnum }</div>
            </div>
        </div>
        
    </div>
    <script>
        var self = this;
        toVideoPlay(){
            var toVideoPlayUrl = "html/videoDetail.html?vid="+ self._id +"&uid=" + self.userid;
            window.location.href = toVideoPlayUrl;
        }
    </script>
</recommended-item>

<!-- 精彩专栏 -->
<column class="wechatTab doctorList">
    <div class="topicTab">
        <span>精彩专栏</span>
        <a href='html/doctorList.html?topic=column'>更多></a>
    </div>
    <ul>
        <li each="{ column }">
            <column-item></column-item>
        </li>
    </ul>
    
    <script>
        var self = this;
        var cUrl = "http://api.daifushuo.com:80/api/ousers/recommend_pgc_list?/size=9&page=0";
        $.get(cUrl,function(data){
            self.column = data;
            self.update();
        });
    </script>
</column>
<column-item class="column-item doctor-item">
    <div class='doctor-avatar' onclick="{ toDortorDetail }">
        <img src="{ avatar[0] }" alt="" style="border-radius: 15px;">    
    </div>
    <div class='nick' style="padding: 10px 0;">{ nickname }</div>
    <script>
        var self = this;
        toDortorDetail(){
            var toVideoPlayUrl = "html/doctorDetail.html?doctorid=" + self._id;
            window.location.href = toVideoPlayUrl;
        }
    </script>
</column-item>



<!-- 健康专题 -->
<healthy class="wechatTab">
    <div class="topicTab">
        <span>健康专题</span>
        <a href="html/commen.html?commen=healthy">更多></a>
    </div>
    <healthy-item each="{ healthy }"></healthy-item>
    <script>
        var self = this;
        var page = 0;
        RiotControl.trigger("getHealthyList",page);
        RiotControl.on("healthyListChanged",function(data){
            data.length = 4;
            console.log(data);
            self.healthy = data;
            self.update();    
        });
    </script>
</healthy>
<healthy-item class="health-item" onclick="{ healthy }">
    <div class='cover'>
        <img src="{ cover }" alt="">
        <div class="bg"></div>
    </div>
    <div class='title'>{ title }</div>
    
    <script>
        var self = this;
        healthy(){
            var toHealthyUrl = "html/healthy.html?healthy=" + self.keyword + "&banner=" + self.banner + "&bannerurl=" + self.banner_url;
            window.location.href = toHealthyUrl;
        }
    </script>
</healthy-item>



