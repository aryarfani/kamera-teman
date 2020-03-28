import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppHeader extends StatelessWidget {
  const AppHeader(
      {@required this.mq,
      @required this.title,
      @required this.widget,
      this.topPadding,
      this.callback,
      this.iconAdd = true,
      this.isRegisterScreen = false});

  final double topPadding;
  final Size mq;
  final String title;
  final Widget widget;
  final Function callback;
  final bool iconAdd;
  final bool isRegisterScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFFE7F3FF), Colors.lightBlue[50]],
              begin: FractionalOffset(0, 0),
              end: FractionalOffset(0, 1),
              stops: [0.0, 1.0])),
      padding: EdgeInsets.only(left: mq.width * 0.08, right: mq.width * 0.08, top: mq.height * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: topPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF403269),
                ),
              ),
              InkWell(
                child: Container(
                  padding: EdgeInsets.all(4),
                  child: iconAdd ? Icon(Icons.add_circle_outline, color: Color(0xFF403269)) : SizedBox(height: 35),
                ),
                onTap: callback,
              )
            ],
          ),
          SizedBox(height: 10),
          Container(
            constraints: isRegisterScreen ? null : BoxConstraints(maxHeight: mq.height * 0.85),
            child: widget,
          )
        ],
      ),
    );
  }
}
