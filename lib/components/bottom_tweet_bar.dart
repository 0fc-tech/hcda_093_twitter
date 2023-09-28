
import 'package:flutter/material.dart';

class ButtonTweetBar extends StatefulWidget {

  const ButtonTweetBar({
    super.key,
  });

  @override
  State<ButtonTweetBar> createState() => _ButtonTweetBarState();
}

class _ButtonTweetBarState extends State<ButtonTweetBar> {
  bool _isLiked = false;
  bool _isRT = false;
  void _changeLike(){
    //Je signale à Flutter que _ButtonTweetBarState est dirty et donc que l'on
    //doit redéclencher un build().
    setState(() {
      _isLiked = !_isLiked;
    });
  }
  void _changeRT(){
    //Je signale à Flutter que _ButtonTweetBarState est dirty et donc que l'on
    //doit redéclencher un build().
    setState(() {
      _isRT = !_isRT;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("Répondre"),
        _isRT ?
        IconButton(icon: Icon(Icons.repeat, color: Colors.blue,),onPressed: ()=>_changeRT(),)
            :
        IconButton(icon: Icon(Icons.repeat),onPressed: ()=>_changeRT(),),
        _isLiked ?
        IconButton(icon: Icon(Icons.favorite, color: Colors.red,),onPressed: ()=>_changeLike(),)
            :
        IconButton(icon: Icon(Icons.favorite_border),onPressed: ()=>_changeLike(),)
      ],
    );
  }
}
