import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman/core/models/barang_borrowed.dart';
import 'package:kamera_teman/core/providers/riwayat_provider.dart';
import 'package:kamera_teman/core/utils/constant.dart';
import 'package:kamera_teman/core/utils/router.dart';
import 'package:kamera_teman/ui/widgets/barang_item.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class BarangScreen extends StatefulWidget {
  @override
  _BarangScreenState createState() => _BarangScreenState();
}

class _BarangScreenState extends State<BarangScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  final List<Tab> _tabTitleList = [
    Tab(child: Text('Konfirmasi')),
    Tab(child: Text('Dipinjam')),
    Tab(child: Text('Semua')),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Provider.of<RiwayatProvider>(context, listen: false).getUnconfirmedRiwayat();
    Provider.of<RiwayatProvider>(context, listen: false).getBorrowedRiwayat();
    Provider.of<RiwayatProvider>(context, listen: false).getAllRiwayat();
    return Consumer<RiwayatProvider>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Styles.darkPurple,
            actions: <Widget>[
              InkWell(
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.add_circle_outline,
                    color: Styles.coolWhite,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(RouteName.addBarang);
                },
              )
            ],
            title: Text(
              'Riwayat',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Styles.coolWhite,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
                  decoration: BoxDecoration(color: Styles.darkPurple),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TabBar(
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Colors.white,
                        tabs: _tabTitleList,
                        controller: _tabController,
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: height,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Tab(child: UncofirmedBarang(model)),
                      Tab(child: BorrowedBarang(model)),
                      Tab(child: AllBarangRiwayat(model)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class UncofirmedBarang extends StatelessWidget {
  UncofirmedBarang(this.model);
  final RiwayatProvider model;
  @override
  Widget build(BuildContext context) {
    return model.state == ViewState.Busy
        ? Center(child: CircularProgressIndicator())
        : model.unconfirmedRiwayat == null
            ? NoBarangBg()
            : ListView.builder(
                itemCount: model.unconfirmedRiwayat.length,
                itemBuilder: (context, index) {
                  BarangBorrowed barang = model.unconfirmedRiwayat[index];
                  return BarangItem(
                    nama: barang.nama,
                    namaMember: barang.namaMember,
                    totalBiaya: barang.total_biaya,
                    image: NetworkImage(linkImage + barang.gambar),
                    stock: barang.stock,
                    endIcon: EndIcon.Confirming,
                    confirmCallback: () async {
                      if (await model.confirmBarang(id: barang.riwayatId)) {
                        showToast('Barang dikonfirmasi');
                      }
                    },
                    cancelCallback: () async {
                      if (await model.cancelBarang(id: barang.riwayatId)) {
                        showToast('Barang dicancel');
                      }
                    },
                  );
                },
              );
  }
}

class BorrowedBarang extends StatelessWidget {
  BorrowedBarang(this.model);
  final RiwayatProvider model;
  @override
  Widget build(BuildContext context) {
    return model.state == ViewState.Busy
        ? Center(child: CircularProgressIndicator())
        : model.borrowedRiwayat == null
            ? NoBarangBg()
            : ListView.builder(
                itemCount: model.borrowedRiwayat.length,
                itemBuilder: (context, index) {
                  BarangBorrowed barang = model.borrowedRiwayat[index];
                  return BarangItem(
                    nama: barang.nama,
                    namaMember: barang.namaMember,
                    totalBiaya: barang.total_biaya,
                    tanggalTempo: barang.tanggalTempo,
                    image: NetworkImage(linkImage + barang.gambar),
                    stock: barang.stock,
                    endIcon: EndIcon.Borrowing,
                  );
                },
              );
  }
}

class AllBarangRiwayat extends StatelessWidget {
  AllBarangRiwayat(this.model);
  final RiwayatProvider model;
  @override
  Widget build(BuildContext context) {
    return model.state == ViewState.Busy
        ? Center(child: CircularProgressIndicator())
        : model.allRiwayat == null
            ? NoBarangBg()
            : ListView.builder(
                itemCount: model.allRiwayat.length,
                itemBuilder: (context, index) {
                  BarangBorrowed barang = model.allRiwayat[index];
                  EndIcon buildEnd() {
                    if (barang.status == 2) {
                      return EndIcon.Done;
                    } else if (barang.status == 3) {
                      return EndIcon.Cancelled;
                    } else if (barang.status == 1) {
                      return EndIcon.Borrowing;
                    } else if (barang.status == 0) {
                      return EndIcon.Confirming;
                    }
                    return null;
                  }

                  return BarangItem(
                    nama: barang.nama,
                    namaMember: barang.namaMember,
                    totalBiaya: barang.total_biaya,
                    image: NetworkImage(linkImage + barang.gambar),
                    stock: barang.stock,
                    endIcon: buildEnd(),
                  );
                },
              );
  }
}

class NoBarangBg extends StatelessWidget {
  const NoBarangBg({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'belum ada item :(',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Styles.darkPurple,
          ),
        ),
        SvgPicture.asset('images/bg_empty.svg', width: 200),
      ],
    ));
  }
}
