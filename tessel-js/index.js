var http    = require('http'),
    tessel  = require('tessel')

function Chair(port) {
  this.redLight = tessel.port[port].digital[1];
  this.greenLight = tessel.port[port].digital[2];
  this.bookedStatus = function(status) {
    if (status == "booked") {
      this.greenLight.output(0)
      this.redLight.output(1)
    } else {
      this.greenLight.output(1)
      this.redLight.output(0)
    }
  }
}

var chairCollection = {
  A: new Chair('A'),
  B: new Chair('B'),
  C: new Chair('C')
}
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