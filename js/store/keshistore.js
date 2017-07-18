function KeshiStore(){
    riot.observable(this);
    var self = this;
    self.ilist = [];

    self.on("getKeshiList",function(){
        $.ajax({
            url: "http://api.daifushuo.com/api/tools/dfs_room_list",
            async: true,
            type: "get",
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                self.ilist = data;
                self.trigger("keshiListChanged",self.ilist);
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {

            }
        });

    });
}