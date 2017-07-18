<zhiwei class="zhiwei">
    <div class='top'>请选择你的职位</div>
    <div class="main">
        <div class="zhiwei-list">
            <div>医师</div>
            <ul class="list-group" style="display: none;">
                <li value="医学生" class="list-group-item">医学生</li>
                <li value="住院医师" class="list-group-item">住院医师</li>
                <li value="主治医师" class="list-group-item">主治医师</li>
                <li value="副主任医师" class="list-group-item">副主任医师</li>
                <li value="主任医师" class="list-group-item">主任医师</li>
            </ul>
        </div>
        <div class="zhiwei-list">
            <div>教研职称</div>
            <ul class="list-group" style="display: none;">

                <li value="讲师" class="list-group-item">讲师</li>
                <li value="副教授" class="list-group-item">副教授</li>
                <li value="教授" class="list-group-item">教授</li>
                <li value="副研究员" class="list-group-item">副研究员</li>
                <li value="研究员" class="list-group-item">研究员</li>
            </ul>
        </div>
        <div class="zhiwei-list">
            <div>药师</div>
            <ul class="list-group" style="display: none;">
                <li value="药师" class="list-group-item">药师</li>
                <li value="主管药师" class="list-group-item">主管药师</li>
                <li value="副主任药师" class="list-group-item">副主任药师</li>
                <li value="主任药师" class="list-group-item">主任药师</li>
            </ul>
        </div>
        <div class="zhiwei-list">
            <div>护师</div>
            <ul class="list-group" style="display: none;">
                <li value="护士" class="list-group-item" >护士</li>
                <li value="护师" class="list-group-item">护师</li>
                <li value="主管护师" class="list-group-item">主管护师</li>
                <li value="副主任护师" class="list-group-item">副主任护师</li>
                <li value="主任护师" class="list-group-item">主任护师</li>
            </ul>
        </div>
        <div class="zhiwei-list">
            <div>技师</div>
            <ul class="list-group" style="display: none;">
                <li value="技师" class="list-group-item">技师</li>
                <li value="主管技师" class="list-group-item">主管技师</li>
                <li value="副主任技师" class="list-group-item">副主任技师</li>
                <li value="主任技师" class="list-group-item">主任技师</li>
            </ul>
        </div>
    </div>
    <button class="complete">完成</button>
    <script>
    var self = this;

    $(function(){
        $(".zhiwei").find("ul").children("li").each(function(){
            $(this).click(function(){
                $(".zhiwei").find("ul").children("li").removeClass("zw");
                $(this).toggleClass("zw");
                var zhiwei = $(this).text();
                console.log(zhiwei);
                $("#zhiwei").children("span").eq(1).text(zhiwei);

            });
        });
        $(".zhiwei-list").children("div").click(function(){
            $(this).siblings().toggle();
        });
        $("button").click(function(){
            $(".zhiwei").hide();
            $(".edit").show();
            $("body").css("background","#ccc");
        });
    });

    </script>
</zhiwei>