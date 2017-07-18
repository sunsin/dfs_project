<doctoranswer class="answer">
	<div class="forword" onclick="{ gohistory }">
        <div class="back"><span>医生问答</span></div>
    </div>
	<div class="doctorinfo">
		<div class="docimg">
			<img src="{ answervideo[0].answer_user.avatar[0] }" alt="">
		</div>
		<div class="docline">
			<div>
				<span>{ answervideo[0].answer_user.nickname }</span>	
				<span>{ answervideo[0].answer_user.title }</span>	
			</div>
			<div>
				<span>{ answervideo[0].answer_user.hospital }</span>	
				<span>{ answervideo[0].answer_user.room }</span>	
			</div>
		</div>
	</div>
	<answer-item each="{ answervideo }" class="answer-item"></answer-item>
	<audio src="" id="audio"></audio>
	<show id="show"></show>
	<div class="askbtn" onclick="{ askbtn }"><div>提问</div></div>
	<script>
		var self = this;

		var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));
		var doctorid = location.href.split("doctorid=")[1].split("&")[0];

		var info = {
			doctorid: doctorid,
			type: 2,
			token: dfs_cookie.id,
			userid: dfs_cookie.userId
		};
		RiotControl.trigger("getAnswerVideoList",info);
        RiotControl.on("answerVideoListChanged",function(data){
            self.answervideo = data;
            console.log(data);
            self.update();
        });

        this.gohistory = function(){
            if(document.referrer.indexOf("topic")!=-1){
                window.location.href = document.referrer;
            }else if(document.referrer == ""){
                window.location.href = "http://weixin.daifushuo.com";
            }else{
                window.history.go(-1);
            }
        }

        askbtn(){
        	var url = "userQuestion.html?doctorid=" + doctorid;
        	window.location.href = url;
        }

	</script>
</doctoranswer>

