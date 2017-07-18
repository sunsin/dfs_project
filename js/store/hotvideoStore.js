function HotVideoStore(){

    riot.observable(this);
    var self = this;
    self.mesage = [];
    /*
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
*/
}