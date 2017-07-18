function DoctorDescriptionStore(){

    riot.observable(this);
    var self = this;
    self.mesage = [];
    /*
    self.on("getDoctorMessage",function(userid){
        $.ajax({
            url: dfs.apiUserUrl + "/dfs_load_user_info?userid=" + userid,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.message = data;
                //console.log(data);
                self.trigger("doctorMessage",self.message);
            }
        });

    });
*/
}