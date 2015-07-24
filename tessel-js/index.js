var http    = require('http'),
    querystring = require('querystring'),
    tessel  = require('tessel')


var CONFIG = {
  name: "Line 1",
  chairs: ["A","B","C"],
  register_url: "http://chairs.10.1.0.24.xip.io/chair_managers/register"
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
    chairs: CONFIG.chairs.join()
  })

  var url = CONFIG.register_url+ "?" + query

  console.log("Registering mysql: ",url);

  http.get(url)
}

registerMyself();

setTimeout(function() {

  http.createServer(function(req, res) {

    if (req.method === 'GET') {
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