import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ignitesolutiontask/UI/color_page.dart';
import 'package:http/http.dart' as http;
import 'package:ignitesolutiontask/UI/ggrid_view_cell.dart';
import 'package:ignitesolutiontask/UI/responsive_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class BookData extends StatefulWidget {
  var appBarTitle;
  var apiUrl;
  BookData({this.appBarTitle,this.apiUrl});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BookData();
  }
}

class _BookData extends State<BookData> {


  TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List bookData = new List();

  bool loading;

  var result = [];
  var bookTitle = [];
  var bookAuther = [];
  var bookImages = [];
  var bookHtmlData = [];
  var bookPdfData = [];
  var bookTextData = [];

  Icon _searchIcon = new Icon(Icons.search,color: AllColors.greyDarkColor,);

  @override
  void initState() {
    setState(() {
      this.bookesTypesData();
    });
    loading = true;
    // TODO: implement initState
    super.initState();
  }


  _BookData() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          result = bookData;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
          print("===Searchtext:$_searchText");
        });
      }
    });
  }


  Future bookesTypesData() async {
    var url = "http://skunkworks.ignitesol.com:8000/books/?topic=${widget.apiUrl}";
    try{
      final response = await http.get(url);
      setState(() {
        var resultBody = json.decode(response.body);
        result = resultBody['results'];
        loading = false;
      });
      bookData = result;
      for (int i = 0; i < result.length; i++) {
        bookTitle.add(result[i]["title"]);
        bookImages.add(result[i]['formats']['image/jpeg']);
        bookHtmlData.add(result[i]['formats']['text/html; charset=utf-8']);
        bookPdfData.add(result[i]['formats']['application/pdf']);
        bookTextData.add(result[i]['formats']['text/plain; charset=utf-8']);
        for (var bookAutherName in result[i]['authors']) {
          bookAuther.add(bookAutherName['name']);
        }
      }
    } catch(_) {
      showErrormessage(context,"Sorry","Something Wrong");
    }
  }


  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close,color: AllColors.greyDarkColor,);
       } else {
        this._searchIcon = new Icon(Icons.search,color:  AllColors.greyDarkColor,);
        result = bookData;
        _filter.clear();
      }
    });
  }

  Widget _buildGridView(){
    if(!(_searchText.isEmpty)){
      List tempList = new List();
      for (int i = 0; i < result.length; i++) {
        if (result[i]["title"].toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(result[i]);
        }
//        else if (bookAuther[i]["name"].toLowerCase().contains(_searchText.toLowerCase())) {
//          tempList.add(result[i]);
//        }
      }
      result = tempList;
     }
    return Scrollbar(child: result.length > 0
        ?
    new StaggeredGridView.countBuilder(
      crossAxisCount: ResponsiveWidget.issmallScreen(context) ? 6 : 8,
      itemCount: result.length,
      itemBuilder: (BuildContext context, int index) =>
          InkWell(
              onTap: (){
                if(bookHtmlData[index] != null || bookHtmlData[index] != ""){
                  launchURL(bookHtmlData[index]);
                } else  if(bookPdfData[index] != null || bookPdfData[index] != ""){
                  launchURL(bookPdfData[index]);
                }else  if(bookTextData[index] != null || bookTextData[index] != ""){
                  launchURL(bookTextData[index]);
                } else {
                  showErrormessage(context,"Sorry","No HTML, PDF and Text content is found for this book");
                }
              },
              child: GridViewCell(
                bookImageUrl: bookImages[index],
                bookTitle: bookTitle[index],
                bookAuther: bookAuther[index],
              )
          ),
      staggeredTileBuilder: (int index) =>
      new StaggeredTile.count(2, index.isEven ? 4 : 4),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    )
        :
    Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 1.2,
          height: 150,
          child: Center(
            child: Text("No data found",style: GoogleFonts.montserrat(fontSize: 24,color: AllColors.iconColors),)
          )
        )
    )
    );
  }

  launchURL(var url) async {
     if (await canLaunch(url)) {
      await launch(url);
    } else {
       showErrormessage(context,"Sorry","No HTML, PDF and Text content is found for this book");
    }
  }

  showErrormessage(BuildContext context, var textData, var textContent) {
     Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
     AlertDialog alert = AlertDialog(
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(5)
       ),
      title: Text(textData, style: GoogleFonts.montserrat(color: AllColors.iconColors),),
      content: Text(textContent,style: GoogleFonts.montserrat(color: AllColors.greyExtraDarkColor),),
      actions: [
        okButton,
      ],
    );
     showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: width,
        child: Column(
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: AllColors.iconColors,
                    size: 30,
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                  }),
              title: AutoSizeText(
                widget.appBarTitle,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    color: AllColors.iconColors,
                    fontSize: 22),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                height: 50,
                child: TextField(
                  onTap: _searchPressed,
                  controller: _filter,
                  decoration: InputDecoration(
                    prefixIcon: _searchIcon,
                    contentPadding: EdgeInsets.all(15.0),
                    hintText: "Search",
                    hintStyle: GoogleFonts.montserrat(
                        color: AllColors.greyDarkColor,
                        fontWeight: FontWeight.w500),
                    filled: true,
                    fillColor: AllColors.greyLightColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AllColors.greyLightColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AllColors.greyLightColor),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 10,
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Container(
                      color: AllColors.bgColors,
                      child: loading ? Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircularProgressIndicator(
                                  backgroundColor: AllColors.iconColors,
                                ),
                                Container(
                                  width: 10,
                                ),
                                Text("Fetching data",style: GoogleFonts.montserrat(fontSize: 24,color: AllColors.iconColors),)
                              ],
                            ),
                          )
                      ) :
                          _buildGridView()
                    )))
          ],
        ),
      )),
    );
  }
}
