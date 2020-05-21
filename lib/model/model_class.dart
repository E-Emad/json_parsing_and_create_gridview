class BookModel {
  int count;
  var next;
  var previous;
  List<_Result> _results = [];

  BookModel.fromJson(Map<String, dynamic> parsedJson) {

    count = parsedJson['count'];
    next = parsedJson['next'];
    previous = parsedJson['previous'];
    List<_Result> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      _Result result = _Result(parsedJson['results'][i]);
      temp.add(result);
    }
    _results = temp;
//    print("==================>>${_results.length}");
  }

  List<_Result> get myResult => _results;

  String get _previous => previous;

  String get _next => next;

  int get _count => count;
}


class _Result {
  var bookTitle;
  var bookImage;
  var bookHtml;
  var bookPdf;
  var bookText;
  List<String> bookaAthors = [];

  _Result(result) {
    bookTitle = result['title'];
    bookImage = result['formats']['image/jpeg'];
    bookHtml = result['formats']['text/html; charset=utf-8'];
    bookPdf = result['formats']['application/pdf'];
    bookText = result['formats']['text/plain; charset=utf-8'];
     for (int i = 0; i < result['authors'].length; i++) {
//      print("================>>>>>${result['authors'][i]['name']}");
      bookaAthors.add(result['authors'][i]['name']);
    }

  }


  List<String> get getAuther => bookaAthors;

  String get getText => bookText;

  String get getPdf => bookPdf;

  String get getHtml => bookHtml;

  String get getImage => bookImage;

  String get getTitle => bookTitle;

}