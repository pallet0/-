const express = require("express");
const app = express();

app.get('/', (req, res) => {
    res.sendFile(__dirname + "/html/mainpage.html");
});

app.use(express.static("public"));
app.use(express.static(__dirname + "/css"));
app.use(express.static(__dirname + "/html"));
app.use(express.static(__dirname + "/img"));
app.use(express.static(__dirname + "/script"));

app.listen(3000, () =>{
    console.log("now listening on port 3000");
});