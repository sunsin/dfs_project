function HaveitStore(){
    riot.observable(this);
    var self = this;

    self.on("haveit",function(data){
        $.ajax({
            url: dfs.apiFriendUrl + "/haveit?access_token=" + data.access_token,
            async: true,
            type: "post",
            data: data.focus,
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.trigger("haveitChanged",data);
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {

            }
        });

    });
}