
function VideoListStore(){
    riot.observable(this);
    var self = this;
    self.ilist = [];

//轮播carousel
    self.on("getCarouselList",function(){
        $.ajax({
            url: "http://api.daifushuo.com:80/api/slide-img?filter[order]=created%20DESC",
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.carousel = data;
                self.trigger("carouselListChanged",self.carousel);
            }
        });

    });


/* 首页改版数据 */

// 入驻医生
    self.on("getDoctorList",function(page){
        var dUrl = "http://api.daifushuo.com/api/ousers/recommend_doctor_list?/size=10&page=" + page;
        $.ajax({
            url: dUrl,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.doctors = data;
                self.trigger("doctorListChanged",self.doctors);
            }
        });
    });



//推荐视频
    self.on("getRecommendList",function(page){
        var rUrl = "http://api.daifushuo.com/api/oposts/recommend_post_list?/size=10&page=" + page;
        $.ajax({
            url: rUrl,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.recommends = data;
                self.trigger("recommendListChanged",self.recommends);
            }
        });
    });

//健康专题
    self.on("getHealthyList",function(page){
        $.ajax({
            url: "http://api.daifushuo.com:80/api/topics/load_topic_list?/size=10&page=" + page,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.healthy = data;
                self.trigger("healthyListChanged",self.healthy);
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {

            }
        });

    });

//专题视频
    self.on("getHealthyVideoList",function(healthy){

        var url = "http://api.daifushuo.com:80/api/search/load_topic_posts?&access_token=" + healthy.token;
        var query = {
                "page":healthy.page,
                "size": 10,
                "query":healthy.keyword
            };

        $.post(url,query,function(data){
            self.healthyVideo = data;
            self.trigger("healthyVideoListChanged",self.healthyVideo);
        })
        /*
        $.ajax({
            url: url,
            async: true,
            type: "post",
            dataType: 'json',
            data: query,
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.healthyVideo = data;
                self.trigger("healthyVideoListChanged",self.healthyVideo);
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {

            }
        });
        */


    });


//hot (index,topic)
    self.on("getHotVideoList",function(page){
        $.ajax({
            url: dfs.apiPostUrl+"/dfs_load_posts_hot?/size=10&page=" + page,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                $(data).each(function(){
                    //this.duration = getVideoTime(this.vlink);
                    var videoInfo = this.vlink + "?avinfo";
                    $.get(videoInfo,function(data){
                        this.info = data;
                    })
                    //console.log(this.info);
                })
                
                self.ilist = data;
                self.trigger("videoHotListChanged",self.ilist);
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {

            }
        });

    });


/*topic页面*/

//时间倒序(最新)
    self.on("getNewVideoList",function(page){
        $.ajax({
            url: dfs.apiPostUrl+"/dfs_load_posts?/size=10&page=" + page,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.ilist = data;
                self.trigger("videoNewListChanged",self.ilist);
            }
        });

    });
//关注
    self.on("getFocusVideoList",function(page){

        $.ajax({
            url: dfs.apiPostUrl+"/dfs_load_posts_to_user_page?userid="+page.userid+"&access_token="+page.access_token +"&page="+page.page,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.ilist = data;
                self.trigger("videoFocusListChanged",self.ilist);
            }
        });

    });
//导航其他topic
    self.on("getOtherVideoList",function(topicQuery){
        $.post("http://api.daifushuo.com:80/api/search/dfs_search_topics",topicQuery,function(data){
            self.trigger("videoOtherListChanged",data);
        });

    });
//按科室搜索
    self.on("getRoomVideoList",function(query){
        $.post("http://api.daifushuo.com:80/api/search/dfs_search_room",query,function(data){
            self.trigger("videoListChanged",data);
        });

    });

//导航栏
    self.on("getTopicList",function(){
        $.get("http://api.daifushuo.com:80/api/tools/dfs_topic_list",function(data){
            self.trigger("topicListChanged",data);
        });

    });

//registration
    self.on("getRegistrationList",function(){
        $.ajax({
            url: "http://api.daifushuo.com:80/api/guahaos/load_hospital_list",
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.registration = data;
                self.trigger("registrationListChanged",self.registration);
            }
        });

    });
//help
    self.on("getHelpList",function(){
        $.ajax({
            url: "http://api.daifushuo.com/api/insurances/load_insurance_list",
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.help = data;
                self.trigger("helpListChanged",self.help);
            }
        });

    });
//disease
    self.on("getDiseaseList",function(){
        var disease={},name=[],linshi=[],tags=[];
        $.ajax({
            url: "http://api.daifushuo.com:80/api/tools/dfs_illness_list",
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                
                $(data).each(function(){

                    name.push($(this)[0]);
                    this.shift();
                    tags.push(this);
                    
                });
                self.disease = {
                    name : name,
                    tags : tags
                }
                //console.log(disease);
                self.trigger("diseaseListChanged",self.disease);
            }
        });

    });

}


function getVideoTime(videoUrl){
    var videoInfo = videoUrl + "?avinfo";
    var info;
     $.get(videoInfo,function(data){
        var info = data;
     })
    return info;
}

