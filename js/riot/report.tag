<report class='report'>
    <div class="forword" onclick="{ gohistory }" style="background: #fff url(../../images/icon/back.png) no-repeat 10px center;background-size: 20px 15px">
        <div class="back"><span>举报内容问题</span></div>
    </div>
    <div class="title">选择举报原因</div>
    <div class="report-reason-box">
        <div class='report-reason-item'>广告</div>
        <div class='report-reason-item'>色情低俗</div>
        <div class='report-reason-item'>内容错误</div>
        <div class='report-reason-item'>内容疑似抄袭</div>
        <div class='report-reason-item'>视频质量查,我要吐槽</div>
    </div>
    <input placeholder="请输入您的QQ、邮箱或手机号（必填）" class="contact">
    <div class='submit'>提交</div>
    <style>
        .contact{
            width: 80%;
            margin: 0  0 20px 10%;
            height: 40px;
            line-height: 40px;
            font-size: 1.4rem;
            padding-left: 10px;
            color: #6f6f6f;
            background: #f3f3f3;
            border-radius: 5px;
        }
    </style>
    <script>
        var self = this;
        riot.route( function(){
            var q = riot.route.query();
            self.postid = q.postid;
            self.update();
        });
        riot.route.stop();
        riot.route.start(true);
        this.gohistory = function(){
            window.history.go(-1);
        };

        $(function(){
            $(".report-reason-item").click(function(){
                $(this).toggleClass("report-select");
                $(this).siblings().removeClass("report-select");
                var reason = $(this).text();
            });

            $(".submit").click(function(){
                var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));
                var select = document.getElementsByClassName("report-select");
                var content = $(select).text();
                var contact = $(".contact").val();
                //console.log(contact);
                if(contact != ""){
                    var report_data = {
                        content : content,
                        type: "1",
                        contact: contact,
                        postid : self.postid,
                        userid : dfs_cookie.userId
                    };
                    var issueUrl = "http://api.daifushuo.com:80/api/oissues?access_token="+dfs_cookie.id;
                    $.post(issueUrl,report_data,function(data){
                        //console.log(data);
                        //
                    })
                    window.history.go(-1);
                }else{
                    //console.log("ko");
                }


            })
        })
    </script>
</report>