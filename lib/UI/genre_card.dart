import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ignitesolutiontask/Screens/book_data.dart';
import 'package:ignitesolutiontask/UI/route_animation.dart';

import 'color_page.dart';

class GenreCard extends StatelessWidget{
   var cardSvg;
   var bookName;
   var url;

   GenreCard({
     @required this.cardSvg,
     @required this.bookName,
     @required this.url
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: (){
        Navigator.push(context, SizeRoute(
            page: BookData(
              appBarTitle: bookName,
              apiUrl: url,
            )
        ));
      },
      child: Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [BoxShadow(
                  color: AllColors.greyDarkColor,
                  offset: Offset(4, 5),
                  blurRadius: 5
              )]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 15),
                child: Container(
                  width: MediaQuery.of(context).size.width /1.8,
                  child: Row(
                    children: <Widget>[
                      SvgPicture.asset(cardSvg,height: 30,),
                      Container(width: 10,),
                      AutoSizeText(bookName,style: GoogleFonts.montserrat(fontSize: 18,fontWeight: FontWeight.w500),)
                    ],
                  ),
                ),),

              Padding(padding: EdgeInsets.only(right: 15),child: SvgPicture.asset("assets/Next.svg"),)
            ],
          ),
        ),),
    );
  }
}

