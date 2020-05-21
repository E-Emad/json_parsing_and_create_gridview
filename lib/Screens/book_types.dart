import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ignitesolutiontask/Screens/book_data.dart';
import 'package:ignitesolutiontask/UI/color_page.dart';
import 'package:ignitesolutiontask/UI/genre_card.dart';
 import 'package:ignitesolutiontask/UI/route_animation.dart';

class BookTypes extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BookTypes();
  }
}

class _BookTypes extends State<BookTypes>{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AllColors.greyLightColor,
      body: SafeArea(child: Container(
        width: width,
        child: Column(
          children: <Widget>[
            Container(
              height: height / 2.5,
              width: width,
               child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  SvgPicture.asset("assets/Pattern.svg",fit: BoxFit.fill,),
                  Column(
                     children: <Widget>[
                      Container(
                        height: 15,
                      ),
                      Padding(padding: EdgeInsets.only(left: 10),
                        child: AutoSizeText(
                          "Gutenberg Project", style: GoogleFonts.montserrat(fontSize: 48,color: AllColors.iconColors),
                        ),),
                      Container(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.only(left: 10),
                        child: AutoSizeText(
                          "A social cataloging website that allows you to freely search its database of books, annotations, and reviews.", style: GoogleFonts.montserrat(fontSize: 20,color: AllColors.greyExtraDarkColor),
                        ),)
                    ],
                  ),
                ],
              )
            ),
            Expanded(child:
            ListView(
              children: <Widget>[
                GenreCard(cardSvg: "assets/Fiction.svg", bookName :"Fiction", url: "fiction"),
                GenreCard(cardSvg: "assets/Drama.svg",bookName :"DRAMA",url:"drama"),
                GenreCard(cardSvg:"assets/Humour.svg",bookName :"HUMOR",url: "humor"),
                GenreCard(cardSvg:"assets/Politics.svg",bookName :"POLITICS",url: "politics"),
                GenreCard(cardSvg:"assets/Philosophy.svg",bookName :"PHILOSOPHY",url: "philosophy"),
                GenreCard(cardSvg:"assets/History.svg",bookName :"HISTORY",url: "history"),
                GenreCard(cardSvg:"assets/Adventure.svg",bookName :"ADVENTURE",url: "adventure"),
              ],
            ))
          ])
      ))
    );
  }
}