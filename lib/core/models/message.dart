class Message {
  int id;
  int convoId;
  int isAdmin;
  String content;
  String createdAt;

  Message({this.id, this.convoId, this.isAdmin, this.createdAt, this.content});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      convoId: json['convo_id'],
      isAdmin: json['is_admin'],
      content: json['message'],
      createdAt: json['created_at'],
    );
  }
}
