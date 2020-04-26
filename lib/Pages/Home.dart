import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:worldtimeapp/Model/CoronaCountryModel.dart';
import 'package:worldtimeapp/Model/IndianStatesData.dart';
import 'package:worldtimeapp/Pages/PrecautionCare.dart';
import 'package:worldtimeapp/Services/World_time.dart';
import 'package:worldtimeapp/SupportingClasses/LoadingScreen.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<CronaCases> coronaTotalCasesObject;
  CronaCasesParentObject instance;
  bool refreshClicked = false;
  String currentCountry = "USA";
  dynamic data;
  IndianState stateData;

  void getCurrentLocation() async {
      try {
        Position position = await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
        List<Placemark> placeMark = await Geolocator()
            .placemarkFromCoordinates(position.latitude, position.longitude);
        if (placeMark.length > 0) {
          currentCountry = placeMark[0].country;
        }
        setState(() {
          data = getObjectOFCountry();
        });
      } catch (e) {
        setState(() {
          data = getObjectOFCountry();
        });
      }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentLocation();
  }
  CronaCases getObjectOFCountry(){
    dynamic object = coronaTotalCasesObject.firstWhere((item) => currentCountry == (item.country));
    return object;
  }
  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context).settings.arguments is IndianState){
      data = ModalRoute.of(context).settings.arguments;
    } else {
      coronaTotalCasesObject = ModalRoute
          .of(context)
          .settings
          .arguments;
    }
    if(data == null) {
      return LoaderScreen(serverIP: "Fetching your location");
    }
    data = data == null ? (currentCountry == null ? coronaTotalCasesObject[0] : getObjectOFCountry()) : data;
    Color bgColor = false ? Colors.blue : Colors.black;
    if (refreshClicked) {
      return LoaderScreen(serverIP: "Fetching updated Data..");
    } else {
      return Scaffold(
        bottomNavigationBar: ModalRoute.of(context).settings.arguments is IndianState ? null : customBottomBar(),
          appBar: AppBar(
            backgroundColor: Colors.grey[800],
            title: Text('Corona Cases'),
            actions: <Widget>[
              (ModalRoute.of(context).settings.arguments is IndianState || _selectedIndex == 1) ? SizedBox(width: 0,) : IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () async {
                    this.setState(() {
                      refreshClicked = true;
                    });
                    dynamic object = await getCases();
                    instance = CronaCasesParentObject.fromJson(object);
                    coronaTotalCasesObject = instance.data;
                    this.setState(() {
                      refreshClicked = false;
                    });
                  }),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, Colors.black87],
                  begin: Alignment.topRight,
                  end: Alignment.topLeft),
            ),
            child: _selectedIndex == 1 ? precautionCare(context) : ListView(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 20.0, 4.0, 5.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'Last updated at : ${data.timeNow}',
                              style: TextStyle(
                                color: Colors.grey[200],
                              ),
                            ),
                          ),
                        ),
                        ModalRoute.of(context).settings.arguments is IndianState ? SizedBox(height: 0,) : Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                )
                              ]),
                          child: FlatButton.icon(
                              onPressed: () async {
                                dynamic result = await Navigator.pushNamed(
                                    context, '/location',
                                    arguments: coronaTotalCasesObject);
                                if (result != null) {
                                  setState(() {
                                    data = result;
                                  });
                                }
                              },
                              icon: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.edit_location,
                                    color: Colors.grey[200],
                                  ),
                                ],
                              ),
                              label: Text(
                                'Edit Location',
                                style: TextStyle(
                                  fontSize: 29,
                                  color: Colors.grey[200],
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  data.country,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 45.0,
                                      letterSpacing: 2.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              data.countryInfo == null ? SizedBox(width: 1,) : CachedNetworkImage(
                                imageUrl: data.countryInfo['flag'],
                                width:  60,
                                fit: BoxFit.fitWidth,
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Total Cases',
                              style: TextStyle(
                                /**/
                                  fontSize: 30.0,
                                  letterSpacing: 2.0,
                                  color: Colors.white),
                            ),
                            Text(
                              data.cases.toString(),
                              style: TextStyle(
                                /**/
                                  fontSize: 30.0,
                                  letterSpacing: 2.0,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Total Deaths',
                                style: TextStyle(
                                  /**/
                                    fontSize: 30.0,
                                    letterSpacing: 2.0,
                                    color: Colors.white),
                              ),
                              Text(
                                data.deaths.toString(),
                                style: TextStyle(
                                  /**/
                                    fontSize: 30.0,
                                    letterSpacing: 2.0,
                                    color: Colors.red),
                              )
                            ]),
                        SizedBox(height: 10.0),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Total Recovered',
                                style: TextStyle(
                                  /**/
                                    fontSize: 30.0,
                                    letterSpacing: 2.0,
                                    color: Colors.white),
                              ),
                              Text(
                                data.recovered.toString(),
                                style: TextStyle(
                                  /**/
                                    fontSize: 30.0,
                                    letterSpacing: 2.0,
                                    color: Colors.green),
                              )
                            ]),
                        SizedBox(height: 10.0),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Active Cases',
                                style: TextStyle(
                                  /**/
                                    fontSize: 30.0,
                                    letterSpacing: 2.0,
                                    color: Colors.white),
                              ),
                              Text(
                                data.active.toString(),
                                style: TextStyle(
                                  /**/
                                    fontSize: 30.0,
                                    letterSpacing: 2.0,
                                    color: Colors.blue),
                              )
                            ]),
                        SizedBox(height: 10.0),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Today Cases',
                                style: TextStyle(
                                  /**/
                                    fontSize: 30.0,
                                    letterSpacing: 2.0,
                                    color: Colors.white),
                              ),
                              Text(
                                data.todayCases.toString(),
                                style: TextStyle(
                                  /**/
                                    fontSize: 30.0,
                                    letterSpacing: 2.0,
                                    color: Colors.white),
                              )
                            ]),
                        SizedBox(height: 10.0),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Today Deaths',
                                style: TextStyle(
                                  /**/
                                    fontSize: 30.0,
                                    letterSpacing: 2.0,
                                    color: Colors.white),
                              ),
                              Text(
                                data.todayDeaths.toString(),
                                style: TextStyle(
                                  /**/
                                    fontSize: 30.0,
                                    letterSpacing: 2.0,
                                    color: Colors.red),
                              )
                            ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
    }
  }

  Widget customBottomBar(){
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Cases'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title: Text('Care'),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}