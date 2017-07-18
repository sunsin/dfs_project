function videoCommentNumberStore(){
    riot.observable(this);
    var self = this;
    self.lis = [];

    self.on("getVideoCommentNumber",function(video){
        $.ajax({
            url: dfs.apiPostUrl + "dfs_load_post_by_id?postid=" + video,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.lis = data;
                self.trigger("videoCommentNumberChanged",self.lis);
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {

            }
        });

    });
}