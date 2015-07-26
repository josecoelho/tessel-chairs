var http    = require('http'),
    querystring = require('querystring'),
    tessel  = require('tessel'),
    wifi = require('wifi-cc3000');


var CONFIG = {
  name: "Tessel 1",
  chairs: ["A","B","C","D"],
  register_url: "http://chairs.10.1.0.24.xip.io/chairs_managers/register"
}

function Chair(port) {
  this.redLight = tessel.port[port].digital[1];
  this.greenLight = tessel.port[port].digital[2];
  this.bookedStatus = function(status) {
    if (status == "booked") {
      this.greenLight.output(1)
      this.redLight.output(0)
    } else {
      this.greenLight.output(0)
      this.redLight.output(1)
    }
  }
}

var chairCollection = {}
for (var i = 0; i < CONFIG.chairs.length; i++) {
  var chairName = CONFIG.chairs[i]
  chairCollection[chairName] = new Chair(chairName)
}


function registerMyself() {
  var query = querystring.stringify({
    name: CONFIG.name,
    chairs: CONFIG.chairs.join(),
    url: "http://"+require('os').networkInterfaces().en1[0].address+"/"
  })

  var url = CONFIG.register_url+ "?" + query

  console.log("Registering myself: ",url);

  var req = http.get(url, function(res) {
    console.log("Got response: " + res.statusCode);
    startServer();
  }).on('error', function(e) {
    tessel.led[0].toggle() //show the error
    console.log("Got error: " + e.message);
  });
}

function waitUntilConnectedToStart() {
  if(!wifi.isConnected()) {
    console.log("Waiting wifi")
    setTimeout(waitUntilConnectedToStart, 500);
  } else {
    registerMyself();
  }
}

waitUntilConnectedToStart();

function startServer() {
  console.log("Starting the server")
  setTimeout(function() {
    http.createServer(function(req, res) {

      if (req.method === 'GET') {
        console.log("Receiving data:",req.url)
        var params = req.url.split('/')[1]

        var params = params.replace('?', '')

        var bookedData = params.split('&')

        // console.log(params)
        console.log(req.url)

        bookedData.forEach(function(param, index) {

          var item    = param.split('=')[0],
              status  = param.split('=')[1]

          if(chairCollection.hasOwnProperty(item)) {
            chairCollection[item].bookedStatus(status)
          }

        })

        res.writeHead(200, {'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*'});
        res.end('{"led": "done"}');

      }
    }).listen(80);

  }, 10000)
}

