function VideoDetailStore(){

    riot.observable(this);
    var self = this;
    self.doctors = [];
    self.comments = [];
//video-play
    self.on("getVideoPlay",function(vid){
        $.ajax({
            url: dfs.apiPostUrl + "/dfs_load_post_by_id?postid=" + vid,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.videoPlay = data;
                //console.log(data);
                self.trigger("videoPlayChanged",self.videoPlay);
            }
        });

    });

// Video
    self.on("getVideoDetail",function(userid){
        $.ajax({
            url: dfs.apiPostUrl + "/dfs_load_posts_by_user?userid=" + userid,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.doctors = data;
                //console.log(data);
                self.trigger("videoDetailChanged",self.doctors);
            }
        });

    });
//more video
    self.on("getMoreVideoDetail",function(doctorMesage){
        $.ajax({
            url: dfs.apiPostUrl + "/dfs_load_posts_by_user?size=10&page="+ doctorMesage.page +"&userid=" + doctorMesage.doctorid,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.doctors = data;
                //console.log(data);
                self.trigger("videoMoreDetailChanged",self.doctors);
            }
        });

    });
//评论
    self.on("getVideoComment",function(postid){
        $.ajax({
            url: dfs.apiPostUrl + "/dfs_load_post_by_id?postid=" + postid,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                $(data._data.comments).each(function(){
                    var timestamp = Date.parse(new Date(this.created))
                    var time = new  Date(timestamp);
                    this.created = formatDate(time);
                });
                self.comments = data;

                self.trigger("videoCommentChanged",self.comments);
            }
        });
    });

    //用户信息
    /*
    self.on("getVideoComment",function(postid){
        $.ajax({
            url: dfs.apiPostUrl + "/dfs_load_post_by_id?postid=" + postid,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.comments = data;

                self.trigger("videoCommentChanged",self.comments);
            }
        });
    });
    */

    //doctorDescription
    self.on("getDoctorMessage",function(userid){
        $.ajax({
            url: dfs.apiUserUrl + "/dfs_load_user_info?userid=" + userid,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                if(data.info.profile[0] || data.info.profile[1]){
                    var str = data.info.profile[0];
                    var nLength = data.info.profile[0].split("\n").length-1;
                    var ef="";
                    
                        
                        if(nLength>0){
                            for(var i=0;i<=nLength;i++){
                                ef = ef + str.split("\n")[i] + "<br />";
                            }
                        }else{
                            ef = str;
                        }
                    var str1 = data.info.profile[1];
                    var nLength1 = data.info.profile[1].split("\n").length-1;
                    var efw="";
                    
                       
                        if(nLength1>0){
                            for(var j=0;j<=nLength1;j++){
                                efw = efw + str1.split("\n")[j] + "<br />";
                            }
                        }else{
                            efw = str1;
                        }
                
                    
                    
                    data.info.profile[0] = ef;
                    data.info.profile[1] = efw;
                }
                
                self.message = data;
                self.trigger("doctorMessage",self.message);
            }
        });
    });
    //doctor-hot-videoList

    self.on("getHotVideo",function(userid){
        $.ajax({
            url: dfs.apiPostUrl + "/dfs_load_posts_by_user_top1?userid=" + userid,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.hotvideo = data;
                //console.log(data);
                self.trigger("hotVideoShow",self.hotvideo);
            }
        });

    });
    //PERSONAL MESSAGE
    self.on("getPersonalMessage",function(msg){
        $.ajax({
            url: dfs.apiUserUrl+"/"+msg.id+"?access_token="+msg.token,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.hospitalVideoList = data;
                self.trigger("personalMessageChanged",data);
            }
        });
    });

    //个人主页浏览记录
    self.on("addViewSum",function(userid){
        $.ajax({
            url: dfs.apiUserUrl+"/dfs_add_user_viewsum",
            async: true,
            type: "get",
            data:{
              userid: userid
            },
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.trigger("viewsumChange",data);
            }
        });
    });

    //推荐视频
    self.on("getRecommendList",function(recommend){
        $.ajax({
            url: dfs.apiPostUrl+"/dfs_load_reproduced_post_by_user?size=10&page=" + recommend.page + "&userid=" + recommend.doctorid,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                $(data).each(function(){
                    if(this.media == "4"){
                        this.media = "专题号";
                    }else{
                        this.media = "大夫号";
                    }
                    if(this.viewersnum >= 10000){
                        this.viewersnum = Math.floor(this.viewersnum/10000)+"w+";
                    }
                });
                //console.log(data);
                self.trigger("recommendVideoChange",data);
            }
        });
    });
}

function   formatDate(now)   {
    var   year=now.getYear()+1900;
    var   month=now.getMonth()+1;
    var   date=now.getDate();
    var   hour=now.getHours();
    var   minute=now.getMinutes();
    //var   second=now.getSeconds();
    return   year+"-"+month+"-"+date+"   "+hour+":"+minute;
}

function strstr(str){
    str = str.split("\n")[0];
     
    return str;           
}
function strstr1(str){
    if(str.indexOf("\n")>0){
        str = str.split("\n")[1]; 
    }else{
       return ; 
    }
    return str; 
}
