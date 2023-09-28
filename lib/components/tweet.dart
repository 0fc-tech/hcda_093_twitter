
import 'package:flutter/material.dart';
import 'package:x_clone/bo/tweet.dart' as bo;

class Tweet extends StatelessWidget {
  final bo.Tweet tweet;
  final DateTime dateTime;
  Tweet(
      this.tweet,
      this.dateTime,{
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        children:[
          Image.network("https://picsum.photos/150",width: 125,height: 125,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(tweet.author,
                          style: Theme.of(context).textTheme.titleSmall),
                      Text("${dateTime.minute}m",
                        style: const TextStyle(color: Colors.grey),),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Text(tweet.message)
                ],
              ),
            ),
          )
        ]
    );
  }
}


