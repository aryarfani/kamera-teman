import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kamera_teman/locator.dart';
import 'package:kamera_teman/core/providers/member_provider.dart';
import 'package:kamera_teman/ui/widgets/app_header.dart';
import 'package:kamera_teman/ui/widgets/user_item.dart';
import 'package:kamera_teman/core/utils/router.dart';
import 'package:provider/provider.dart';

class MemberScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return ChangeNotifierProvider<MemberProvider>(
      create: (context) => locator<MemberProvider>(),
      child: Consumer<MemberProvider>(
        builder: (context, model, child) {
          return Scaffold(
            body: SafeArea(
              child: AppHeader(
                mq: mq,
                title: 'Daftar Member',
                callback: () {
                  Navigator.pushNamed(context, RouteName.addMember);
                },
                widget: getMemberListUI(model),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getMemberListUI(MemberProvider model) {
    var members = model.members;
    return members == null
        ? Center(child: CupertinoActivityIndicator())
        : ListView.builder(
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
                      gambar: members[index].gambar,
                    ),
                  ));
            });
  }
}
