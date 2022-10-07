import consumer from "channels/consumer"

consumer.subscriptions.create("AppearanceChannel", {
   // Called once when the subscription is created.
  initialized() {}, 

  // Called when the subscription is ready for use on the server
  connected() {
    this.perform("online");
  },
  
  // Called when the WebSocket connection is closed.
  disconnected() {
  },
  
  // Called when the subscription is rejected by the server.
  rejected(){
    
  },

  online(){
    console.log("online");
    this.perform("online");
  },
  
  away(){
    console.log("away");
    this.perform("away");
  },
  
  offline(){
    console.log("offline");
    this.perform("offline");
  },  
  
  
  received(data) {
    // Called when there's incoming data on the websocket for this channel
  },
  
  uninstall(){},
  
  install(){}
});
