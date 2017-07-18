
function DoctorListStore(){
    riot.observable(this);
    var self = this;
    self.ilist = [];
    
    self.on("getDoctorList",function(page){
        $.ajax({
            url: dfs.apiUserUrl+"/recommend_doctor_list?/size=10&page=" + page ,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.dfs_doctors = data;
                //console.log(data);
                self.trigger("doctorListShow",self.dfs_doctors);
            }
        });
    });

    self.on("getColumnList",function(page){
        $.ajax({
            url: dfs.apiUserUrl+"/recommend_pgc_list?/size=10&page=" + page ,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.dfs_doctors = data;
                //console.log(data);
                self.trigger("columnListShow",self.dfs_doctors);
            }
        });
    });

}