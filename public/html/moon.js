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