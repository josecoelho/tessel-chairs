var http    = require('http'),
    tessel  = require('tessel')

function Chair(port) {
  this.redLight = tessel.port[port].digital[1];
  this.greenLight = tessel.port[port].digital[2];
  this.book = function() {
    this.greenLight.output(1)
    this.redLight.output(0)
  }
  this.vacate = function() {
    this.greenLight.output(0)
    this.redLight.output(1)
  }
}

var chairCollection = {
  A: new Chair('A'),
  B: new Chair('B'),
  C: new Chair('C')
}


setTimeout( function() {
  http.createServer(function(req, res) {
    if (req.method === 'GET') {
      var msg = req.url.split('/')[1]
      if(msg == 'on') {
        chairCollection.A.book()
        chairCollection.B.book()
        chairCollection.C.book()
      } else {
        chairCollection.A.vacate()
        chairCollection.B.vacate()
        chairCollection.C.vacate()
      }


      res.writeHead(200, {'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*'});
      res.end('{"led": "' + msg + '"}');

    }
  }).listen(80);
}, 20000)