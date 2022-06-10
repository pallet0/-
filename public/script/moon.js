
async function load(){
    /*
    var airScore = -1; // 0~3
    var weatherScore = {"score": -1, "state": "none"}; // 0~6
    var phaseScore = -1; // 0~1
    var finalScore = 0;
    */

    function mainmoon() {var d=new Date().getDate();
        var m = document.querySelectorAll("#contain_moon div");
        var a = new XMLHttpRequest();

        var url= "https://www.icalendar37.net/lunar/api/?lang=en&month="+
        (new Date().getMonth()+1)+"&year="+(new Date().getFullYear())+
        "&size=400&lightColor=rgb(245,245,245)&shadeColor=rgb(17,17,17)&LDZ="+
        new Date(new Date().getFullYear(),new Date().getMonth(),1)/1000+"";

        m[1].style.height="400px";
        
        a.onreadystatechange=function(){
            if(a.readyState==4&&a.status==200){
                var b = JSON.parse(a.responseText);
                m[1].innerHTML = b.phase[d].svg;
                if(typeof moon_widget_loaded=="function")
                moon_widget_loaded(b);
                m[2].innerHTML = b.phase[d].npWidget;
                
                let phaseScore;
                let s = parseInt(b.phase[d].npWidget.replace( /\D+/g, ''));
                if (s==0) { phaseScore = 0;}
                else {phaseScore = 1;}

                m[3].innerHTML = "Next full moon<br>"+ b.nextFullMoon;
                document.getElementById('phase').innerHTML = JSON.stringify(phaseScore);
            }};
        a.open("GET",url,true);
        a.send()
    }
    //-------------여기 까지 달 위상-------------

    // https://api.openweathermap.org/data/3.0/onecall?lat=37.5666675&lon=126.9384719&exclude=current&appid=cf56540f55494aadc10269c58b60dbdb&lang=kr


    function okgood1(pos){
        var lat1 = pos.coords.latitude;
        var lon1 = pos.coords.longitude;
        function weather(){
            fetch(`https://api.openweathermap.org/data/2.5/weather?lat=${lat1}&lon=${lon1}&appid=cf56540f55494aadc10269c58b60dbdb`)
            .then((response) => response.json())
            .then((data) => {
<<<<<<< HEAD
                let dont = false // dont = true일땐 항상 0
=======
                console.log(data);
>>>>>>> f5b43546ac6efc3d6d987dda008bc02125b88e04
                let id = data.weather[0].id;
                let cloud = data.clouds.all;
                let visible = data.visibility;
                let s = -1; // 임시 점수
                let w = ""; // 날씨
                //구름점수(0~3)
                if(cloud < 10) { s = 3;}
                else if (cloud < 25) { s = 2;}
                else if (cloud < 50) { s = 1;}
                else { dont = true;}
                //시야각점수(0~2)
                if(visible < 1000) {dont = true;}
                else if(visible < 5000) { s += 1;}
                else {s += 2;}
                //날씨(0~1)
<<<<<<< HEAD
                switch(Math.floor(id/100)){
=======
                switch(parseInt(id/100)){
>>>>>>> f5b43546ac6efc3d6d987dda008bc02125b88e04
                    case 2: // 천둥번개
                    dont = true;
                        w = "천둥번개가 치고 있어요~!!" 
                    case 3: //보슬비
                        if(id >= 302){ dont = true;}
                        else {s += 1;}
                        w = "보드라운 보슬비가 내리고 있어요!" 
                    case 5: // 비
                        dont = true;
                        w = "토독토독 비가 내리고 있어요! 구름이 두꺼워 달은 보기 힘들어요 :(" 
                    case 6: // 눈
                        dont = true;
                        w = "눈을 수북히 쌓는 두꺼운 구름이 등장했어요~!" 
                    case 7: // 특수(701 -> 안개)
                        if(id != 701) { 
                            dont = true;
                            w = "대기에 이상한 일이 벌어지고 있어요~! 대피해요!!";
                        } else {
                            s += 1
                            w = "곳곳에 자그마한 이슬이 맺혔네요!";   
                        }
                    default:  // 맑음 or 구름뿐(흐림)
                        if(id == 800){
                            w = "날이 정말 맑아요!";
                            s += 1; 
                        } else {
                            w = "구름이 조금 있는 것 같네요...";
                            s += 0;
                        }
                }
                let weatherScore = {"score": -1, "state": "none"};
                if(dont) { weatherScore.score = 0}
                else { weatherScore.score = s; }
                weatherScore.state = w;
                
                document.getElementById('weather').innerHTML = JSON.stringify(weatherScore);
            })
            .catch(error => console(error));
        }
        weather();
    }

    //.clouds.all = 운량 단위:%
    //.sys.sunset = 1654512557 -> unix 시간을 의미.
    //-------------여기 까지 날씨-------------


    function airpollution(){
        fetch('http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?stationName=%EC%A2%85%EB%A1%9C%EA%B5%AC&dataTerm=month&pageNo=1&numOfRows=100&returnType=json&serviceKey=mX1wXcfPczMEFuuPphFJjWRpZvTnXdbTpqJfc%2Bw6cPBp3ImtqqKt04qw09RgZbLhhROryk4OV60bD40RFWyWRA%3D%3D')
        .then((response) => response.json())
        .then((data) => {
            document.getElementById("invisible").innerHTML = JSON.stringify(data);
            let r = data.response;
            let d = JSON.parse(r.body.items[0].pm10Grade);
            let airScore = Math.abs(parseInt(d) - 4);
            // document.querySelector("h2").innerHTML = airScore;
            document.getElementById('air').innerHTML = JSON.stringify(airScore);
        })
        .catch((err)=> console.log(err));
    }
    //items[0] 가 제일 최신 것 item.
    //pm10Value = pm10 미세먼지 농도 ,단위 : ㎍/㎥
    //pm10grade 1,2,3,4 -> 좋음, 보통, 나쁨, 매우 나쁨
    //serviceKey=mX1wXcfPczMEFuuPphFJjWRpZvTnXdbTpqJfc%2Bw6cPBp3ImtqqKt04qw09RgZbLhhROryk4OV60bD40RFWyWRA%3D%3D
    mainmoon();
    navigator.geolocation.getCurrentPosition(okgood1,(e)=>console.log(e));
    airpollution();
}

document.addEventListener("load", load());