<answerit class="answerit">
	<div class="top">
		<div>
			<div class="asktitle">{ question.title }</div>
			<div class="created">{ question.created }</div>
			<div style="overflow-x: scroll;overflow-y: inherit;">
				<div class="pics">
					<pictures each="{ question.pictures }" class="pic-item"></pictures>
				</div>
			</div>
		</div>
		
	</div>
	<script>
		var self = this;
		self.id = location.href.split("id=")[1].split("&")[0];
		var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));
        var infos = {
            "questionid" : self.id,
            "userid": dfs_cookie.userId
        }
		RiotControl.trigger("getPayVideoList",infos);
        RiotControl.on("payVideoListChanged",function(data){
            self.question = data;
            console.log(data);
            self.update();
        });
	</script>
</answerit>

<pictures>
	<img src="{ pic }" alt="" onclick="{ showimg }">
	<script>
		var self = this;
		showimg(){
			
			var imgItem = document.createElement("img"); 
			imgItem.src = self.pic; 
			var divItem = document.createElement("div"); 
			divItem.appendChild(imgItem);
			var show = document.getElementById("show");
			while(show.hasChildNodes()) 
			    {
			        show.removeChild(show.firstChild);
			    }
			show.appendChild(divItem);
			show.style.display = "block";
			show.style.display = "table";
			
		}	
	</script>
</pictures>
