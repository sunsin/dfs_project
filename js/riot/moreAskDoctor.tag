<moreAskDoctor>
	<div class="forword" onclick="{ gohistory }">
        <div class="back"><span>可提问医生</span></div>
    </div>
    <canaskDoctor style="padding-bottom: 50px;"></canaskDoctor>
    <script>
    	var self = this;
    	gohistory(){
            window.history.go(-1);
        };
        
    </script>
</moreAskDoctor>


<canaskDoctor class="canaskDoctor">
	<canaskDoctoritem each="{ doctorList }"></canaskDoctoritem>
	<script>
		var self = this;
		RiotControl.trigger("getCanAskDoctorList");
        RiotControl.on("canAskDoctorListChanged",function(data){
            self.doctorList = data;
            console.log(data);
            self.update();
        });
	</script>
</canaskDoctor>

<canaskDoctoritem class="canask-item">
	<div class="avatar" onclick="{ doctorDetail }">
		<img src="{ avatar[0] }" alt="">
	</div>
	<div class="docInfo">
		<div>{ nickname }</div>
		<div>
			<span if={ title }>{ title }</span>
			<span if={ hospital }>{ hospital }</span>
		</div>
		<div if={ profile[0] } class="profile0">{ prifile[0] }</div>
		<div class="askprice" onclick="{ askDoctor }">{ ask_price/100 }元提问</div>
	</div>
	<script>
		var self = this;
		doctorDetail(){
			var doctorDetailUrl = "doctorDetail.html?doctorid=" + self._id;
			window.location.href = doctorDetailUrl; 
		}
		askDoctor(){
			var askDoctorUrl = "userQuestion.html?doctorid=" + self._id;
			window.location.href = askDoctorUrl;
		}
	</script>
</canaskDoctoritem>
