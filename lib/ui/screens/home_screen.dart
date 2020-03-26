import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman/utils/router.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE7F3FF), Colors.lightBlue[50]],
              begin: FractionalOffset(0, 0),
              end: FractionalOffset(0, 1),
              stops: [0.0, 1.0],
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: width * 0.08, vertical: height * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Dashboard \nKamera Teman ',
                  style: GoogleFonts.montserrat(
                    fontSize: 27,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF403269),
                  )),
              SizedBox(height: 20),
              SvgPicture.asset(
                'images/gambar_camera.svg',
                fit: BoxFit.contain,
                height: height * 0.3,
              ),
              SizedBox(height: 30),
              ItemBox(
                title: 'Daftar Barang',
                icon: Icons.camera_alt,
                tapCallback: () {
                  Navigator.pushNamed(context, RouteName.barangList);
                },
              ),
              SizedBox(height: 15),
              ItemBox(
                title: 'Daftar Pelanggan',
                icon: Icons.group,
                tapCallback: () {
                  Navigator.pushNamed(context, RouteName.memberList);
                },
              ),
              SizedBox(height: 15),
              ItemBox(
                title: 'Daftar Admin',
                icon: Icons.security,
                tapCallback: () {
                  Navigator.pushNamed(context, RouteName.adminList);
                },
              ),
              SizedBox(height: 15),
              ItemBox(
                title: 'Laporan',
                icon: Icons.format_align_left,
                tapCallback: () {
                  Navigator.pushNamed(context, RouteName.laporan);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemBox extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function tapCallback;

  const ItemBox({this.title, this.icon, this.tapCallback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapCallback,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 0.5,
              blurRadius: 2,
              offset: Offset(0, 0.2),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: Color(0xFF6C63FF),
            size: 35,
          ),
          title: Text(
            title,
            style: GoogleFonts.lato(
              fontSize: 23,
              fontWeight: FontWeight.w600,
              color: Color(0xFF665CA9),
            ),
          ),
        ),
      ),
    );
  }
}
