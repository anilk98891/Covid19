import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:worldtimeapp/Model/IndianStatesData.dart';

class SearchClassIndian extends SearchDelegate<String> {
  List<IndianState> countrydata;
  SearchClassIndian({Key key, this.countrydata});

  void updateTime(index,context) async {
    dynamic instance = countrydata[index];
    Navigator.pushNamed(context, '/home',arguments: instance);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return getSearchResult();
  }

  Widget getSearchResult(){
    List<IndianState> suggestedData = query == ''
        ? countrydata
        : countrydata
        .where((element) =>
        element.country.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    return ListView.builder(
        itemCount: suggestedData.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
            child: Card(
                child: ListTile(
                  onTap: () {
                    countrydata = suggestedData;
                    close(context, query);
                    updateTime(index,context);
                  },
                  title: RichText(
                    text: TextSpan(
                        text:
                        suggestedData[index].country.substring(0, query.length),
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text: suggestedData[index].country.substring(
                                  query.length,
                                  suggestedData[index].country.length),
                              style: TextStyle(color: Colors.grey))
                        ]),
                  ),
                  leading: Icon(Icons.place),
                )),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return getSearchResult();
  }
}
