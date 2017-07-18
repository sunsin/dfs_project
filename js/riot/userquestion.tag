<userquestion class='userquestion'>
	
    <doctor class='doctor'></doctor>
    
    <script>
    	var self = this;
    	self.userid = location.search.split("doctorid=")[1].split("&")[0];
    	//doctor message
    	
    </script>
</userquestion>

<doctor>
    <div class="headimg">
		<img src="{ doctorinfo.info.avatar[0] }" alt="">
	</div>
	<div class="info">
		<div class='middle'>
			<div class="line1">
				<span>{ doctorinfo.info.nickname }</span>
				<span>{ doctorinfo.info.title }</span>
			</div>
			<div class="line2">
				<span>{ doctorinfo.info.hospital }</span>
				<span>{ doctorinfo.info.room }</span>
			</div>
		</div>
		
	</div>
	<script>
		var self = this;
		RiotControl.trigger("getDoctorMessage",self.parent.userid);
        RiotControl.on("doctorMessage",function(data){
            self.doctorinfo = data;
            console.log(data);
            if(data.info.ask_price > 0){
            	$(".wechatpay").find("span").text(data.info.ask_price/100);
            }else{
            	$(".wechatpay").find("div").text("免费提问");
            }
            
            self.update();

        });

	</script>
</doctor>




