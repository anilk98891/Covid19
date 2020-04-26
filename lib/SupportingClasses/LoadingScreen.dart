import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderScreen extends StatefulWidget {
  final String serverIP;
  const LoaderScreen ({ Key key, this.serverIP }): super(key: key);

  @override
  _LoaderScreenState createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> {
  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    if (isShow){
      return showLoader(context);
    } else {
      return removeLoader(context);
    }
  }

  Widget showLoader(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.serverIP,style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 20,
              color: Colors.white
            ),),
            SizedBox(height: 15,),
            SpinKitRing(
              color: Colors.lightGreenAccent,
            ),
          ],
        ),
      ),
    );
  }

  Widget removeLoader(BuildContext context) {
    return null;
  }
}
