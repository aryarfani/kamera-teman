import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kamera_teman/core/providers/admin_provider.dart';
import 'package:kamera_teman/ui/widgets/app_header.dart';
import 'package:kamera_teman/ui/widgets/user_item.dart';
import 'package:kamera_teman/core/utils/router.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return ChangeNotifierProvider<AdminProvider>(
      create: (context) => AdminProvider(),
      child: Consumer<AdminProvider>(
        builder: (context, model, child) {
          return Scaffold(
            body: SafeArea(
              child: AppHeader(
                mq: mq,
                title: 'Daftar Admin',
                widget: getAdminListUI(model),
                callback: () {
                  Navigator.pushNamed(context, RouteName.addAdmin);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getAdminListUI(AdminProvider model) {
    var admins = model.admins;
    return admins == null
        ? Center(child: CupertinoActivityIndicator())
        : ListView.builder(
            itemCount: admins.length,
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
                        model.deleteAdmin(admin: admins[index]);
                      },
                    )
                  ],
                  child: UserItem(
                    nama: admins[index].nama,
                    alamat: admins[index].alamat,
                    gambar: admins[index].gambar,
                  ),
                ),
              );
            },
          );
  }
}
