var Stomp = require('stompjs');

var url="/topic/"+process.argv[2]+"."+process.argv[3]+".streams."+process.argv[4]+".updates";

// Use raw TCP sockets
var client = Stomp.overTCP('api.servioticy.com', 1883);

client.connect('compose', 'shines', function(frame) {
client.subscribe(url, function(message) {

        //var request = JSON.parse(message.body);
        //console.log("Posted data "+JSON.stringify(request.body))
        console.log(message.body)
        process.exit()
  });
});
