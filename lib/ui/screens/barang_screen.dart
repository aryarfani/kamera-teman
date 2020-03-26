import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman/locator.dart';
import 'package:kamera_teman/models/barang.dart';
import 'package:kamera_teman/providers/barang_model.dart';
import 'package:kamera_teman/ui/widgets/app_header.dart';
import 'package:kamera_teman/utils/constant.dart';
import 'package:kamera_teman/utils/router.dart';
import 'package:provider/provider.dart';

class BarangScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return ChangeNotifierProvider<BarangModel>(
      create: (context) => locator<BarangModel>(),
      child: Consumer<BarangModel>(
        builder: (context, model, child) {
          return Scaffold(
            body: SafeArea(
              child: AppHeader(
                mq: mq,
                callback: () {
                  Navigator.pushNamed(context, RouteName.addBarang);
                },
                title: 'Daftar Barang',
                widget: model.state == ViewState.Busy
                    ? Center(child: CupertinoActivityIndicator())
                    : getBarangListUI(model.barangs),
              ),
            ),
          );
        },
      ),
    );
  }

  ListView getBarangListUI(List<Barang> barangs) {
    return ListView.builder(
      itemCount: barangs.length,
      itemBuilder: (context, index) => BarangItem(
        name: barangs[index].nama,
        harga: barangs[index].harga.toString(),
        image: NetworkImage(linkImage + barangs[index].gambar),
        stock: barangs[index].stock,
      ),
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
      margin: EdgeInsets.only(bottom: 10),
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
