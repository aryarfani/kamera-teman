import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman/locator.dart';
import 'package:kamera_teman/core/providers/barang_provider.dart';
import 'package:kamera_teman/ui/widgets/app_header.dart';
import 'package:kamera_teman/core/utils/constant.dart';
import 'package:kamera_teman/core/utils/router.dart';
import 'package:provider/provider.dart';

class BarangScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return ChangeNotifierProvider<BarangProvider>(
      create: (context) => locator<BarangProvider>(),
      child: Consumer<BarangProvider>(
        builder: (context, model, child) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: AppHeader(
                  mq: mq,
                  callback: () {
                    Navigator.pushNamed(context, RouteName.addBarang);
                  },
                  title: 'Daftar Barang',
                  widget: getBarangListUI(model),
                ),
              ),
            ),
          );
        },
      ),
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
                  child: BarangItem(
                    name: barangs[index].nama,
                    harga: barangs[index].harga.toString(),
                    image: NetworkImage(linkImage + barangs[index].gambar),
                    stock: barangs[index].stock,
                  ),
                ),
              );
            },
          );
  }
}

class BarangItem extends StatelessWidget {
  final NetworkImage image;
  final String name;
  final String harga;
  final int stock;

  const BarangItem({this.image, this.name, this.harga, this.stock});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image(
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              image: image,
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(name,
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF403269),
                  )),
              Text('Rp. $harga/day',
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF776A9E),
                  )),
              Text('Stock $stock',
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF776A9E),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
