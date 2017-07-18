<focus class="focusList">
    <focus-item each="{ doctorlist }"></focus-item>
    <script>
        var self = this;

        self.focusList = [];
        
        var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));

        RiotControl.trigger("getFocusDoctorList",dfs_cookie);
        RiotControl.on("doctorFocusList",function(data){
            
            //console.log(data);
            if(data == null){
                var nodata = "<div class='nodata'><div>暂无关注</div></div>";
                $(".focusList").append(nodata);
            }else if(data.length < 1){
                var nodata = "<div class='nodata'><div>暂无关注</div></div>";
                $(".focusList").append(nodata);
            }else{
                self.doctorlist = data;
            }
            self.doctorlist = data;
            self.update();

        });

        
    
    </script>
</focus>
<focus-item>
    <a href="{ doctorlink }">
        <img src={ avatar[0] }>
        <div>
            <div class='nickname'>{ nickname }</div>
            <div class='line2'>
                <span class='hospital'>{ hospital }</span>
                <span class='room'>{ room }</span>
            </div>
        </div>
    </a>
    <script>
        var self = this;
        self.doctorlink = "doctorDetail.html?doctorid=" + self._id; 
    </script>
</focus-item>

