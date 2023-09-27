import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_clone/connection_page.dart';

import 'twitter_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _router = GoRouter(
    initialLocation: "/connection",
    routes: [
      GoRoute(
          path: "/homepage",
          builder: (context,state)=> TwitterPage(state.extra as String)
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