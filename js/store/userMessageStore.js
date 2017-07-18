function UserMessageStore(){
    riot.observable(this);
    var self = this;

    self.on("getuserMessage",function(data) {
        $.ajax({
            url: dfs.apiUserUrl,
            async: true,
            type: "get",
            dataType: 'json',
            data:data,
            contentType: "application/json;charset=utf-8",
            success: function (data) {
                console.log("DS");
                self.trigger("userMessageChanged",data);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {

            }
        });
    });
}