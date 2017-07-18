
var _commondisease=[
    {
    left: "五官科",
    right: [
    {lists: "五官科"},
    {lists: "眼科"},
    {lists: "耳鼻喉头颈外科"}
    ]
    },
    {
    left: "口腔科",
    right: [
    {lists: "口腔科"},
    {lists: "口腔内科"},
    {lists: "牙周科"},
    {lists: "口腔修复科"},
    {lists: "口腔种植科"},
    {lists: "牙体牙髓科"},
    {lists: "牙体正畸科"},
    {lists: "颌面外科"},
    {lists: "正颌科"},
    {lists: "唇颚裂科"},
    {lists: "颌面创伤科"},
    {lists: "预防口腔科"},
    {lists: "儿童口腔科"}
    ]
    },
    {
    left: "外科",
    right: [
    {lists: "外科"},
    {lists: "普通外科"},
    {lists: "神经外科"},
    {lists: "泌尿外科"},
    {lists: "烧伤整形外科"},
    {lists: "胸外科"},
    {lists: "胃肠外科"},
    {lists: "骨科"},
    {lists: "骨科创伤"},
    {lists: "肝胆外科"},
    {lists: "胆胰外科"},
    {lists: "美容整形科"},
    {lists: "脊柱外科"},
    {lists: "关节外科"},
    {lists: "血管外科"},
    {lists: "小儿外科"},
    {lists: "运动医学科"},
    {lists: "手外科"},
    {lists: "足裸外科"},
    {lists: "肛肠外科"}
    ]
    },
    {
    left: "内科",
    right: [
    {lists: "内科"},
    {lists: "心脏内科"},
    {lists: "普通内科"},
    {lists: "神经内科"},
    {lists: "呼吸内科"},
    {lists: "消化内科"},
    {lists: "肾脏内科"},
    {lists: "内分泌科"},
    {lists: "感染科"},
    {lists: "血液内科"},
    {lists: "老年医学科"},
    {lists: "风湿免疫科"}
    ]
    },
    {
    left: "肿瘤科",
    right: [
    {lists: "肿瘤科"},
    {lists: "头颈肿瘤科"},
    {lists: "腹部肿瘤科"},
    {lists: "胸部肿瘤科"},
    {lists: "骨肿瘤科"},
    {lists: "放疗化疗科"}
    ]
    },
    {
    left: "急诊医学科",
    right: [
    {lists: "急诊医学科"}
    ]
    },
    {
    left: "皮肤科",
    right: [
    {lists: "皮肤科"}
    ]
    },
    {
    left: "影像科",
    right: [
    {lists: "影像科"},
    {lists: "介入科"},
    {lists: "放射科"}
    ]
    },
    {
    left: "妇产科",
    right: [
    {lists: "妇产科"},
    {lists: "生殖内分泌科"},
    {lists: "遗传咨询科"},
    {lists: "产前诊断科"},
    {lists: "计划生育科"}
    ]
    },
    {
    left: "儿科",
    right: [
    {lists: "儿科"},
    {lists: "小儿消化科"},
    {lists: "小儿呼吸科"},
    {lists: "小儿营养保健科"},
    {lists: "小儿神经内科"},
    {lists: "小儿心内科"},
    {lists: "小儿肾内科"},
    {lists: "小儿内分泌科"},
    {lists: "小儿免疫科"},
    {lists: "小儿皮肤科"},
    {lists: "小儿血液科"},
    {lists: "小儿感染科"},
    {lists: "小儿精神科"},
    {lists: "新生儿科"}
    ]
    },
    {
    left: "麻醉科",
    right: [
    {lists: "麻醉科"}
    ]
    },
    {
    left: "重症医学科",
    right: [
    {lists: "重症医学科"}
    ]
    },
    {
    left: "全科",
    right: [
    {lists: "全科"},
    {lists: "精神科"},
    {lists: "检验科"},
    {lists: "病理科"},
    {lists: "药剂科"},
    {lists: "体检中心"}
    ]
    },
    {
    left: "中医",
    right: [
    {lists: "中医"},
    {lists: "中西医结合"},
    {lists: "中西医结合肿瘤科"}
    ]
    },
    {
    left: "传染科",
    right: [
    {lists: "传染科"},
    {lists: "结核科"},
    {lists: "肝病科"},
    {lists: "其他传染病科"}
    ]
    }
    ];

<commondisease class="commondisease">
    <a class="search" href="/html/search.html">
        <span>搜索医生、视频</span>
        <span></span>
    </a>
    <div class="listDisease">
        <div class="left" each="{ commondisease }">{ left }</div>
    </div>
    <div class="detail">
        <div class='right' each="{ commondisease }">
            <a each="{ this.right }" room="{ lists }" href="{ parent.diseaseurl }">
                { lists }
            </a>
        </div>
    </div>

    <script>
        var self = this;

        this.commondisease = _commondisease;
        $(function(){
            $(".left").eq(0).css("background","#fff");
            $(".left").click(function(){
                var index = $(this).index();
                $(this).css("background","#fff").siblings().css("background","#ccc");
                $(".right").eq(index).show().siblings().hide();
            });
            $(".detail").find("a").click(function(){
                var diseaseUrl = "/html/playMain.html?room="+$(this).attr("room");
                $(this).attr("href",diseaseUrl);
                
            });

        });
    </script>
</commondisease>








