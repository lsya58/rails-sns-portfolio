import consumer from "./consumer"

document.addEventListener('turbo:load', () => {
  const messagesDiv = document.getElementById('messages');
  
  if (messagesDiv) {
    const roomId = messagesDiv.dataset.roomId;
    
    consumer.subscriptions.create({ channel: "RoomChannel", room_id: roomId }, {
      connected() {
        console.log("Connected to room " + roomId);
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        // メッセージを受信したら追加
        const messagesDiv = document.getElementById('messages');
        messagesDiv.insertAdjacentHTML('beforeend', data.message);
        
        // フォームをクリア
        document.getElementById('message-content').value = '';
        
        // 一番下までスクロール
        messagesDiv.scrollTop = messagesDiv.scrollHeight;
      }
    });
  }
});