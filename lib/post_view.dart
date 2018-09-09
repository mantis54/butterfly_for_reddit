import 'package:flutter/material.dart';

import 'package:butterfly_reddit/post.dart';
import 'package:butterfly_reddit/globals.dart' as global;

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class PostView extends StatefulWidget {
  PostView({
    Key key,
    this.link: '',
  }) : super(key: key);

  String link;
  List posts;

  @override
  PostViewState createState() => new PostViewState();
}

class PostViewState extends State<PostView> {
  String url;
  List data;
  List<Post> posts;

  @override
  void initState() {
    super.initState();

    if (widget.posts != null) {
      posts = widget.posts;
    } else {
      posts = new List<Post>();
    }

    url = global.base + widget.link + global.end;
  }

  Future<List<Post>> getData() async {
    if (posts.isEmpty) {
      print("Building list");
      var res = await http.get(Uri.encodeFull(url));
      setState(() {
        final jsonResponse = json.decode(res.body);
        data = jsonResponse["data"]["children"];
        data.forEach((element) {
          Post post = new Post.fromJson(element["data"]);
          try {
            posts.add(post);
          } catch (e) {
            print(e.toString());
          }
        });
      });
    } else
      print("List already built");

    widget.posts = posts;

    return posts;
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Post> values = snapshot.data;
    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: values,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  return createListView(context, snapshot);
            }
          },
        ),
      ),
    );
  }
}
