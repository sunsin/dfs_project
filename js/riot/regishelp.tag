<regishelp style="display: block;margin-bottom: 55px;" class="regishelp">
    <div class="forword" onclick="{ gohistory }">
        <div class="back"><span>{ pageTitle }</span></div>
    </div>
    
    <help-item each="{ help }"></help-item>
    <registration-item each="{ registration }"></registration-item>
    <disease class="disease">
        
        <ul class="nav nav-tabs" role="tablist">
            <li each="{ name,i in disease.name }"></li>    
        </ul>
        <div class="tab-content">
            <disease-tags each="{ tag,i in disease.tags }" role="tabpanel" class="tab-pane disease-tags"></disease-tags>
        </div>
        
    </disease>
    <style>
        
    </style>
    <script>
        var self = this;
    //路由解析
        riot.route(function(){
            var q = riot.route.query();
            self.topic = decodeURI(q.topic);
            self.update();
        });
        riot.route.stop();
        riot.route.start(true);

        var page = 0;

        if(location.search.indexOf("&") != -1){
            self.topic = self.topic || location.search.split("=")[1].split("&")[0];
        }else{
            self.topic = self.topic || location.search.split("=")[1];
        }
        $(function(){
            var search = '<a class="searchTags" href="search.html" style="padding: 10px 0;text-align: center;color: #6f6f6f;border-top: 1px solid #ccc;border-bottom: 1px solid #ccc;"><span style="padding-left: 20px;background: url(../images/H5/ic_search.png) no-repeat 0 center;background-size: 14px 13px;">搜索医生、视频</span></a>';
            if(location.href.indexOf("disease") != -1){
                $(search).insertAfter($(".forword"));
            };

            $(".disease-name").click(function(){
                $(this).find("li").addClass("active");
                $(this).siblings().find("li").removeClass("active");
            });

        })

        if(self.topic == "registration"){
            self.pageTitle = "超级挂号";
            RiotControl.trigger("getRegistrationList");
            RiotControl.on("registrationListChanged",function(data){
                self.registration = data;
                self.update();    
            });
        }else if(self.topic == "help"){
            self.pageTitle = "医疗互助";
            RiotControl.trigger("getHelpList",page);
            RiotControl.on("helpListChanged",function(data){
                self.help = data;
                
                self.update();
            });
        }else{
            self.pageTitle = "疾病查询";
            RiotControl.trigger("getDiseaseList",page);
            RiotControl.on("diseaseListChanged",function(data){
                
                self.disease = data;
                console.log(data);
                self.update();
            });
        }

        this.gohistory = function(){
            window.history.go(-1);
        };

        
    </script>
</regishelp>

<help-item class="help-item">
    <div class='cover' onclick="{ toHelp }">
        <img src="{ cover }" alt="">
    </div>
    <div class="txt">
        <div class='title' onclick="{ toHelp }">{ name }</div>
        <div class="content" onclick="{ toHelp }">{ content }</div>
        
        <div class="contentShow">详情</div>
        <div class='info' onclick="{ toHelp }">
            <div><span>{ price }</span>元起</div>
            <div>{ company }</div>
        </div> 
    </div>
    <div class="contentDetail">
        <div><img src="../images/icon/select_del.png" alt=""></div>
        { content }
    </div>
    <script>
        var self = this;
        toHelp(){
            var toHelpUrl = self.url;
            window.location.href = toHelpUrl;
        }
        $(function(){

            $(".contentShow").click(function(){
                $(this).parent().parent().find(".contentDetail").show();

            });
            $(".contentDetail").find("img").click(function(){
                $(this).parent().parent().hide();

            });
        })
    </script>
</help-item>


<registration-item class="registration-item" onclick="{ registration }">
    <div class='cover'>
        <img src="{ cover }" alt="">
    </div>
    <div class='regis-msg'>
        <div class='regis-hos'>
            { hospital }
        </div>
        <div class="regis-info">
            <span style="margin-right: 15px;">{ level }</span>
            <span>{ city }</span>
        </div>
    </div>
    
    <script>
        var self = this;
        $(function(){
            $(".regis-info").find("span").each(function(){
                var text = $(this).text();
                if(text == null || text == ""){
                    $(this).hide();
                }
            })
            
        })
        
        registration(){
            var toRegistrationUrl = self.url;
            window.location.href = toRegistrationUrl;
        }
    </script>
    <style>
        .health-item:last-child{
            padding-bottom: 60px;
        }
    </style>
</registration-item>


<li role="presentation">
    <a href="#{ i }" role="tab" data-toggle="tab">{ name.name }</a>
</li>

<disease-tags id="{ i }">
    <ul>
        <tags-item each="{ tag }"></tags-item>
    </ul>
    <script>
    </script>
</disease-tags>
<tags-item class="tags-item" onclick="{ toDiseaseShow }">
    <div tag="{ tag }">{ name }</div>
    <script>
        var self = this;
        toDiseaseShow(){
            var url = "disease.html?disease=" + self.tag + "&page=0";
            window.location.href = url;
        }
    </script>
</tags-item>


