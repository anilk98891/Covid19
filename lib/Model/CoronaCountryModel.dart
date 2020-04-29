import 'package:intl/intl.dart';

class CronaCasesParentObject {
  List<CronaCases> data;
  CronaCasesParentObject({this.data});

  CronaCasesParentObject.fromJson(Map<String, dynamic> json)
      : data = json['data']
            .map<CronaCases>((i) => CronaCases.fromJson(i))
            .toList();

}

class CronaCases {
  int updated;
  String country;
  Map countryInfo;
  int cases;
  int todayCases;
  int todayDeaths;
  int recovered;
  int active;
  int critical;
  int tests;
  int confirmed;
  String countryCode;
  bool isDateTime;
  String timeNow;
  int deaths;

  CronaCases(
      {this.updated, //location name for the ui
      this.country, // the time in that location
      this.countryInfo, //url to asset flag
      this.cases,
      this.todayCases,
      this.todayDeaths,
      this.recovered,
      this.active,
      this.critical,
      this.tests,
      this.confirmed,
      this.countryCode,
      this.timeNow,this.deaths});

  CronaCases.fromJson(Map<String, dynamic> json)
      : updated = json['updated'],
        country = json['country'],
        countryInfo = json['countryInfo'],
        cases = json['cases'],
        todayCases = json['todayCases'],
        todayDeaths = json['todayDeaths'],
        recovered = json['recovered'],
        active = json['active'],
        critical = json['critical'],
        tests = json['tests'],
        confirmed = json['confirmed'],
        countryCode = json['countryCode'],
        deaths = json['deaths'],
        timeNow = getTime(json['updated']);

  static String getTime(date) {
    DateTime now = DateTime.fromMicrosecondsSinceEpoch(date * 1000);
    String formattedDate = DateFormat('hh:mm a').format(now);
    return formattedDate;
  }
}
