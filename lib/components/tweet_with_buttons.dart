

import 'package:flutter/material.dart';
import 'package:x_clone/components/tweet.dart';

import 'bottom_tweet_bar.dart';
import 'package:x_clone/bo/tweet.dart' as bo;
class TweetWithButtons extends StatelessWidget {
  final bo.Tweet tweet;
  const TweetWithButtons({
    required this.tweet,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Tweet(tweet, DateTime(2023,12,3,12,50,12)),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: ButtonTweetBar(),
          )
        ],
      ),
    );
  }
}
