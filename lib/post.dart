import 'package:butterfly_reddit/post_view.dart';
import 'package:flutter/material.dart';

import 'package:butterfly_reddit/post_details.dart';


/// Handles the contents of a post
class Post extends StatelessWidget {

  /// The constructor for a Post
  Post({
    Key key,
    this.base,
    this.selfpost,
    this.title,
    this.sub,
    this.score,
    this.numComments,
    this.author,
    this.selftext,
    this.url,
    this.permalink,
    this.postHint,
  });

  Map<String, dynamic> base;
  bool selfpost;
  String title;
  String sub;
  int score;
  int numComments;
  String author;
  String selftext;
  String url;
  String permalink;
  String postHint;

  /// Creates a post from a json map
  factory Post.fromJson(Map<String, dynamic> parsedJson) {
    return new Post(
      key: Key(parsedJson["title"]),
      base: parsedJson,
      selfpost: parsedJson["is_self"],
      title: parsedJson["title"],
      sub: parsedJson["subreddit_name_prefixed"],
      score: parsedJson["score"],
      numComments: parsedJson["num_comments"],
      author: parsedJson["author"],
      selftext: parsedJson["selftext"],
      url: parsedJson["url"],
      permalink: parsedJson["permalink"],
      postHint: parsedJson["post_hint"],
    );
  }

  /// Builds the post so that it can be displayed
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                FlatButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          String link = sub + '/';
                          print(link);
                          PostView result = new PostView(
                            link: link,
                          );
                          return Scaffold(
                            appBar: AppBar(
                              title: Text(sub),
                            ),
                            body: (result),
                          );
                        },
                      ),
                    );
                  },
                  child: Text(sub),
                ),
                Expanded(
                  child: Text(
                    author,
                    textAlign: TextAlign.right,
                  ),
                )
              ],
            ),
            Text(selfpost ? 'Link' : 'Self'),
            FlatButton(
              child: Text(
                title,
                textScaleFactor: 1.5,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostDetails(post: this,)));
              },
            ),
            postHint != null ? (base["preview"]["enabled"] ? Image.network(
              base["preview"]["images"][0]["source"]["url"]
            ) : Placeholder()) : Container(),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_upward),
                  onPressed: () {},
                ),
                Text(score.toString()),
                IconButton(
                  icon: Icon(Icons.arrow_downward),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () {},
                ),
                Text(numComments.toString())
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getBody(){
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '/u/${author != null
                  ? author
                  : ''}',
              textAlign: TextAlign.right,
            ),
            Text(
              title != null ? title : '',
              style: TextStyle(fontSize: 24.0),
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_upward),
                  onPressed: () {},
                ),
                Text(score != null
                    ? score.toString()
                    : 0),
                IconButton(
                  icon: Icon(Icons.arrow_downward),
                  onPressed: () {},
                ),
              ],
            ),
            Text(selftext != null
                ? selftext
                : ''),
          ],
        ),
      ),
    );
  }
}
