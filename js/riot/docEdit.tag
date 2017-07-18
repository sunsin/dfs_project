<docEdit class="docEdit">
        <div class="edit">
                <div id="headpng">
                        <span>头像</span>
                        <span><img src='' id="docheadimage" /></span>
                </div>
                <div id="nickname">
                        <span>姓名</span>
                        <input placeholder="昵称" />
                </div>
                <div id="sex">
                        <span>性别</span>
                        <span class="sexChoose"></span>

                </div>
                <div class="sex-list" style="display:none;">
                        <div>男</div>
                        <div>女</div>
                </div>
                <div id="hospital">
                        <span>医院</span>
                        <input placeholder="请输入医院全称">

                </div>
                <div href="zhiwei.html" id="zhiwei">
                        <span>职位</span>
                        <span></span>
                </div>
                <div id="classifical">
                        <span>科室</span>
                        <span></span>
                </div>
                <div id="desc">
                        <span>简介</span>
                        <textarea></textarea>
                </div>
                <a href="mine.html" class="save">保存</a>
        </div>
        <zhiwei></zhiwei>
        <keshi></keshi>
        <script>
                var self = this;
                self.keshi=[];
                self.zhiwei = [];
                $(function(){
                        $("#sex").click(function(){
                                console.log('DE');
                                $(".sex-list").show();
                        });
                        $(".sex-list").find("div").click(function(){
                                console.log($(this).text());
                                $(".sexChoose").text($(this).text());
                                $(".sex-list").hide();
                        });
                        $("#zhiwei").click(function(){
                                $(".zhiwei").show();
                                $(".edit").hide();
                                $("body").css("background","#fff");
                        });
                        $("#classifical").click(function(){
                                $(".keshi").show();
                                $(".edit").hide();
                                $("body").css("background","#fff");
                        });
                });
        </script>
</docEdit>





