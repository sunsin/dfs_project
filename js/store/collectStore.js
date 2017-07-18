function CollectStore(){
    riot.observable(this);
    var self = this;

    //mine
    self.on("getMyselfInfo",function(dfs_cookie){
        $.ajax({
            url: dfs.apiUserUrl+"/"+dfs_cookie.userId+"?access_token="+dfs_cookie.id,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.trigger("myselfInfoChanged",data);
            }
        });
    });
    //userMetadata
    self.on("getUserMetadata",function(userid){
        $.post("http://api.daifushuo.com:80/api/tools/user_metadata",{"userid":userid},function(data){
            self.trigger("userMetadataChanged",data);
        })
    })
    //dortor-fans
    self.on("getDoctorFansList",function(ew){
        $.ajax({
            url: "http://api.daifushuo.com:80/api/ofriends/followers_info?userid="+ew.userid+"&page=0&size=15&access_token="+ew.token,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.trigger("doctorFansChanged",data);
            }
        });
    });
    //collect
    self.on("getCollectList",function(collectMsg){
        var collect = {
            "userid" : collectMsg.userid
        };
        $.post("http://api.daifushuo.com:80/api/obookmarks/dfs_load_bookmarks_by_user_id?access_token="+collectMsg.accessToken,collect,function(data){
            $(data).each(function(){
                if(this.media == "4"){
                    this.media = "专题号";
                }else{
                    this.media = "大夫号";
                }
            });
            self.trigger("collectListChanged",data);
        });

    });
    //history
    self.on("getHistoryList",function(historyMsg){
        $.get("http://api.daifushuo.com:80/api/viewlog/dfs_find_viewlog_by_user_id?userid="+historyMsg.userid+"&access_token="+historyMsg.accessToken,function(data){
            $(data).each(function(){
                if(this.media == "4"){
                    this.media = "专题号";
                }else{
                    this.media = "大夫号";
                }
            });
            self.trigger("historyListChanged",data);
        })
    });

    //focus
    self.on("getFocusDoctorList",function(dfs_cookie){
        var url = "http://api.daifushuo.com:80/api/ofriends/followees_info?&access_token="+dfs_cookie.id;
        
        $.ajax({
            url: url,
            async: true,
            type: "get",
            dataType: 'json',
            data:{
                "userid": dfs_cookie.userId
            },
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.dfs_doctors = data;
/*
                $(data).each(function(){
                    let self = this;
                    self.dfs_doctors = [];

                    var doctorid = this.split("#")[0];
                    var thisData = getDoctorInfo(doctorid);

                    self.dfs_doctors.push(thisData);
                });

                */
                self.trigger("doctorFocusList",self.dfs_doctors);
            }
        });
    });
    /*
    self.on("getFocusDoctorList",function(dfs_cookie){
        $.get("http://api.daifushuo.com:80/api/ofriends/followees_info?&access_token="+dfs_cookie.id,{"userid":dfs_cookie.userId},function(data){
            
            self.trigger("doctorFocusList",data);
        })
    });
    */
}
function getDoctorInfo(doctorid){
    $.ajax({
        url: dfs.apiUserUrl + "/dfs_load_user_info?userid=" + doctorid,
        async: true,
        type: "get",
        dataType: 'json',
        contentType:"application/json;charset=utf-8",
        success: function(data) {
            //console.log(data);
            return data
        }
    });
    
}


