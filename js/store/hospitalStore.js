function HospitalStore(){
        riot.observable(this);
        var self = this;
        self.hospitalVideoListChanged= [];
        self.hospitalProficientList= [];
        //hospital video
        self.on("getHospitalVideoList",function(){
            $.ajax({
                url: "http://api.daifushuo.com/api/tools/dfs_room_list",
                async: true,
                type: "get",
                dataType: 'json',
                contentType:"application/json;charset=utf-8",
                success: function(data) {
                    self.hospitalVideoList = data;
                    self.trigger("hospitalVideoListChanged",data);
                }
            });
        });

        //hospital information
        self.on("getHospitalInformation",function(hos){
            $.ajax({
                url: "http://api.daifushuo.com:80/api/ousers/"+hos.hospitalid+"?access_token=" +hos.token,
                async: true,
                type: "get",
                dataType: 'json',
                contentType:"application/json;charset=utf-8",
                success: function(data) {
                    self.hospitalVideoList = data;
                    self.trigger("hospitalInformationChanged",data);
                }
            });
        });

        //hospital room
        self.on("getHospitalRoomList",function(hospitalid){
            var data = {
                "hospitalid":hospitalid
            };
            $.post("http://api.daifushuo.com:80/api/ousers/dfs_load_rooms_by_hospitalid",data,function(data){
                //console.log(data);
                self.trigger("hospitalRoomListChanged",data);
            })

        });

    //医院的科室用户
    self.on("getRoomList",function(roomid){
        var data={
            "roomid":roomid,
            "size": "10"
        }
        $.post("http://api.daifushuo.com:80/api/ousers/dfs_load_posts_by_roomid",data,function(data){
            //console.log(data);
            self.trigger("roomVideoChanged",data);
        })
    });
    //科室的医生用户
    self.on("getRoomDoctorsList",function(roomid){
        var data={
            "roomid":roomid,
            "size": "10"
        }
        $.post("http://api.daifushuo.com:80/api/ousers/dfs_load_doctors_by_roomid",data,function(data){
            self.trigger("roomDoctorsChanged",data);
        })
    });
}



