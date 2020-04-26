import 'package:flutter/material.dart';
import 'package:worldtimeapp/Pages/Choose_location.dart';
import 'package:worldtimeapp/Pages/Home.dart';
import 'package:worldtimeapp/Pages/IndianStatesListing.dart';
import 'package:worldtimeapp/Pages/Loading.dart';
import 'package:worldtimeapp/Pages/WebView.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    '/': (context) => Loading(),
    '/home': (context) => Home(),
    '/location': (context) => ChooseLocation(),
    '/location': (context) => ChooseLocation(),
    '/indianstate': (context) => IndianListingScreen(),
    '/webview': (context) => WebViewClass()
  },
));

