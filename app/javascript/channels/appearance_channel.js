import consumer from "channels/consumer"

let resetFunc;
let timer = 0;

consumer.subscriptions.create("AppearanceChannel", {
   // Called once when the subscription is created.
  initialized() {}, 

  // Called when the subscription is ready for use on the server
  connected() {
    console.log("connected");
    resetFunc = () =>this.resetTimer(this.uninstall);
    this.install();
    window.addEventListener("turbo:load",()=> this.resetTimer())
  },
  
  // Called when the WebSocket connection is closed.
  disconnected() {
    console.log("dis-connected");
    this.uninstall();
  },
  
  // Called when the subscription is rejected by the server.
  rejected(){
    // console.log("Rejected");
    this.uninstall();
  },

  online(){
    // console.log("online");
    this.perform("online");
  },
  
  away(){
    // console.log("away");
    this.perform("away");
  },
  
  offline(){
    // console.log("offline");
    this.perform("offline");
  },  
  
  
  received(data) {
    // Called when there's incoming data on the websocket for this channel
  },
  
  uninstall(){
    const shouldRun = document.getElementById("appearance channel")
      if(!shouldRun) {
          clearTimeout(timer);
          this.perform("offline")
      }

  },
  
  install(){
    // console.log("Install")
    window.removeEventListener("load",resetFunc);
    window.removeEventListener("DOMContentLoaded",resetFunc);
    window.removeEventListener("click",resetFunc);
    window.removeEventListener("keydown",resetFunc);

    window.addEventListener("load",resetFunc);
    window.addEventListener("DOMContentLoaded",resetFunc);
    window.addEventListener("click",resetFunc);
    window.addEventListener("keydown",resetFunc);
    this.resetTimer();
  },

  resetTimer(){
    this.uninstall();
    const shouldRun = document.getElementById("appearance_channel");

    if(!!shouldRun){
      this.online();
      clearTimeout(timer);
      const timeInSeconds = 5;
      const milliseconds = 1000;
      const timeInMilliseconds = timeInSeconds * milliseconds;

      timer = setTimeout(this.away.bind(this),timeInMilliseconds);
    }
  },
});
