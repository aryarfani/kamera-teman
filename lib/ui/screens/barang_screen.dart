import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kamera_teman/core/providers/barang_provider.dart';
import 'package:kamera_teman/core/utils/router.dart';
import 'package:kamera_teman/ui/widgets/app_header.dart';
import 'package:kamera_teman/ui/widgets/user_item.dart';
import 'package:provider/provider.dart';

class BarangScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Consumer<BarangProvider>(
      builder: (context, model, child) {
        return Scaffold(
          body: SafeArea(
            child: AppHeader(
              mq: mq,
              title: 'Daftar Barang',
              callback: () {
                Navigator.pushNamed(context, RouteName.addBarang);
              },
              widget: getBarangListUI(model),
            ),
          ),
        );
      },
    );
  }

  Widget getBarangListUI(BarangProvider model) {
    var barangs = model.barangs;
    return barangs == null
        ? Center(child: CupertinoActivityIndicator())
        : ListView.builder(
            itemCount: barangs.length,
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
                          model.deleteBarang(barang: barangs[index]);
                        },
                      )
                    ],
                    child: UserItem(
                      nama: barangs[index].nama,
                      alamat: "Stock : " + barangs[index].stock.toString(),
                      gambar: barangs[index].gambar,
                    ),
                  ));
            });
  }
}
