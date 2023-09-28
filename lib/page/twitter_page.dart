import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:x_clone/bo/tweet.dart';

import '../components/bottom_navigation_twitter.dart';
import '../components/top_navigation_twitter.dart';
import '../components/tweet_with_buttons.dart';

class TwitterPage extends StatelessWidget {
  final String email;
  const TwitterPage(this.email,{super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text("Twitter",style: TextStyle(color: Colors.white),),
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor:Colors.lightBlue,
      ),
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TopNavigationTwitter(),
          Text("Bonjour $email",textAlign: TextAlign.start,),
          FutureBuilder<Response>(
              //future: get(Uri.parse("https://raw.githubusercontent.com/Chocolaterie/EniWebService/main/api/tweets.json")),
              future: get(
                  Uri.parse("https://raw.githubusercontent.com/Chocolaterie/EniWebService/main/api/tweets.json",),
              ),
              builder: (context, snapshot) {
                switch(snapshot.connectionState){
                  case ConnectionState.done:
                    if(snapshot.hasData && snapshot.data != null){
                      final listTweetJSON = jsonDecode(snapshot.data!.body) as List<dynamic>;
                      final List<Tweet> listTweets = listTweetJSON.map((tweetJSON) => Tweet.fromMap(tweetJSON)).toList();
                      return Expanded(
                          child: ListView.builder(
                              itemCount: listTweets.length,
                              itemBuilder: (context,index) => TweetWithButtons(tweet: listTweets[index],))
                      );
                    }else{
                       return Icon(Icons.error);
                    }
                  default : return  const CircularProgressIndicator();
                }
              }
          ),
        ],
      ),
      bottomNavigationBar:  const BottomNavigationTwitter(),
    );
  }
}

