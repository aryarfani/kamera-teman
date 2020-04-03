import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman/core/utils/router.dart';

// insertchart
class HomeScreen extends StatelessWidget {
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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE7F3FF), Colors.lightBlue[50]],
                begin: FractionalOffset(0, 0),
                end: FractionalOffset(0, 1),
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
                        Text(
                          'Dashboard',
                          style: GoogleFonts.montserrat(
                            fontSize: 27,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF403269),
                          ),
                        ),
                        Text(
                          'Kamera Teman',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF403269),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white, width: 3, style: BorderStyle.solid),
                        image: DecorationImage(
                          image: AssetImage('images/2.jpg'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ItemDashboardPutih(
                  mq: mq,
                  icon: Icons.storage,
                  title: 'Barang',
                  tapCallback: () {
                    Navigator.pushNamed(context, RouteName.barangList);
                  },
                  children: <Widget>[
                    ItemRow(title: 'Total Barang', subtitle: '28 Barang'),
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
                      color: Color(0xFFF8801D),
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
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Terbaru :',
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          'Sora aoi',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    ItemDashboardBasic(
                      mq: mq,
                      color: Color(0xFF0FB8C6),
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
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Terbaru :',
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          'Emi Fukada',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
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
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 0.5,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
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
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 0.5,
              blurRadius: 5,
              offset: Offset(0, 1),
            ),
          ],
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
                color: Colors.white70,
                size: 30,
              ),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white70,
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
