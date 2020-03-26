import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController cText;

  final String hintText;

  final TextInputType keyboardType;
  final bool isPassword;

  const TextFieldWidget({this.cText, this.hintText, this.keyboardType, this.isPassword = false});

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool passwordVisible;
  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              alignment: Alignment.bottomCenter,
              width: mq.width * 0.7,
              height: 30,
              child: TextField(
                obscureText: widget.isPassword ? !passwordVisible : false,
                keyboardType: widget.keyboardType,
                style: GoogleFonts.lato(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                controller: widget.cText,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.lato(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            widget.isPassword
                ? InkWell(
                    child: Icon(
                      passwordVisible ? Icons.visibility_off : Icons.visibility,
                    ),
                    onTap: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  )
                : Container()
          ],
        ),
        Divider(
          color: Color(0xFF5F518A),
          thickness: 0.5,
          height: 0,
        )
      ],
    );
  }
}
