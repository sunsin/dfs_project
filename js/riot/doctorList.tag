<doctor-list style="display: block;margin-bottom: 55px;">
    <!--
    <div class="searchAddr">
        <input type="text" placeholder="搜索医生、医院" class="search" id="search" />
    </div>
    -->
    <div class="forword" onclick="{ gohistory }">
        <div class="back"><span>{ topic }</span></div>
    </div>
    <doctor-item each="{ dfs_doctors }" vitem="{ this }"></doctor-item>

<script>
    var self = this;
    if(location.search.indexOf("&") != -1){
        self.doctor = location.search.split("=")[1].split("&")[0];
    }else{
        self.doctor = location.search.split("=")[1];
    };

    if(self.doctor == "doctor"){
        self.topic = "入驻医生列表";
    }else{
        self.topic="精彩专栏";
    }
    self.dfs_doctors = [];
    var page = 0;

    if(location.search.indexOf("doctor") != -1){
        RiotControl.trigger("getDoctorList",page);
        RiotControl.on("doctorListShow",function(data){
            //console.log(data);
            self.dfs_doctors = data;
            self.update();
        });
    }else{
        RiotControl.trigger("getColumnList",page);
        RiotControl.on("columnListShow",function(data){
            //console.log(data);
            self.dfs_doctors = data;
            self.update();
        });
    }
    
    
    
    this.gohistory = function(){
        window.history.go(-1);
    };
</script>
</doctor-list>

<doctor-item>
    <a class='dfs_doctor' href="{ doctorlink }" userid="{ _id }">
        <div class="doc-img">
            <img src="{ avatar[0] }" />
        </div>
        <div class='dfs_doctor_list' style="height: 50px;display: table;">
            <div class='name' style="display: table-row;vertical-align: middle;">{ nickname }</div>
            <div style="display: table-row;vertical-align: middle;">
                <span class='addr'>{ hospital }</span>
                <span class='classifical'>{ room }</span>
            </div>
            
        </div>
    </a>
    <script>
        var self = this;
        self.data = opts.vitem;
        self.doctorlink = "doctorDetail.html?doctorid=" + self.data._id;
    </script>
</doctor-item>

