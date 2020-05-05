import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman/core/providers/admin_provider.dart';
import 'package:kamera_teman/core/providers/barang_provider.dart';
import 'package:kamera_teman/core/providers/member_provider.dart';
import 'package:kamera_teman/core/providers/riwayat_provider.dart';
import 'package:kamera_teman/core/utils/constant.dart';
import 'package:kamera_teman/core/utils/router.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 0),
        child: Visibility(
          visible: false,
          child: AppBar(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              height: mq.height,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: _buildHeader(mq),
                  ),
                  _buildListMenu(mq, context)
                ],
              )),
        ),
      ),
    );
  }

  Container _buildHeader(Size mq) {
    return Container(
      height: mq.height / 3,
      width: mq.width,
      padding: EdgeInsets.only(top: mq.height / 9 - 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          //* making oval shape
          bottomLeft: Radius.elliptical(150, 5),
          bottomRight: Radius.elliptical(150, 5),
        ),
        gradient: LinearGradient(
          colors: [Styles.darkPurple.withOpacity(0.7), Styles.darkPurple],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Kamera Teman',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          Text(
            'Dashboard',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Positioned _buildListMenu(Size mq, BuildContext context) {
    return Positioned(
      top: mq.height / 3 - 70,
      width: mq.width,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Consumer<RiwayatProvider>(
                  builder: (context, model, _) {
                    if (model.unconfirmedRiwayat == null) {
                      model.getUnconfirmedRiwayat();
                    }
                    return _buildMenuItem(
                      mq: mq,
                      title: 'Transaksi',
                      icon: Icons.storage,
                      color: Colors.blueAccent,
                      subtitle: 'Konfirmasi ',
                      subtitleTrailing: model.unconfirmedRiwayat != null ? model.unconfirmedRiwayat.length : 0,
                      callback: () {
                        Navigator.pushNamed(context, RouteName.riwayat);
                      },
                    );
                  },
                ),
                SizedBox(width: 20),
                Consumer<BarangProvider>(
                  builder: (context, model, _) {
                    if (model.barangs == null) {
                      model.getBarangs();
                    }
                    return _buildMenuItem(
                      mq: mq,
                      title: 'Inventory',
                      icon: Icons.store,
                      color: Colors.purple,
                      subtitle: 'Total ',
                      subtitleTrailing: model.barangs != null ? model.barangs.length : 0,
                      callback: () {
                        Navigator.pushNamed(context, RouteName.barangList);
                      },
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Consumer<MemberProvider>(
                  builder: (context, model, _) {
                    if (model.members == null) {
                      model.getMembers();
                    }
                    return _buildMenuItem(
                      mq: mq,
                      title: 'Member',
                      icon: Icons.group,
                      color: Colors.yellow[900],
                      subtitle: 'Total ',
                      subtitleTrailing: model.members != null ? model.members.length : 0,
                      callback: () {
                        Navigator.pushNamed(context, RouteName.memberList);
                      },
                    );
                  },
                ),
                SizedBox(width: 20),
                Consumer<AdminProvider>(
                  builder: (context, model, _) {
                    if (model.admins == null) {
                      model.getAdmins();
                    }
                    return _buildMenuItem(
                      mq: mq,
                      title: 'Admin',
                      icon: Icons.group_work,
                      color: Colors.green,
                      callback: () {
                        Navigator.pushNamed(context, RouteName.adminList);
                      },
                      subtitle: 'Total ',
                      subtitleTrailing: model.admins != null ? model.admins.length : 0,
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                _buildMenuItem(
                  mq: mq,
                  title: 'Laporan',
                  icon: Icons.group,
                  color: Colors.red[600],
                  callback: () {
                    Navigator.pushNamed(context, RouteName.laporan);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      {Size mq, String title, IconData icon, Color color, Function callback, String subtitle, var subtitleTrailing}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: Styles.boxShadow,
          color: Colors.white,
        ),
        height: mq.height / 5 + 10,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: callback,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: color.withOpacity(0.2),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 20,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    title,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 5),
                  subtitle == null
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              subtitle,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(width: 2),
                            Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.grey[200],
                              ),
                              child: Text(
                                subtitleTrailing.toString(),
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
