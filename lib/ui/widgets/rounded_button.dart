import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color;
  final Color textColor;

  const RoundedButton({this.text, this.onPressed, this.color, this.textColor});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      padding: EdgeInsets.all(13.0),
      child: Text(
        text,
        style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w600),
      ),
      color: color != null ? color : Color(0xFFFF7F56),
      textColor: textColor != null ? textColor : Colors.white,
      onPressed: onPressed,
    );
  }
}
