function AllCommentStore(){
    riot.observable(this);

    var self = this;
    self.list = [];
//获取评论
    self.on("getAllCommentsList",function(postid){
        $.ajax({
            url: dfs.apiPostUrl + "/dfs_load_post_by_id?postid=" + postid,
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                console.log(data);
                $(data._data.comments).each(function(){
                    var timestamp = Date.parse(new Date(this.created))
                    var time = new  Date(timestamp);
                    this.created = formatDate(time);
                });

                self.list = data._data.comments;
                //console.log(data);
                self.trigger("allCommentsChanged",self.list);
            }
        });
    });
// 回复评论
    self.on("getReplyComment",function(replyAll){

        $.post(replyAll.url,replyAll.reply,function(data){
            
            self.trigger("ReplyCommentChanged",data);
        })
    });

}
//
function   formatDate(now)   {
    var   year=now.getYear()+1900;
    var   month=now.getMonth()+1;
    var   date=now.getDate();
    var   hour=now.getHours();
    var   minute=now.getMinutes();
    //var   second=now.getSeconds();
    return   year+"-"+month+"-"+date+"   "+hour+":"+minute;
}
