<answer class="answer">
	<div class="wenda">问答</div>
	<div class="videoSearch">
		<div><input type="search" name="" placeholder="搜索问题或医生" onkeyup="{ editor }"></div>
		<div onclick="{ asksearch }">搜索</div>
	</div>
	<answer-item each="{ answervideo }" class="answer-item"></answer-item>
	<script>
		var self = this;

		var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));
		console.log(dfs_cookie);

		var info = {
			type: 0,
			userid: dfs_cookie.userId,
			token: dfs_cookie.id
		};

		RiotControl.trigger("getAnswerVideoList",info);
        RiotControl.on("answerVideoListChanged",function(data){
            self.answervideo = data;
            console.log(data);
            self.update();
        });


        editor(e) {
          this.text = e.target.value
        }

        asksearch(){
        	var url = "searchquestion.html?query=" + this.text;
        	window.location.href = url;
        }

	</script>
</answer>

<answer-item onclick="{ payorder }">
	<div class="askuser">
		<div class="avatar">
			<img src="{ ask_user.avatar[0] }" alt="">
			<img src="../images/answer/askicon.png" alt="">
		</div>
		<div class="askline">
			<div class="asktitle"><span>{ ask_user.nickname }</span>向<span>{ answer_user.nickname }</span>提问：{ title }</div>
			<div style="overflow-x: scroll;overflow-y: inherit;">
				<div class="pics">
					<pictures each="{ pics }" class="pic-item"></pictures>
				</div>
			</div>

			<div class="created">{ created }</div>
		</div>
	</div>

	<div class="answeruser">
		<div class="avatar">
			<img src="{ answer_user.avatar[0] }" alt="">
			<img src="../images/answer/answericon.png">
		</div>
		<div class="answerline">
			<div class="answertitle"><span>{ answer_user.nickname }</span>的回答：</div>
			<div class="answerdetail">
				<div class="videocover">
					<img src="{ vcover }" alt="">

				</div>
				<div class="istrue">支付{ price/100 }元查看</div>
			</div>
			<div class="created">{ updated }</div>
		</div>

	</div>

	<script>
		var self = this;
		self.kan = "支付" + self.price/100 +"元查看";

		var winUrl = location.href;

		var dfs_cookie = jQuery.parseJSON(dfs.getCookie('dfs_token'));
		var userinfo = jQuery.parseJSON(dfs.getCookie('userinfo'));



		payorder(){

			//getNumber();

			var videoInfo ={
				"questionid" : self._id,
				"userid": dfs_cookie.userId
			};
	        if(self.video == null){
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
	        }else{
	        	window.location.href = "answervideo.html?vid="+ self._id +"&uid=" + self.answer_userid;
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
			        		alert(''+data);
			        	});
		        	}
		        );
	        });

		}




		$(function(){
			var width = document.body.clientWidth;
			var asklineWidth = width-100;
			$(".askline").css("width",asklineWidth);
			$(".answerline").css("width",asklineWidth);

			var istrueWidth = $(".answerdetail").width() - 80;
			$(".istrue").css("width",istrueWidth);


		})
	</script>
</answer-item>

<pictures>
		<img src="{ pic }" alt="">
	<script>
		var self = this;	</script>
</pictures>


