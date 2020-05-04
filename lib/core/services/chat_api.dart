import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kamera_teman/core/models/conversation.dart';
import 'package:kamera_teman/core/models/message.dart';
import 'package:kamera_teman/core/utils/constant.dart';

class ChatApi {
  //* Function to get conversations
  // res list<Conversation>
  Future getConversations() async {
    var link = linkApi + "conversation";
    List<Conversation> conversations = [];
    try {
      var res = await http.get(link);
      var jsonObject = await json.decode(res.body);
      if (jsonObject == []) {
        return conversations;
      }
      List<dynamic> dataJson = jsonObject;

      for (var data in dataJson) conversations.add(Conversation.fromJson(data));
    } on Exception catch (e) {
      print(e);
    }
    return conversations;
  }

  //* Function to get messages
  // params id
  // res list<Message>
  Future<List<Message>> getMessageById(int id) async {
    var link = linkApi + "conversation/$id";
    List<Message> messages = [];
    try {
      var res = await http.get(link);
      var jsonObject = await json.decode(res.body);
      if (jsonObject == []) {
        return messages;
      }
      List<dynamic> dataJson = jsonObject;

      for (var data in dataJson) messages.add(Message.fromJson(data));
    } on Exception catch (e) {
      print(e);
    }
    return messages;
  }

  //* Function to send message
  // Params id user, content of message
  Future addMessage(int id, String content) async {
    var link = linkApi + "message/$id";

    Map<String, String> body = {
      "message": content,
      "is_admin": "1",
    };

    await http.post(link, body: body);
    return true;
  }
}
