import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

List<String> images = [
  "assets/1.jpg",
  "assets/2.jpg",
  "assets/3.jpg",
  "assets/4.jpg",
  "assets/5.jpg",
  "assets/6.jpg",
  "assets/6a.jpg",
  "assets/7.jpg",
];

ListView precautionCare(BuildContext context) {
  return ListView(
    children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.height*0.5,
          color: Colors.black,
          child: Swiper(
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                  child: Image(
                image: AssetImage(images[index]),
                fit: BoxFit.fitWidth,
              ));
            },
            viewportFraction: 0.8,
            scale: 0.9,
            pagination: new SwiperPagination(),
            autoplay: true,
            autoplayDisableOnInteraction: false,
          )),
      Container(
        padding: EdgeInsets.only(top: 40),
        alignment: Alignment.topCenter,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/webview');
          },
          child: Text(
            'Important Numbers',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                decoration: TextDecoration.underline,
                color: Colors.blue),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 30),
        alignment: Alignment.topCenter,
        child: InkWell(
          onTap: () {
            launch("tel://+91-11-23978046");
          },
          child: Text(
            'Helpline Number',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                decoration: TextDecoration.underline,
                color: Colors.blue),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 30),
        alignment: Alignment.topCenter,
        child: InkWell(
          onTap: () {
            _launchURL(
                'ncov2019@gov.in', 'Emergency', '');
          },
          child: Text(
            'Helpline Email ID',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                decoration: TextDecoration.underline,
                color: Colors.blue),
          ),
        ),
      ),
    ],
  );
}

_launchURL(String toMailId, String subject, String body) async {
  var url = 'mailto:$toMailId?subject=$subject&body=$body';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
