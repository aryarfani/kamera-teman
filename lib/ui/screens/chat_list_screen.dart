import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman/core/models/conversation.dart';
import 'package:kamera_teman/core/providers/chat_provider.dart';
import 'package:kamera_teman/core/utils/constant.dart';
import 'package:kamera_teman/core/utils/router.dart';
import 'package:provider/provider.dart';

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    Provider.of<ChatProvider>(context, listen: false).getConversationList();
    return Consumer<ChatProvider>(
      builder: (context, chatModel, _) {
        if (chatModel.conversations == null) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Pesan Admin'),
            backgroundColor: Styles.darkPurple,
          ),
          body: Column(
            children: <Widget>[
              _buildConversationList(chatModel, mq),
            ],
          ),
        );
      },
    );
  }

  Expanded _buildConversationList(ChatProvider chatModel, mq) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(color: Styles.coolWhite),
        child: ListView.builder(
          itemCount: chatModel.conversations.length,
          itemBuilder: (context, index) {
            Conversation conversation = chatModel.conversations[index];
            return _buildConversation(context, conversation, mq);
          },
        ),
      ),
    );
  }

  Widget _buildConversation(context, Conversation conversation, mq) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RouteName.chat, arguments: {
          'id': conversation.id,
          'nama': conversation.nama,
          'gambar': conversation.gambar,
        });
      },
      child: Container(
        padding: EdgeInsets.only(top: 6),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Colors.black12,
        ))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 5, left: 5, right: 10),
              child: Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(linkImage + conversation.gambar),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    conversation.nama,
                    style: GoogleFonts.openSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    conversation.lastMessage,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.openSans(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              conversation.lastMessageTime.trim().isEmpty ? '' : conversation.lastMessageTime,
              style: GoogleFonts.openSans(
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
