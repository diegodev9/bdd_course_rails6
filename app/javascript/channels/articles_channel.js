/*import consumer from "./consumer"

consumer.subscriptions.create( { channel:"ArticlesChannel", id: "<%= @article.id %>" }, {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log('connected to ', this)
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log('disconnected')
  },

  received(data) {
    $("#messages").prepend(data)
  }
});*/
