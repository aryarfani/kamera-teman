import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LaporanScreen extends StatelessWidget {
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
          padding: EdgeInsets.only(
            left: width * 0.08,
            right: width * 0.08,
            top: height * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('Laporan Kamera Teman',
                  style: GoogleFonts.montserrat(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF403269),
                  )),
              SizedBox(height: 20),
              DataTable(
                sortColumnIndex: 1,
                columns: [
                  DataColumn(label: Text('No')),
                  DataColumn(label: Text('Tanggal')),
                  DataColumn(label: Text('Peminjaman')),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Text('16-3-2020')),
                    DataCell(Text('Rp.230.000,-')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('2')),
                    DataCell(Text('17-3-2020')),
                    DataCell(Text('Rp.150.000,-')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('3')),
                    DataCell(Text('18-3-2020')),
                    DataCell(Text('Rp.100.000,-')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('4')),
                    DataCell(Text('19-3-2020')),
                    DataCell(Text('Rp.250.000,-')),
                  ]),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Jumlah',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF403269),
                      )),
                  Text('Rp. 730.000,-',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF403269),
                      )),
                ],
              ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text('Cetak Laporan',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF403269),
                    )),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.all(15.0),
                color: Colors.white,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
