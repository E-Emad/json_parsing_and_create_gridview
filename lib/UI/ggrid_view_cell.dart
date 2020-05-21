import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_page.dart';

class GridViewCell extends StatelessWidget{
  var bookImageUrl;
  var bookTitle;
  var bookAuther;

  GridViewCell({
    this.bookImageUrl,
    this.bookTitle,
    this.bookAuther
});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  new Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 180,
            child: bookImageUrl == null ||
                bookImageUrl == ""
                ? ClipRRect(
              child: Image.asset(
                "assets/no_image.png",
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(15),
            )
                : ClipRRect(
              child: Image.network(
                bookImageUrl,
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          AutoSizeText(
            bookTitle,
            style: GoogleFonts.montserrat(
                color: AllColors.greyExtraDarkColor),
            overflow: TextOverflow.ellipsis,
          ),
          AutoSizeText(
            bookAuther,
            style: GoogleFonts.montserrat(
                color: AllColors.greyDarkColor),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}