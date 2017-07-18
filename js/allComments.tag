<allComments class="commentList">
    <all-item each="{ allComments }" item={ this }></all-item>
    <div class="comment-footer">
        <div class="discuss">
            <input type="text" placeholder="输入评论" autofocus />
            <button>发送</button>
        </div>

    </div>
    <script>
        var self = this;
        this.on("before-mount",function(){
            Test();
        });
    //路由
        riot.route( function(){
            var q = riot.route.query();
            self.postid = q.postid;
            //console.log(self.postid);
            self.update();
        });
        riot.route.stop();
        riot.route.start(true);

        self.postid = self.postid || location.search.split("postid=")[1];

    //获取评论列表
        self.allComments = [];

        RiotControl.trigger("getAllCommentsList",self.postid);
        RiotControl.on("allCommentsChanged",function(data){

            self.allComments = data;
            //console.log(data);
            self.update();
        });

        // 用户添加评论
        $(function(){
            var url = window.location.search;
            var arr = url.split("=");
            var postid = arr[1];

            dfs_cookie = jQuery.parseJSON($.cookie('dfs_token'));
            //console.log(dfs_cookie);
            var userid = dfs_cookie.userId;
            var accessToken = dfs_cookie.id;

            $(".discuss").find("button").click(function(){

                var discussVal = $(".discuss").find("input").val();

                var discussVal = {
                    "content": discussVal,
                    "postid" : postid,
                    "userid" : userid
                };
                //console.log(discussVal);
                $.post("http://api.daifushuo.com:80/api/ocomments?access_token="+accessToken,discussVal,function(data){
                    //console.log(data);

                });
                $.get("http://api.daifushuo.com:80/api/ousers/"+ userid +"?access_token="+accessToken,discussVal,function(data){
                    var userMessage ;
                    userMessage = data;
    var discussVal = $(".discuss").find("input").val();
                    if(discussVal != null){
                        var discussBox = "<all-item><div class='commentItem'><img src='"+ userMessage.avatar +"' class='commentUserImg'><div><div class='line1'><div class='nickname'>"+ userMessage.nickname +"</div><div class='create'>"+ "刚刚" +"</div></div><div class='line2'><span class='content'>" + discussVal + "</span></div></div></div></all-item>";
                        $(".commentList").prepend(discussBox);
                    };
    $("input").val("").focus();
                });

                //$(".discuss").find("input").val() = "";


            });


        });

    </script>
</allComments>

<all-item>
    <div class="commentItem">
        <div>
            <img src='{ user.avatar[0] }'>
        </div>
        <div>
            <div class="line1">
                <div class='nickname'>{ user.nickname }</div>
                <div class='create'>{ created }</div>
            </div>
            <div class='line2'>
                <span class='replyTitle'> { con1 }<span>{ con }</span> </span>
                <span class='content'>{ content }</span>
            </div>
        </div>
        <div class="praise" onclick="{ praise }" sum="{ ilike }">
            { ilike }
        </div>
    </div>
    <style>
    .replyTitle{
            font-size: 1.2rem;
            color: #999;
        }
        .replyTitle span{
            color: #0076EF;
        }
    .commentItem{
        padding-bottom: 10px;
    }
    .commentItem .line1{
        padding-bottom: 5px;
    }
    .commentItem >div:nth-child(2) .line1 .create{
        font-size: 1rem;
        color: #999;
    }
    .commentItem{
        position: relative;
    }
    .commentItem .praise{
        position: absolute;
        top: 0px;
        right: 10px;
        padding: 3px 0 3px 20px;
        background: url(../images/icon/praise.png) no-repeat 0 center;
        background-size: 15px 15px;
        font-size: 1.2rem;
        color: #434343;
    }

    .commentItem .praise img{
        width: 19px;
        height: 19px;
        border-radius: 0px;
    }
    </style>
    <script>
        var self = this;
        this.ilike = this.ilike || 0;
        if(this.reply_comment != null){
            this.con1 = "回复：";
            this.con =  this.reply_comment.nickname;
        }

        var num = 1;
        this.praise = function(){
            $(this).addClass("praiseCancle");
            var praises =  Number(self.ilike)+ 1;
            $(this).text(praises);
            var parise = {
                commentid : self._id,
                like : "true"
            };
            var pariseDel = {
                commentid : self._id,
                like : "false"
            };

            var url = "http://api.daifushuo.com:80/api/ocomments/dfs_like_comment?access_token=Mx8pxgRoOjl8i7VErnrrILMLwtR6XDppLIDO08HV0r5ChAnxaImqsDv8yCXeZ0AS";
            if(num%2 ==1){
                $.post(url,parise,function(data){
                    //console.log(data);
                });
                num++;
            }else{
                $.post(url,pariseDel,function(data){
                    //console.log(data);
                });
                num++;
            }
        }
    $(function(){
        var num = 1;
        $(".praise").click(function(){
            var sum = Number($(this).attr("sum"));
            var sumAdd = sum + 1;
            var sumDel = sum - 1;
            if(num%2 == 1){
                $(this).text(sumAdd);
                num++;
            }else{
                if(Number($(this).attr("sum")) > sum){
                    $(this).text(sumDel);
                }else{
                    $(this).text(sum);
                }

                num--;
            }
        })
    })

    </script>
</all-item>
