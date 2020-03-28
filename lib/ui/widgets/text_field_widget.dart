import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController cText;
  final String hintText;
  final TextInputType keyboardType;
  final bool isPassword;
  final Function validator;
  final bool isTheLast;

  TextFieldWidget(
      {this.cText, this.validator, this.hintText, this.keyboardType, this.isPassword = false, this.isTheLast = false});

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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              alignment: Alignment.bottomCenter,
              width: mq.width * 0.77,
              height: 30,
              child: TextFormField(
                validator: widget.validator,
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
                  hintStyle: GoogleFonts.lato(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
                textInputAction: widget.isTheLast ? TextInputAction.done : TextInputAction.next,
                onFieldSubmitted: (_) =>
                    widget.isTheLast ? FocusScope.of(context).unfocus() : FocusScope.of(context).nextFocus(),
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
      ],
    );
  }
}
