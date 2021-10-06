import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text("Search App"),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
            icon: Icon(Icons.search))
      ],
    ));
  }
}

class DataSearch extends SearchDelegate<String> {
  final cities = [
    "Pakistan",
    "India",
    "Srilanka",
    "Indonesia",
    "Agra",
    "Allabad"
  ];
  final recentCities = ["Srilanka", "Indonesia", "Agra", "allabad"];
  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for app b
    return [
      IconButton(
          onPressed: () {
            query = " ";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {},
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some results based on the search
    return Container(
      height: 100,
      width: 100,
      child: Card(
        color: Colors.black,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Shows when someone searches for something
    final suggestionList = query.isEmpty
        ? recentCities
        : cities
            .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.location_city),
        title: RichText(
            text: TextSpan(
                text: suggestionList[index].substring(0, query.length),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                text: suggestionList[index].substring(query.length),
                style: TextStyle(color: Colors.grey),
              )
            ])),
      ),
      itemCount: suggestionList.length,
    );
  }
}
