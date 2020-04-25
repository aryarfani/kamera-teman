import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman/core/models/message.dart';
import 'package:kamera_teman/core/providers/chat_provider.dart';
import 'package:kamera_teman/core/utils/constant.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen(this.arguments);

  final Map arguments;
  final TextEditingController cMessage = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Consumer<ChatProvider>(
      builder: (context, chatProv, _) {
        //* if the message is null or the message is not the current conversation
        // get the messages..
        if (chatProv.messages == null || chatProv.cekCurrentConversationId(id: arguments['id'])) {
          chatProv.getMessages(id: arguments['id']);
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                    imageUrl: linkImage + arguments['gambar'],
                    fit: BoxFit.cover,
                    width: 40,
                    height: 40,
                  ),
                ),
                SizedBox(width: 8),
                Text(arguments['nama']),
              ],
            ),
            backgroundColor: Styles.darkPurple,
          ),
          body: Column(
            children: <Widget>[
              _buildChatList(chatProv, mq),
              _buildChatSend(mq, chatProv, context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChatList(ChatProvider chatProv, mq) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(color: Styles.coolWhite),
        child: ListView.builder(
          itemCount: chatProv.messages.length,
          reverse: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            Message message = chatProv.messages[index];
            return _buildChat(message, mq);
          },
        ),
      ),
    );
  }

  Row _buildChat(Message message, mq) {
    return Row(
      mainAxisAlignment: message.isAdmin == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        message.isAdmin == 1
            ? Container()
            : Padding(
                padding: EdgeInsets.only(bottom: 5, left: 5, right: 10),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(linkImage + arguments['gambar']),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
        Container(
          padding: EdgeInsets.all(10),
          constraints: BoxConstraints(maxWidth: mq.width * 0.7),
          decoration: BoxDecoration(
              color: message.isAdmin == 0 ? Colors.white : Styles.darkPurple,
              borderRadius: BorderRadius.only(
                  bottomLeft: message.isAdmin == 1 ? Radius.circular(10) : Radius.circular(0),
                  bottomRight: message.isAdmin == 1 ? Radius.circular(0) : Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10))),
          child: Text(
            message.content,
            softWrap: true,
            style: GoogleFonts.openSans(
              color: message.isAdmin == 0 ? Colors.black : Colors.white,
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(height: 50),
        message.isAdmin == 1
            ? Icon(
                Icons.check,
                size: 20,
                color: message.id == null ? Colors.grey[400] : Styles.darkPurple,
              )
            : Container()
      ],
    );
  }

  Widget _buildChatSend(Size mq, ChatProvider chatProv, context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Form(
        key: _formKey,
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 10),
              width: mq.width - 60,
              child: TextField(
                maxLines: null,
                controller: cMessage,
              ),
            ),
            InkWell(
              onTap: () async {
                String text = cMessage.text;
                if (text.trim().isNotEmpty) {
                  cMessage.text = "";
                  var res = await chatProv.addMessage(id: arguments['id'], content: text.toString());
                  if (res != true) {
                    showToast("Please cek your internet connection");
                  }
                }
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Styles.darkPurple,
                ),
                child: Icon(
                  Icons.send,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
