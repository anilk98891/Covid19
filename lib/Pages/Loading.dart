import 'package:flutter/material.dart';
import 'package:worldtimeapp/Model/CoronaCountryModel.dart';
import 'package:worldtimeapp/Services/World_time.dart';
import 'package:worldtimeapp/SupportingClasses/LoadingScreen.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  CronaCasesParentObject instance ;

  void setupWorldTime() async {
   dynamic object = await getCases();
   instance = CronaCasesParentObject.fromJson(object);
//   instance.data.sort((a, b) => b.cases.compareTo(a.cases));
   Navigator.pushReplacementNamed(context, '/home',arguments: instance.data);
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.6),
      body: Center(
        child: LoaderScreen(serverIP: "Fetching updated Data..")
      ),
    );
  }
}
