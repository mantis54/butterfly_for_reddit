import 'package:flutter/material.dart';

import 'dart:async';

import 'package:butterfly_reddit/post_view.dart';
import 'package:butterfly_reddit/search_view.dart';
import 'package:butterfly_reddit/globals.dart' as globals;

/// Runs the application
void main() => runApp(new Butterfly());

/// The Main widget for the program
class Butterfly extends StatefulWidget {
  /// Creates the state of the widget
  @override
  ButterflyState createState() => new ButterflyState();
}

/// The State for the Butterfly Widget
class ButterflyState extends State<Butterfly> {
  /// Initializes the state for the Widget
  @override
  void initState() {
    super.initState();
    globals.recentSearches = new List<String>();
    home = new PostView();
    search = new SearchView();
  }

  PostView home;
  SearchView search;

  /// Builds the widget to be displayed
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Butterfly',
      theme: globals.theme,
      routes: <String, WidgetBuilder>{
        '/search': (BuildContext context) => SearchView(),
      },
      home: new DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: AppBar(
            title: Text('Butterfly'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.home),
                ),
                Tab(
                  icon: Icon(Icons.search),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              home,
              search,
            ],
          ),
        ),
      ),
    );
  }

  void navigateSearch() {
    Navigator.pushNamed(context, '/search');
  }
}
