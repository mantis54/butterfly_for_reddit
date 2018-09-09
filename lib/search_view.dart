import 'package:flutter/material.dart';

import 'package:butterfly_reddit/post_view.dart';

import 'package:butterfly_reddit/globals.dart' as global;

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchText = new TextEditingController(text: '');

    return Column(
      children: <Widget>[
        Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: searchText,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          String link = 'r/' + searchText.text + '/';
                          print(link);
                          PostView result = new PostView(
                            link: link,
                          );
                          return Scaffold(
                            appBar: AppBar(
                              title: Text(searchText.text),
                            ),
                            body: (result),
                          );
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
        Container(
          height: 50.0,
        ),
      ],
    );
  }
}
