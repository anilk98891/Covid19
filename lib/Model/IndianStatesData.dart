import 'package:intl/intl.dart';

class IndianStatesModel {
  List<IndianState> data;
  IndianStatesModel({this.data});

  IndianStatesModel.fromJson(Map<String, dynamic> json)
      : data = json['data']
            .map<IndianState>((i) => IndianState.fromJson(i))
            .toList();
}

class IndianState {
  String country;
  Map countryInfo;
  String cases;
  String todayCases;
  String todayDeaths;
  String recovered;
  String active;
  String confirmed;
  String countryCode;
  String newrecovered;
  String timeNow;
  String deaths;
  String updated;

  IndianState(
      {this.country, //location name for the ui
      this.cases, // the time in that location
      this.todayCases, //url to asset flag
      this.todayDeaths,
      this.recovered,
      this.active,
      this.confirmed,
      this.countryCode,
      this.newrecovered,
      this.timeNow,
      this.deaths,
      this.updated});

  IndianState.fromJson(Map<String, dynamic> json)
      : country = json['name'],
        cases = json['confirmed'],
        todayCases = json['newconfirmed'],
        todayDeaths = json['newdeaths'],
        recovered = json['recovered'],
        active = json['active'],
        confirmed = json['confirmed'],
        countryCode = json['countryCode'],
        newrecovered = json['newrecovered'],
        deaths = json['deaths'],
        updated = json['lastupdatedtime'],
        timeNow = getTime(json['lastupdatedtime']);

  static String getTime(date) {
    DateTime now = DateTime.parse(date);
    String formattedDate = DateFormat('hh:mm a').format(now);
    return formattedDate;
  }
}
