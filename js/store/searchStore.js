function SearchStore(){

    riot.observable(this);
    var self = this;
    self.mesage = [];
    //more-video-search
    self.on("getSearchList",function(message){
        var search = {
            "query": message.query,
            "page": message.page,
            "size":"10"
        };
        $.post(dfs.apiSearchUrl+"/dfs_search_peopleandpost",search,function(data){
            self.trigger("searchChanged",data);
        })

    });

    self.on("getDiseaseVideoList",function(message){
        var search = {
            "query": message.query,
            "page": message.page,
            "size":"10"
        };
        $.post("http://api.daifushuo.com:80/api/search/load_topic_posts",search,function(data){
            self.trigger("diseaseListChanged",data);
        })

    });
}