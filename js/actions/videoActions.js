var vactions = riotux.Actions({
  get_videos: trigger_get_videos,
  haveit: trigger_haveit
})

/*
  注意： actions 里可以进行异步调用， 获得结果后再 dispatch 对应的 Mutations
   (因为Mutations 必须是同步的！！！)
 */
function trigger_get_videos( store, userid ) {
  // here you can call async ajax
  
	$.ajax({
	            url: dfs.apiPostUrl + "/dfs_load_posts_by_user?userid=" + userid,
	            async: true,
	            type: "get",
	            dataType: 'json',
	            contentType:"application/json;charset=utf-8",
	            success: function(data) {
	                console.log(data);
	                store.dispatch('get_video_byuser', data);
	            }
	});
}

function trigger_haveit( store, data ) {
  // here you can call async ajax
          $.ajax({
            url: dfs.apiFriendUrl + "/haveit?access_token=" + data.access_token,
            async: true,
            type: "post",
            data: data.focus,
            dataType: 'json',
            contentType:"application/json;charset=utf-8",
            success: function(data) {
                store.dispatch('haveit', data);
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {

            }
        });
}
