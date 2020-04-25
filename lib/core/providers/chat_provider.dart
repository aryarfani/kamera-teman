import 'package:flutter/cupertino.dart';
import 'package:kamera_teman/core/models/conversation.dart';
import 'package:kamera_teman/core/models/message.dart';
import 'package:kamera_teman/core/services/chat_api.dart';

class ChatProvider extends ChangeNotifier {
  ChatProvider() {
    print('chat provider created');
  }
  ChatApi chatApi = ChatApi();
  List<Message> messages;
  List<Conversation> conversations;

  // funny i got this idea when i take a shit :v
  //* this property is to reduce load when sending multiple message instantaneous
  int queue = 0;

  int _currentSavedMessageId;
  int get currentSavedMessageId => _currentSavedMessageId;

  Future getConversationList() async {
    conversations = await chatApi.getConversations();
    notifyListeners();
  }

  Future getMessages({@required int id}) async {
    print('getMessages for $id');
    if (queue == 0) {
      _currentSavedMessageId = id;
      messages = await chatApi.getMessageById(id);
      notifyListeners();
    }
  }

  bool cekCurrentConversationId({@required int id}) {
    if (id != _currentSavedMessageId) {
      return true;
    }
    return false;
  }

  Future addMessage({@required String content, @required int id}) async {
    queue++;
    print('addMessage');

    // Add new message to screen
    Message message = Message(content: content, isAdmin: 1);
    messages.insert(0, message);
    notifyListeners();

    // send it to server and verify it
    var res = await chatApi.addMessage(id, content);
    queue--;
    getMessages(id: id);

    return res;
  }
}
