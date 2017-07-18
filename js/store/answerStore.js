function AnswerStore(){

    riot.observable(this);
    var self = this;

//answerVideo
    self.on("getAnswerVideoList",function(info){
        info.doctorid = info.doctorid || null;
        var url = "http://api.daifushuo.com:80/api/oquestion/dfs_get_question?access_token=" + info.token;
        var postData = {
            "userid":info.userid,
            "type": info.type,
            "doctorid": info.doctorid,
            "personal":info.personal || "false"
        };
        $.get(url,postData,function(data){
            // console.log(data);
            
            $(data).each(function(){
                let self = this;
                self.pics = [];
                self.answerpic = [];
                var timestamp = Date.parse(new Date(this.updated))
                var time1 = new  Date(timestamp);
                var timecreated = Date.parse(new Date(this.created))
                var time2 = new  Date(timecreated);

                if(self.updated != "undefined"){
                    this.updated = formatDate(time1);
                }
                if(self.updated != null){
                    self.updated = formatDate(time1);
                }

                if(self.created != "undefined"){
                    this.created = formatDate(time2);
                }
                if(self.created != null){
                    self.created = formatDate(time2);
                }     
                

                for(var i=0;i < self.pictures.length;i++){
                    var tag = {"pic": self.pictures[i] };
                    self.pics.push(tag);
                }
                
                /*
                $(self.pictures).each(function(){
                    var tag = {"pic": this};
                });
                */
                
                if(self.answer_pictures){
                   for(var j=0;j<self.answer_pictures.length;j++){
                        let pic = {"pic":self.answer_pictures[j]};
                        self.answerpic.push(pic);
                    } 
                }else{

                }
                
                

            })

            self.video = data;
            //console.log(data);
            self.trigger("answerVideoListChanged",self.video);
        })


    });

//canask_doctor
    self.on("getCanAskDoctorList",function(){
        $.ajax({
            url: dfs.apiUserUrl+"/dfs_get_answer_doctors",
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                
                self.trigger("canAskDoctorListChanged",data);
            },
            error: function(data){

            }
        })
    })

//orderDetail
    self.on("getOrderList",function(infos){
        var url = "http://api.daifushuo.com:80/api/oquestion/dfs_payforanswer?access_token=" + infos.cookie;
        $.post(url,infos.info,function(data){
            self.trigger("orderListChanged",data);
        });

    });

//search ask_answer_video
    self.on("getAskAnswerList",function(infos){
        var url = "http://api.daifushuo.com:80/api/search/load_questions?access_token=" + infos.token;
        $.post(url,infos.info,function(data){
            $(data).each(function(){
                let self = this;
                self.pics = [];
                self.answerpic = [];
                var timestamp = Date.parse(new Date(this.updated))
                var time1 = new  Date(timestamp);
                var timecreated = Date.parse(new Date(this.created))
                var time2 = new  Date(timecreated);

                if(self.updated != "undefined"){
                    this.updated = formatDate(time1);
                }
                if(self.updated != null){
                    self.updated = formatDate(time1);
                }

                if(self.created != "undefined"){
                    this.created = formatDate(time2);
                }
                if(self.created != null){
                    self.created = formatDate(time2);
                }     
                

                for(var i=0;i < self.pictures.length;i++){
                    var tag = {"pic": self.pictures[i] };
                    self.pics.push(tag);
                }
                
                /*
                $(self.pictures).each(function(){
                    var tag = {"pic": this};
                });
                */
                if(self.answer_pictures){
                   for(var j=0;j<self.answer_pictures.length;j++){
                        let pic = {"pic":self.answer_pictures[j]};
                        self.answerpic.push(pic);
                    } 
                }else{

                }
                
                

            })
            self.trigger("askAnswerListChanged",data);
        });

    });
     


//get video
    self.on("getPayVideoList",function(infos){
        var url = "http://api.daifushuo.com:80/api/oquestion/dfs_get_question_video";

        $.ajax({
            url: url,
            async: true,
            type: "get",
            dataType: 'json',
            data: infos,
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                $(data).each(function(){
                    var timestamp = Date.parse(new Date(this.created))
                    var time1 = new  Date(timestamp);
                    this.created = formatDate(time1);
                });
                
                self.trigger("payVideoListChanged",data);
            },
            error: function(data){

            }
        })

        
    })

//userinfo
    self.on("getUserInformation",function(userinfo){
        $.ajax({
            url: dfs.apiUserUrl+"/"+userinfo,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.trigger("userInformationChanged",data);     
            }
        });
        
    })

    //get_wx_config
    self.on("getWxConfig",function(userinfo){
        $.ajax({
            url: "http://api.daifushuo.com/qn/get_wx_config",
            async: true,
            type: "get",
            dataType: 'json',
            data:{
                url: userinfo
            },
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.trigger("wxConfigChanged",data);     
            }
        });
        
    });

    //wallet
    self.on("getMyWalletInfomationList",function(userid){
        $.ajax({
            url: dfs.apiUserUrl+"/dfs_get_cash?userid=" + userid,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                
                self.trigger("myWalletInfomationChanged",data);
            },
            error: function(data){

            }
        })
    })
}

function   formatDate(now)   {
    var   year=now.getYear()+1900;
    var   month=now.getMonth()+1;
    var   date=now.getDate();
    var   hour=now.getHours();
    var   minute=now.getMinutes();
    //var   second=now.getSeconds();
    return   year+"-"+month+"-"+date+"  "+hour+":"+minute;
}


