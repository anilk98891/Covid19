import 'package:http/http.dart';
import 'dart:convert';

  Future<dynamic> getCases() async {

    try {
      Response response = await get(
          'https://corona-stats.online/?format=json&source=2');
      return (jsonDecode(response.body));
    }
    catch(e) {
      print(e);
    }
  }

Future<dynamic> getIndianCases() async {
  try {
    Response response = await get(
        'https://covid-19-india-data-by-zt.p.rapidapi.com/GetIndiaStateWiseData',headers: {
          "x-rapidapi-host": "covid-19-india-data-by-zt.p.rapidapi.com",
    "x-rapidapi-key": "4e079167d2msh41ef332fac015c0p1be56ajsn9954360344e2" },);
    return (jsonDecode(response.body));
  }
  catch(e) {
    print(e);
  }
}
