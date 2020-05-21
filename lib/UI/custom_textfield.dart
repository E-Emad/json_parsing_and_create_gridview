import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_page.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    this.hintText,
    this.textEditingController,
    this.bordercolor,
    this.enabledcolor,
   });


  final String hintText;
  final TextEditingController textEditingController;
  final Color bordercolor;
  final Color enabledcolor;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: TextFormField(
         controller: widget.textEditingController,
         decoration: InputDecoration(
           errorStyle: GoogleFonts.roboto(color: Colors.red,
            fontSize: 14),
          contentPadding: const EdgeInsets.all(15.0),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(
              color: widget.bordercolor),
          ),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(
              color: widget.enabledcolor),
          ),
          errorBorder: OutlineInputBorder(borderSide: BorderSide(
              color: Colors.red)),
          hintText: widget.hintText,
          hintStyle: GoogleFonts.montserrat(color: AllColors.greyDarkColor,
              fontSize: 14),
        ),
      ),
    );
  }
}