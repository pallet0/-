'use strict';

// 점수판
var scoreData = {
    "phaseScore": -1,
    "weatherScore": -1,
    "airScore": -1
}

//-------------여기 까지 달 위상-------------

// https://api.openweathermap.org/data/3.0/onecall?lat=37.5666675&lon=126.9384719&exclude=current&appid=cf56540f55494aadc10269c58b60dbdb&lang=kr


function okgood1(pos){
    var lat1 = pos.coords.latitude;
    var lon1 = pos.coords.longitude;
    function weather(){
        fetch(`https://api.openweathermap.org/data/2.5/weather?lat=${lat1}&lon=${lon1}&appid=cf56540f55494aadc10269c58b60dbdb`)
        .then((response) => response.json())
        .then(function(data){
            let cloud = data.clouds.all;
            let sunsettime = data.sys.sunset;
            let sunrisetime = data.sys.sunrise;
            let currtime = new Date();
            currtime = currtime.getTime() / 1000;
            console.log(currtime);
            if((currtime <= sunrisetime)){
                document.getElementById("main4").innerHTML = "해가 져서 달을 볼 수 있어요 :) <br>";     
            }
            else if((currtime >= sunsettime)){
                document.getElementById("main4").innerHTML = "해가 져서 달을 볼 수 있어요 :) <br>";   
            }
            else{
                document.getElementById("main4").innerHTML = "해가 아직 떠있어요 밝아서 잘 보이지 않아요:( <br>";     
            }


            if((cloud >= 0) && (cloud <= 25)){
                document.getElementById("main3").innerHTML = "구름 없이 맑아요 :) <br>";
            }
            else if((cloud >= 26) && (cloud <= 50)){
                document.getElementById("main3").innerHTML = "구름이 조금 있어요 :) <br>";
            }
            else if((cloud >= 51) && (cloud <= 75)){
                document.getElementById("main3").innerHTML = "구름이 많고 흐려요 :( <br>";
            }
            else if((cloud >= 76) && (cloud <= 100)){
                document.getElementById("main3").innerHTML = "구름이 꽉 꼈어요 :( <br>";
            }
            console.log(data)
        })
        .catch(error => console.log(error));
    }
    weather();
}

navigator.geolocation.getCurrentPosition(okgood1,()=>console.log('gps error'));
//.clouds.all = 운량 단위:%
//.sys.sunset = 1654512557 -> unix 시간을 의미.
//-------------여기 까지 날씨-------------



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
            m[3].innerHTML = "Next full moon<br>"+ b.nextFullMoon}
        };
    a.open("GET",url,true);
    a.send()}
mainmoon();


function airpollution(callbackFunc){
    try{
        var xhr = new XMLHttpRequest();
        xhr.open('GET', "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?stationName=%EC%A2%85%EB%A1%9C%EA%B5%AC&dataTerm=month&pageNo=1&numOfRows=100&returnType=json&serviceKey=mX1wXcfPczMEFuuPphFJjWRpZvTnXdbTpqJfc%2Bw6cPBp3ImtqqKt04qw09RgZbLhhROryk4OV60bD40RFWyWRA%3D%3D");
        xhr.responseType = 'json';
        xhr.send()

        xhr.onload = () => {
            let data = xhr.response;
            let aRes = data.response;
            let grade = JSON.parse(aRes.body.items[0].pm10Grade);
            // document.getElementById("as").innerHTML = airScore;
            callbackFunc(grade);
        };
    } catch (error) {
        throw(error);
    }
}

airpollution(function(data){
    console.log(data);
    if(data == 1){
        document.getElementById("main2").innerHTML = "미세먼지가 거의 없어요 :)<br>";
    }
    if(data == 2){
        document.getElementById("main2").innerHTML = "미세먼지 양호 :)<br>";
    }
    if(data == 3){
        document.getElementById("main2").innerHTML = "미세먼지가 많아요 :(<br>";
    }
    if(data == 4){
        document.getElementById("main2").innerHTML = "미세먼지가 심해요! 나가지 마세요 :(<br>";
    }
});


/*
    fetch('http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?stationName=%EC%A2%85%EB%A1%9C%EA%B5%AC&dataTerm=month&pageNo=1&numOfRows=100&returnType=json&serviceKey=mX1wXcfPczMEFuuPphFJjWRpZvTnXdbTpqJfc%2Bw6cPBp3ImtqqKt04qw09RgZbLhhROryk4OV60bD40RFWyWRA%3D%3D')
    .then((response) => response.text())
    .then((data) => console.log(JSON.parse(data)))
    .catch((err)=> console.log(err));
*/

//items[0] 가 제일 최신 것 item.
//pm10Value = pm10 미세먼지 농도 ,단위 : ㎍/㎥
//pm10grade 1,2,3,4 -> 좋음, 보통, 나쁨, 매우 나쁨
//serviceKey=mX1wXcfPczMEFuuPphFJjWRpZvTnXdbTpqJfc%2Bw6cPBp3ImtqqKt04qw09RgZbLhhROryk4OV60bD40RFWyWRA%3D%3D