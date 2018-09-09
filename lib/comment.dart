import 'package:flutter/material.dart';

/// Stores the contents of the comment for easier displaying
class Comment extends StatelessWidget {

  /// Constructor for the comment
  Comment({
    this.author,
    this.body,
    this.score,
  });

  String author;
  String body;
  int score;

  /// Creates a Comment from a json map
  factory Comment.fromJson(Map<String, dynamic> parsedJson){
    return new Comment(
      author: parsedJson["author"],
      body: parsedJson["body"],
      score: parsedJson["score"],
    );
  }

  /// Builds the Comment widget
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// The comment's author
            Container(
              child: Text(
                "u/" + author + "\n",
                textAlign: TextAlign.right,
              ),
            ),
            /// The body of the comment
            Text(body),
            Row(
              children: <Widget>[
                /// The upvote arrow
                IconButton(
                  icon: Icon(Icons.arrow_upward),
                  onPressed: () {},
                ),
                /// The comment's score
                Text(score.toString()),
                /// The downvote arrow
                IconButton(
                  icon: Icon(Icons.arrow_downward),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}