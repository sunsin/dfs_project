<allComments class="commentList">
    <all-item each="{ allComments }" item={ this }></all-item>
    <div class="comment-footer">
        <div class="discuss">
            <input type="text" placeholder="输入评论" autofocus onkeyup="{ editor }" />
            <button onclick="{ replyor }">发送</button>
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
        dfs_cookie = $.cookie('dfs_token');
        //评论
        editor(e) {
          this.text = e.target.value
        }
        replyor(){
            if(this.text){
                var replyText = this.text;
                var discussVal = {
                    "userid": dfs_cookie.userId,
                    "content": this.text,
                    "postid": self.postid,
                };

                var replyPostUrl = "http://api.daifushuo.com:80/api/ocomments?access_token="+dfs_cookie.id;
                $.post(replyPostUrl,discussVal,function(data){
                    //console.log(data);

                });
                    // 显示帖子评论
                var userUrl = "http://api.daifushuo.com:80/api/ousers/"+ dfs_cookie.userId +"?access_token="+dfs_cookie.id;
                $.get(userUrl,discussVal,function(data){
                    console.log(data);
                    var userMessage ;
                    userMessage = data;
                    var discussVal = $(".discuss").find("input").val();
                    if(discussVal != null){
                        var discussBox = "<all-item><div class='commentItem'><img src='"+ userMessage.avatar +"' class='commentUserImg'><div><div class='line1'><div class='nickname'>"+ userMessage.nickname +"</div><div class='create'>"+ "刚刚" +"</div></div><div class='line2'><span class='content'>" + discussVal + "</span></div></div></div></all-item>";
                        $(".commentList").prepend(discussBox);
                    };
                    $("input").val("").focus();
                });
            }
        }

    </script>
    <style>
        .replyUser{
            display: none;
            overflow: hidden;
            width: 96%;
            padding: 10px;
            /*border-bottom: 1px solid #e54d42;*/
            margin: 0 auto;
            margin-bottom: 10px;
        }
        .replyUser input{
            width: 80%;
            color: #434343;
            float: left;
            font-size: 1.4rem;
            height: 35px;
            line-height: 35px;
            /*border: none;*/
        }
        .replyUser button{
            background: #fff;
            width: 20%;
            font-size: 1.6rem;
            color: #e54d42;
            float: left;
            height: 35px;
            line-height: 35px;
            border: none;
        }
    </style>
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
                <span class="delete" style="float: right;font-size: 1.2rem;color: #ed4542;" onclick="{ delete }">{ deleteText }</span>
            </div>
        </div>
        <div class="praise" onclick="{ praise }" sum="{ ilike }">
            { ilike }
        </div>
        <div class='message' onclick="{ message }" nickname="{ user.nickname }">
            <img src='../images/playMain/Message_ic.png'>
        </div>
    </div>
    <div class="replyUser">
            <input type="text" placeholder="{ placeholder }" autofocus onkeyup="{ edit }" />
            <button onclick="{ reply }" userid="{ userid }" commentid="{ _id }" nickname="{ user.nickname }">发送</button>
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
        .message{
            position: absolute;
            right: 40px;
            top: 5px;
        }
        .message img{
            width: 15px !important;
            height: 15px !important;
        }
    </style>
    <script>
        var self = this;

        dfs_cookie = $.cookie('dfs_token') || jQuery.parseJSON(dfs.getCookie('dfs_token'));
        //console.log(dfs_cookie);

        var num = 1;
        this.ilike = this.ilike || 0;
        /*
        if(self.user.nickname != null){
            this.placeholder = "回复:" + self.user.nickname;
        }
        */
        
        if(this.reply_comment != null){
            this.con1 = "回复:";
            this.con =  this.reply_comment.nickname;
        }

        if(this.userid == dfs_cookie.userId){
            this.deleteText = "删除";
        }
        //点赞
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
        //回复已有评论
        edit(e) {
          this.text = e.target.value
        }
        reply(){
            if(this.text){
                var replyText = this.text;
                var reply = {
                    "userid": dfs_cookie.userId,
                    "content": this.text,
                    "postid": self.parent.postid,
                    "reply_comment": {
                        "nickname": self.user.nickname ,
                        "userid": self.userid,
                        "commentid": self._id
                    }
                };
                var replyCommentUrl = "http://api.daifushuo.com:80/api/ocomments/dfs_reply_comment?access_token="+dfs_cookie.id;
                var replyAll = {
                    "reply": reply,
                    "url": replyCommentUrl
                }
                RiotControl.trigger("getReplyComment",replyAll);
                RiotControl.on("ReplyCommentChanged",function(data){
                    //console.log(data);
                    self.update();
                });


                var userUrl = "http://api.daifushuo.com:80/api/ousers/"+ dfs_cookie.userId +"?access_token="+dfs_cookie.id;
                $.get(userUrl,function(data){
                    var userMessage ;
                    userMessage = data;
                    var discussBox = "<all-item><div class='commentItem'><img src='"+ userMessage.avatar +"' class='commentUserImg'><div><div class='line1'><div class='nickname'>"+ userMessage.nickname +"</div><div class='create'>"+ "刚刚" +"</div></div><div class='line2'><sapn style='color: #999'>回复:</span><span class='content'>" + replyText + "</span></div></div></div></all-item>";
                        $(".commentList").prepend(discussBox);
                        $(".replyUser").hide();
                });
            }
        }
//删除评论
        this.delete = function(){
            var deleteUrl = "http://api.daifushuo.com:80/api/ocomments/" + this._id + "?access_token=" + dfs_cookie.id;
            $.ajax({
                    url: deleteUrl,
                    type: 'DELETE',
                    success: function(data){
                        //alert(data);
                    }
            });
        }
        //回复已有评论

    $(function(){
        var postid = location.search.split("postid=")[1].split("&")[0];

        dfs_cookie = $.cookie('dfs_token');
        //console.log(dfs_cookie);
        var userid = dfs_cookie.userId;
        var accessToken = dfs_cookie.id;


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
        });

        $(".message").addEvent("click",function(){
            $(this).parent().parent().find(".replyUser").show();
            var placeholder = "回复："+ $(this).attr("nickname");
            $(this).parent().parent().find(".replyUser").find("input").attr("placeholder",placeholder);
        })

        $(".replyUser").find("button").addEvent("click",function(){
            $(this).parent().find("input").focus();
        })

        $(".delete").addEvent("click",function(){
            $(this).parent().parent().parent().hide();
        })
    })


    </script>
</all-item>
