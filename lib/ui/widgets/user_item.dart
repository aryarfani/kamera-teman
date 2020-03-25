import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserItem extends StatelessWidget {
  final NetworkImage gambar;
  final String nama;
  final String alamat;

  const UserItem({this.gambar, this.nama, this.alamat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      // margin: EdgeInsets.only(bottom: 10),
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
              image: gambar,
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(nama,
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF403269),
                  )),
              Text(alamat,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF776A9E),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