<answer-item>
	<div class="answerInfo">
		<div class="avatar" onclick="{ doctorDetail }">
			<img src="{ answer_user.avatar[0] }" alt="">
		</div>
		<div class="info">
			<div class="uinfo">
				<div>
					<span if={ answer_user.nickname }>{ answer_user.nickname }</span>
					<span if={ answer_user.title }>{ answer_user.title }</span>
				</div>
				<div>
					<span if={ answer_user.room }>{ answer_user.room }</span>
					<span if={ answer_user.hospital }>{ answer_user.hospital }</span>
				</div>
			</div>

		</div>
		<div class="vinfo">
			<div>点播：{ viewsum || 0}</div>
			<div>{ created }</div>
		</div>
	</div>
	<div class="askuser">
		<div class="askline">
			<div class="askicon" onclick="{ payorder }">
				<span if={ ispublic != true }>私</span>
				<img src="{ ask_user.avatar[0] }">
				<span class="askicon">问</span>
			</div>
			<div class="question">
				<div class="asktitle" onclick="{ payorder }">{ title }</div>
				<div style="overflow-x: scroll;overflow-y: inherit;">
					<div class="pics">
						<pictures each="{ pics }" class="pic-item"></pictures>
					</div>
				</div>
			</div>
			<div class="question askVideoPlay" if="{ ask_video }" onclick="{ videoShow }">
				<div style="overflow-x: scroll;overflow-y: inherit;position: relative;">
					<video id="askVideo{ _id }" src="{ ask_video }" class="video-js vjs-default-skin" preload="auto" poster="{ ask_video+'?vframe/jpg/offset/1' }" style="background-color: #fff;width: 100%;height: 100px;"></video>
					<div class="videoPlayBtn" style="position: absolute;left: 50%;margin-left: -15px;top: 30px;">
						<img src="../../images/login/play.png" class="askVideo{ _id }" alt="" width=30 height= 30>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="answeruser" onclick="{ payorder }" if="{ isanswer }">
		<div>
			<span>答</span>
			<span if={ !video && !answer_text && !voice }>支付后查看详情</span>
		</div>
		<div class="answerline" if={ type==0 } onclick="{ payorder }">
			<div class="answerdetail">
				<div class="videocover">
					<img src="{ vcover }" alt="">
					<div>
						<img src="../images/version2/icon/icon_play_home.png" alt="">
					</div>
				</div>
			</div>
			
		</div>
		<div if={ type==1 } class="answerAudio" onclick="{ payorder }">
			<div class="duration" if={ voice }>{ duration }s</div>
		</div>
		<div if={ type==2 } class="answerText">
			<div onclick="{ payorder }">{ answer_text }</div>
			<div class="pics">
				<pictures each="{ answerpic }" class="pic-item"></pictures>
			</div>
			
		</div>
		
	</div>
	<div class="state" onclick="{ payorder }">
		<div class="istrue" if={ !video && isanswer && price!=0 }>{ price/100 }元查看</div>
		<div class="istrue" if={ price==0  && !video && isanswer}>免费查看</div>
		<div class="isvideo" if={ video }>已支付</div>
		<div class="isanswer" if={ !isanswer }>待回答</div>
	</div>
	
	<script>
		var self = this;
		self.kan = "支付" + self.price/100 +"元查看";
		var orderDetail;
		var winUrl = location.href;

		var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));	
		var userinfo = jQuery.parseJSON(dfs.getCookie('userinfo'));	

		doctorDetail(){
			var doctorDetailUrl = 'doctorDetail.html?doctorid='+ self.answer_userid;
			window.location.href = doctorDetailUrl;
		}
		var video;
		
		var tatalClickNum = 1;
		videoShow(e){

			if(e.target.localName == "video"){
				let imgBtn = document.getElementsByClassName(e.target.id)[0];
				imgBtn.style.display = "none";
				video = videojs(e.target.id);
			}else if(e.target.localName == "img"){
				video = videojs(e.target.className);
				e.target.hidden = true;
			}
	        if(tatalClickNum%2 == 1){
	            video.play();
	            tatalClickNum++;

	        }else{
	            video.pause();
	            tatalClickNum++;
	        }
		}

		var voiceClick = 1;	
		var t,times = 1;
		var startTime;
		function startTime(dura,th){
			return function(){
				if(times<=dura){
					th.target.innerHTML = times + "s";
					// document.getElementsByClassName('duration')[0].innerHTML = times + "s";
					times++;
					t = setTimeout(startTime(dura,th),1000);
				}else{
					window.clearTimeout(t);
				}
			}  
	    }

		payorder(e){

			var videoInfo ={
				"questionid" : self._id,
				"userid": dfs_cookie.userId
			};

	        if(self.video == null && self.voice ==null && self.answer_text ==null){
    	        $.ajax({
    	            url: "http://api.daifushuo.com:80/api/oquestion/dfs_get_question_video",
    	            async: true,
    	            type: "get",
    	            dataType: 'json',
    	            data: videoInfo,
    	            contentType:"application/json;charset=utf-8",
    	            success: function(data) {
    	            	//alert("success");
    	            	window.location.href = "answervideo.html?vid="+ data._id +"&uid=" + data.answer_userid;

    	            },
    	            error: function(data){

    	            	var refreshurl = location.href;
    	            	
    	            	if (typeof WeixinJSBridge == "undefined"){
    					    if( document.addEventListener ){
    					        document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
    					    }else if (document.attachEvent){
    					        document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
    					        document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
    					    }
    					}else{
    					    onBridgeReady();
    					}
    					
    					
    	            }

    	        });
	        }else if(self.video){
	        	window.location.href = "answervideo.html?vid="+ self._id +"&uid=" + self.answer_userid;
	        }else if(self.voice){
	        	if(times > self.duration){
					times = 1;
				}else{
					times = times;
				};
				t=setTimeout(startTime(self.duration,e),1000);

	        	var audio = document.getElementById("audio");
	        	audio.src = self.voice;
	        	if(voiceClick%2 == 1){
	        		audio.play();
	        	}else{
	        		audio.pause();
	        	}
	        	voiceClick++;
	        }else{
	        	return ;
	        }
	        
		}

		function onBridgeReady(){
		   var orderDetail;
			var info = {
				"questionid": self._id,
				"userid": dfs_cookie.userId,
				"total_fee": self.price,
				"spbill_create_ip": "10.10.10.3",
				"trade_type": "JSAPI",
				"openid": userinfo.openid
			};
			var url = "http://api.daifushuo.com:80/api/oquestion/dfs_payforanswer?access_token=" + dfs_cookie.id;
			var refreshurl = location.href;
			$.post(url,info,function(data){
			    orderDetail = data;
		        WeixinJSBridge.invoke(
		        'getBrandWCPayRequest',orderDetail,
		        	function(res){
			        	var order={
			        		"out_trade_no": orderDetail.out_trade_no,
			        		"trade_type": "JSAPI"
			        	};
			        	var purl = "http://api.daifushuo.com:80/api/order/dfs_order_query?access_token="+dfs_cookie.id;

			        	$.post(purl,order,function(data){
			        		//alert("ok");
			        		window.location.href = refreshurl;
			        	});
			        	if(res.err_msg == "get_brand_wcpay_request:ok"){  
	                   //alert(res.err_code+res.err_desc+res.err_msg);  
	                   		//alert("支付成功");
	                       	window.location.href=refreshurl;  
	                   	}else{  
	                       //返回跳转到订单详情页面  
	                        alert("支付失败");  
	                       	window.location.href=refreshurl;  
	                           
	                   	};
	                   	window.location.href = refreshurl;
		        	}
		        );
	        });
		}
		
	</script>
</answer-item>

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

<show onclick="{ hideimg }">
	<script>
		hideimg(){
			var show = document.getElementById("show");
			show.style.display = "none";
		}
	</script>
</show>

