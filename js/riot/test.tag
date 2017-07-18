<test class="nav">
    <navList></navList>
        <!-- Tab panes -->
    <div class="tab-content">
    <div role="tabpanel" class="tab-pane active" id="kqk">
        <ul label="口腔科" >
        <li value="口腔科 口腔内科 牙周科 口腔修复科 口腔种植科 牙体牙髓科 口腔正畸科 颌面外科 正颌科 唇颚裂科 颌面创伤科 预防口腔科 儿童口腔科">口腔科</li>
        <li value="口腔内科">口腔内科</li>
        <li value="牙周科">牙周科</li>
        <li value="口腔修复科">口腔修复科</li>
        <li value="口腔种植科">口腔种植科</li>
        <li value="牙体牙髓科">牙体牙髓科</li>
        <li value="口腔正畸科">牙体正畸科</li>
        <li value="颌面外科">颌面外科</li>
        <li value="正颌科">正颌科</li>
        <li value="唇颚裂科">唇颚裂科</li>
        <li value="颌面创伤科">颌面创伤科</li>
        <li value="预防口腔科">预防口腔科</li>
        <li value="儿童口腔科">儿童口腔科</li>
        </ul>
    </div>
    <div role="tabpanel" class="tab-pane" id="yk">
        <ul label="眼科" >
        <li value="眼科">眼科</li>
        </ul>
    </div>
    <div role="tabpanel" class="tab-pane" id="erh">
        <ul label="耳鼻喉头颈外科" >
        <li value="耳鼻喉头颈外科">耳鼻喉头颈外科</li>
        </ul>
    </div>
    <div role="tabpanel" class="tab-pane" id="wk">
        <ul label="外科" >
        <li value="外科 普通外科 心脏外科 泌尿外科 烧伤整形外科 胸外科 胃肠外科 骨科 骨科创伤 肝胆外科 胆胰外科 美容整形科 脊柱外科 关节外科 血管外科 小儿外科 运动医学科 手外科 足裸外科 肛肠外科">外科</li>
        <li value="普通外科">普通外科</li>
        <li value="心脏外科">神经外科</li>
        <li value="心脏外科">心脏外科</li>
        <li value="泌尿外科">泌尿外科</li>
        <li value="烧伤整形外科">烧伤整形外科</li>
        <li value="胸外科">胸外科</li>
        <li value="胃肠外科">胃肠外科</li>
        <li value="骨科">骨科</li>
        <li value="骨科创伤">骨科创伤</li>
        <li value="肝胆外科">肝胆外科</li>
        <li value="胆胰外科">胆胰外科</li>
        <li value="美容整形科">美容整形科</li>
        <li value="脊柱外科">脊柱外科</li>
        <li value="关节外科">关节外科</li>
        <li value="血管外科">血管外科</li>
        <li value="小儿外科">小儿外科</li>
        <li value="运动医学科">运动医学科</li>
        <li value="手外科">手外科</li>
        <li value="足裸外科">足裸外科</li>
        <li value="肛肠外科">肛肠外科</li>
        </ul>
    </div>
    </div>
    <ko></ko>
</test>

    <!--导航-->
<navList>
    <ul class="line">
        <nav-item each={ navLists }></nav-item>
    </ul>
    <script>
    var self = this;
    RiotControl.trigger("getTopicList",self.parent.page?self.parent.page:0);
    RiotControl.on("topicListChanged",function(data){
        self.navLists = data;
        //console.log(data);
        self.update();
    });

    </script>
</navList>

<nav-item class="ko" onclick="{ topic }">
    <li>{ name }</li>
    <script>
    var self = this;
    this.topic = function(){
        self.parent.parent.topic = self.description;
        self.parent.parent.update();
    }
    </script>
</nav-item>

<ko>
    <div onclick="{ dw }">hijikolp</div>
    <script>
        var self = this;

        this.dw = function(){
            console.log(self.parent.topic);
        }
    </script>
</ko>

