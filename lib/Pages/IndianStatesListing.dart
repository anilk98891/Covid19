import 'package:flutter/material.dart';
import 'package:worldtimeapp/Model/IndianStatesData.dart';
import 'package:worldtimeapp/Pages/SearchBarClassIndianStates.dart';
import 'package:worldtimeapp/Services/World_time.dart';
import 'package:worldtimeapp/SupportingClasses/LoadingScreen.dart';

class IndianListingScreen extends StatefulWidget {
  @override
  _IndianListingScreenState createState() => _IndianListingScreenState();
}

class _IndianListingScreenState extends State<IndianListingScreen> {
  IndianStatesModel instance;
  List<IndianState> indianStateList;

  Future<void> fetchIndianStateData() async {
    dynamic object = await getIndianCases();
    instance = IndianStatesModel.fromJson(object);
//    instance.data.sort((a, b) => int.parse(a.country).compareTo(int.parse(b.country)));
    setState(() {
      indianStateList = instance.data;
    });
    print('india');
  }

  void updateTime(index) async {
    IndianState instance = indianStateList[index];
    Navigator.pushNamed(context, '/home',arguments: instance);
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchIndianStateData();
  }
  @override
  Widget build(BuildContext context) {
    if(indianStateList == null) {
      return LoaderScreen(serverIP: "Fetching your states..");
    }
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () async {
                setState(() {
                  indianStateList = null;
                });
                fetchIndianStateData();
              }),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: SearchClassIndian(countrydata:indianStateList)
                );
              })
        ],
      ),
      body: ListView.builder(
          itemCount: indianStateList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
              child: Card(
                  child: ListTile(
                    onTap: () {
                      updateTime(index);
                    },
                    title: Text(indianStateList[index].country),
                    leading: Icon(Icons.place)
                  )),
            );
          }),
    );
  }
}
