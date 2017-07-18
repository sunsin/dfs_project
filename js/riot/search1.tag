<search class="search">
    <div>
        <input type="text" placeholder="搜索视频、医生" value="" id="search-input"/>
        <button onclick="{ value }"></button>
    </div>
    <seacrh-doctor-box></seacrh-doctor-box>
    <seacrh-video-box></seacrh-video-box>

    <script>
        var self = this;
        self.search = [];
        self.doctorSearch = [];


    </script>
</search>

<seacrh-doctor-box class="search-box search-doctor-box">
    <div>医生</div>
    <ul>
        <li each="{ doctorSearch }">
            <a href="{  }">
                <img src="{ _source.avatar[0] }" />
                <div>
                    <div>{ _source.nickname }</div>
                    <span>{ _source.hospital }</span>
                    <span>{ _source.title }</span>
                </div>

            </a>
        </li>
    </ul>
    <script>
        var self = this;
        self.ilist = [];
        RiotControl.trigger("getSearchList",$("input").val());
        RiotControl.on("searchChanged",function(data){
            self.ilist = data;
            self.update();
        });

    </script>
</seacrh-doctor-box>
<seacrh-video-box class="search-box search-video-box">
    <div>视频</div>
    <ul>
        <li><a href="{  }">hello</a></li>
    </ul>
</seacrh-video-box>