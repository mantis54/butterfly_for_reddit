import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';

import 'package:butterfly_reddit/post.dart';
import 'package:butterfly_reddit/comment.dart';

import 'package:http/http.dart' as http;

/// The comment section of a post
/// TODO rename class?
class PostDetails extends StatefulWidget {
  PostDetails({this.post});

  Post post;

  /// Creates the state of the widget
  @override
  PostDetailState createState() => PostDetailState();
}

/// The state for the PostDetails widget
class PostDetailState extends State<PostDetails> {
  List<Widget> comments;

  @override
  void initState() {
    super.initState();
  }

  /// Gets the comments
  Future<List<Widget>> getComments() async {
    if (comments == null) {
      List data;

      comments = new List<Widget>();
      var res = await http.get(Uri.encodeFull(widget.post.url + ".json"));

      setState(() {
        final jsonResponse = json.decode(res.body);
        comments.add(Post.fromJson(jsonResponse[0]["data"]["children"][0]["data"]).getBody());
        data = jsonResponse[1]["data"]["children"];
        data.forEach((element) {
          comments.add(Comment.fromJson(element["data"]));
        });
      });
    }

    return comments;
  }

  /// Builds the list of all the comments
  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Widget> values = snapshot.data;
    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return values[index];
      },
    );
  }

  /// Builds the Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.sub),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: commentBuilder(),
      ),
    );
  }

  /// Builds the list of comments
  /// TODO refractor into the main build?
  Widget commentBuilder() {
    return Container(
      child: FutureBuilder(
        future: getComments(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Column(
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              );
            default:
              if (snapshot.hasError) {
                print(snapshot.error);
                return Text('Error: ${snapshot.error}');
              }
              else
                return createListView(context, snapshot);
          }
        },
      ),
    );
  }
}
