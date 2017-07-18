<search class='doctor-search-box' style="margin-bottom: 50px;">
    <doctor-search each="{ doctorSearch }"></doctor-search>
    <page></page>
    <script>
        var self = this;
        riot.route(function(){
            var q = riot.route.query();
            self.query = decodeURI(q.query);
            self.page = q.page;
            //console.log(self.page);
            self.update();
        });
        riot.route.stop();
        riot.route.start(true);

        if(location.search.indexOf("&") != -1){
            self.query = self.query || location.search.split("query=")[1].split("&")[0];
        }else{
            self.query = self.query || location.search.split("query=")[1];
        }
        if(location.search.indexOf("page") != -1){
            self.page = self.page || location.search.split("page=")[1];
            if(location.search.indexOf("&") != -1){
                self.page = self.page || location.search.split("page=")[1].split("&")[0];
            }else{
                self.page = self.page || location.search.split("page=")[1];
            }
        }else{
            self.page = 0;  
        }

        self.query = decodeURI(self.query);

        if(typeof(self.page) == "undefined"){
            self.page = 0;
        }
        if(isNaN(self.page)){
            self.page = 0;
        }
        

        var message = {
            query: self.query,
            page: self.page
        };

        RiotControl.trigger("getSearchList",message);
        RiotControl.on("searchChanged",function(data){
            console.log(data);
            $(data[0]).each(function(){
                if(this.media == "4"){
                    this.media = "专题号";
                }else{
                    this.media = "大夫号";
                }
            });
            self.doctorSearch = data[0];
            self.videoSearch = data[1];
            if(data[0].length<1){

                $(".doctor-search-box").append("<div class='nodata'><div>暂无数据</div></div>");
                $(".page").hide();

            }

            self.update();
        });
    </script>
</search>
<doctor-search>
    <a href="{ doctorUrl }">
        <img src='{ avatar[0] }'>
        <div>
            <div class='nickname'>{ nickname }</div>
            <div class='line2'>
                <span class='hospital'>{ hospital }</span>
                <span class='room'>{ room }</span>
            </div>
        </div>
    </a>
    <script>
        var self = this;
        self.doctorUrl = "doctorDetail.html?doctorid=" + self._id;
    </script>
</doctor-search>


<page class="page">
    <span onclick="{ pre }">上一页</span>
    <span onclick="{ next }">下一页</span>
    <script>
        var self = this;
        var pageNext = Number(self.parent.page)+1;
        var pagePre = Number(self.parent.page)-1;

        if(pagePre == -1){
            pagePre = 0;
        };
        self.pageNextUrl = "moreDoctorSearch.html?query="+self.parent.query+"&page="+ pageNext;
        self.pagePreUrl = "moreDoctorSearch.html?query="+self.parent.query+"&page="+ pagePre;
        this.next=function(){
            window.location.href = self.pageNextUrl;
        }
        this.pre=function(){
            window.location.href = self.pagePreUrl;
        }

    </script>
    <style>
    .page{
        display: block;
        height: 50px;
        line-height: 50px;
        text-align: center;
        overflow: hidden;
        background: #f3f3f3;
        border-bottom: 1px solid #ddd;
    }
    .page span{
        background: #fff;
        text-align: center;
        margin: 0 10px;
        padding: 5px 15px;
        border: 1px solid #999;
        border-radius: 15px;
    }
    .ko{
        color: #ed4542;
    }
    </style>
</page>