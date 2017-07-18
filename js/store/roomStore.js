function RoomStore(){
    riot.observable(this);
    var self = this;
    self.lis = [];

    self.on("getRoomVideoList",function(room){
        $.ajax({
            url: dfs.apiPostUrl + "/dfs_load_posts_by_room?room=" + room,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.lis = data;
                self.trigger("roomVideoListChanged",self.lis);
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {

            }
        });

    });



}