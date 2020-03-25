import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kamera_teman/locator.dart';
import 'package:kamera_teman/providers/member_model.dart';
import 'package:kamera_teman/ui/screens/add_member_screen.dart';
import 'package:kamera_teman/ui/widgets/app_header.dart';
import 'package:kamera_teman/ui/widgets/user_item.dart';
import 'package:kamera_teman/utils/constant.dart';
import 'package:provider/provider.dart';

class MemberScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return ChangeNotifierProvider<MemberModel>(
      create: (context) => locator<MemberModel>(),
      child: Consumer<MemberModel>(
        builder: (context, model, child) {
          return Scaffold(
            body: SafeArea(
              child: AppHeader(
                mq: mq,
                title: 'Daftar Member',
                callback: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddMemberScreen()));
                },
                widget: model.state == ViewState.Busy
                    ? Center(child: CupertinoActivityIndicator())
                    : getMemberListUI(model),
              ),
            ),
          );
        },
      ),
    );
  }

  ListView getMemberListUI(MemberModel model) {
    var members = model.members;
    return ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          return Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Slidable(
                actionPane: SlidableBehindActionPane(),
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.redAccent,
                    icon: Icons.delete,
                    onTap: () {
                      model.deleteMember(member: members[index]);
                    },
                  )
                ],
                child: UserItem(
                  nama: members[index].nama,
                  alamat: members[index].alamat,
                  gambar: NetworkImage(linkImage + members[index].gambar),
                ),
              ));
        });
  }
}
