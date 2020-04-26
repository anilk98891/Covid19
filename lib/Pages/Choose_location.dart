import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:worldtimeapp/Model/CoronaCountryModel.dart';
import 'package:worldtimeapp/Model/IndianStatesData.dart';
import 'package:worldtimeapp/Pages/SearchBarClass.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<CronaCases> cronaList;

  void updateTime(index) async {
    CronaCases instance = cronaList[index];

    if(cronaList[index].country == "India") {
      dynamic object = await Navigator.pushNamed(context, '/indianstate');
      if(object != null) {
        Navigator.pop(context, object);
      }
    } else {
      Navigator.pop(context, instance);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cronaList = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: SearchClass(countrydata: cronaList));
              })
        ],
      ),
      body: ListView.builder(
          itemCount: cronaList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
              child: Card(
                  child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(cronaList[index].country),
                leading: CachedNetworkImage(
                  width: 50,
                  height: 50,
                  imageUrl: cronaList[index].countryInfo['flag'],
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              )),
            );
          }),
    );
  }
}
