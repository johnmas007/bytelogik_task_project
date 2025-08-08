import 'package:bytelogik_task/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondaryButton extends StatefulWidget {
  const SecondaryButton({super.key, required this.onTap, required this.title, });

  final Function onTap;
  final String title;

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return InkWell(
      onTap: (){
        widget.onTap();
      },
      child: Container(
        height: height/16.8,
        width: width * 0.42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Constants.lightGrey,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                 widget.title,
                style: GoogleFonts.poppins(
                  color: Constants.bodyTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: width/25.71428571428571,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
