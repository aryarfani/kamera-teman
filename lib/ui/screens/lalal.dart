import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman/core/providers/auth_provider.dart';
import 'package:kamera_teman/core/utils/constant.dart';
import 'package:kamera_teman/core/utils/router.dart';
import 'package:provider/provider.dart';

// insertchart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Consumer<AuthProvider>(
      builder: (context, model, child) {
        if (model.currentAdmin == null) {
          model.getCurrentAdminData();
        }
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(0, 0),
            child: Visibility(
              visible: false,
              child: AppBar(),
            ),
          ),
          body: model.currentAdmin == null
              ? Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Styles.darkPurple, Colors.white],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 1.0],
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: mq.width * 0.05, vertical: mq.height * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, RouteName.dashboard);
                                    },
                                    child: Text(
                                      'Dashboard',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 27,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Kamera Teman',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(RouteName.profile);
                                },
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(color: Colors.white, width: 3, style: BorderStyle.solid),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(model.currentAdmin.gambar),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          ItemDashboardPutih(
                            mq: mq,
                            icon: Icons.storage,
                            title: 'Transaksi',
                            tapCallback: () {
                              Navigator.pushNamed(context, RouteName.barangList);
                            },
                            children: <Widget>[
                              ItemRow(title: 'Total Transaksi', subtitle: '28 Transaksi'),
                              SizedBox(height: 10),
                              Row(
                                children: <Widget>[
                                  Expanded(child: ItemRow(title: 'Konfirmasi', subtitle: '3 Barang')),
                                  Expanded(child: ItemRow(title: 'Dipinjam', subtitle: '9 Barang')),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              ItemDashboardBasic(
                                mq: mq,
                                color: Colors.white,
                                title: 'Total Member',
                                tapCallback: () {
                                  Navigator.pushNamed(context, RouteName.memberList);
                                },
                                children: <Widget>[
                                  SizedBox(height: 10),
                                  Text(
                                    '20',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF2A436C),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    'Terbaru :',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  Text(
                                    'Bambang Rino',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF2A436C),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              ItemDashboardBasic(
                                mq: mq,
                                color: Colors.white,
                                title: 'Total Admin',
                                tapCallback: () {
                                  Navigator.pushNamed(context, RouteName.adminList);
                                },
                                children: [
                                  SizedBox(height: 12),
                                  Text(
                                    '3',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF2A436C),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    'Terbaru :',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  Text(
                                    'Rina Fukada',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF2A436C),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          ItemDashboardPutih(
                            mq: mq,
                            icon: Icons.insert_chart,
                            title: 'Laporan',
                            tapCallback: () {
                              Navigator.pushNamed(context, RouteName.laporan);
                            },
                            children: <Widget>[
                              SizedBox(height: 10),
                              Row(
                                children: <Widget>[
                                  Expanded(child: ItemRow(title: 'Total Pemasukan Sebulan', subtitle: 'Rp 980.000,-')),
                                  Expanded(child: ItemRow(title: 'Total Pemasukan Seminggu', subtitle: 'Rp 320.000,-')),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class ItemDashboardPutih extends StatelessWidget {
  const ItemDashboardPutih({
    @required this.mq,
    this.children,
    this.icon,
    this.title,
    this.tapCallback,
  });

  final Size mq;
  final List<Widget> children;
  final IconData icon;
  final String title;
  final Function tapCallback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapCallback,
      child: Container(
        width: mq.width - 40,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: Styles.boxShadow,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey[200],
                  ),
                  child: Icon(
                    icon,
                    color: Color(0xFF2A436C),
                    size: 30,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2A436C),
                  ),
                ),
              ],
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}

class ItemRow extends StatelessWidget {
  final String title;
  final String subtitle;

  const ItemRow({@required this.title, @required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black45,
          ),
        ),
        SizedBox(height: 5),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2A436C),
          ),
        ),
      ],
    );
  }
}

class ItemDashboardBasic extends StatelessWidget {
  const ItemDashboardBasic({
    @required this.mq,
    @required this.color,
    @required this.title,
    @required this.children,
    this.tapCallback,
  });

  final Size mq;
  final Color color;
  final String title;
  final List<Widget> children;
  final Function tapCallback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapCallback,
      child: Container(
        width: mq.width / 2 - 25,
        height: mq.height / 3 - 10,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color,
          boxShadow: Styles.boxShadow,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white10,
              ),
              child: Icon(
                Icons.people,
                color: Color(0xFF2A436C),
                size: 30,
              ),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black45,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            )
          ],
        ),
      ),
    );
  }
}
