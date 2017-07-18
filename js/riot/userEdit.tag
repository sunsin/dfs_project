<userEdit class="userEdit">
    <div>
        <div id="headpng">
            <span>头像</span>
            <span><a href="img.html"><img src='' id="dfs_user_headimg" /></a></span>
        </div>
        <div id="username">
            <span>昵称</span>
            <input type="text" />
        </div>
        <div id="desc">
            <span>简介</span>
            <textarea></textarea>
        </div>
        <a class="save" onclick="{ save }">保存</a>
    </div>
    <script>
        var self = this;
    //cookie,得到用户的userId以及access_token
        var dfs_cookie = $.cookie('dfs_token');
        console.log(dfs_cookie);

    //对用户信息进行预置
    var getPersonalMessagePost = dfs.apiUserUrl + "/" + dfs_cookie.userId + "?access_token=" + dfs_cookie.id;
    $.get(getPersonalMessagePost,function(data){
        $("#dfs_user_headimg").attr("src",data.avatar[0]);
        $("#username").find("input").attr("placeholder",data.nickname);
        $("#desc").find("textarea").attr("placeholder",data.profile);
    });

        var userid = dfs_cookie.userId;
        var accessToken = dfs_cookie.id;
    //上传用户信息
        this.save = function(){
          var nickname = $("input").val();
          var profile = $("textarea").val();
          var data={
              "nickname": nickname,
              "prifile": profile
          };
          console.log("data");
            $.get(getPersonalMessagePost,data,function(){
                console.log("yes");
            })
        }

    /*
          $.ajax({
              url: dfs.apiUserUrl + "/" + userid+"?access_token="+accessToken,
              async: true,
              type: "put",
              data: data,
              dataType: 'json',
              contentType:"application/json;charset=utf-8",
              success: function(data) {

              }
          });

          var url = "mine.html";
          window.location.href = url;
        };
*/
    </script>
</userEdit>
