import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_clone/page/connection_page.dart';
import 'package:x_clone/page/newtweet_page.dart';

import 'page/twitter_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _router = GoRouter(
    initialLocation: "/homepage",
    initialExtra: "sd",
    routes: [
      GoRoute(
        path: "/homepage",
        builder: (context,state)=> TwitterPage(state.extra == null ? "": state.extra as String),
        routes: [
          GoRoute(
            path: 'new',
            builder: (context,state)=> NewTweetPage(),
          )
        ]

      ),
      GoRoute(path: "/connection",builder: (context,state)=> ConnectionPage()),
    ]
  );
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerConfig: _router,
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        )
    );
  }
}