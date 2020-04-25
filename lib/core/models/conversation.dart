class Conversation {
  int id;
  String nama;
  String gambar;
  String lastMessage;
  String lastMessageTime;

  Conversation({this.id, this.gambar, this.lastMessage, this.nama, this.lastMessageTime});

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'],
      nama: json['nama'],
      gambar: json['gambar'],
      lastMessage: json['last_message'],
      lastMessageTime: json['last_message_time'],
    );
  }
}
