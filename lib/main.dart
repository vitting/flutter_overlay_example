import 'package:flutter/material.dart';
import 'package:flutter_overlay_example/button_with_overlay_example.dart';
import 'package:flutter_overlay_example/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Overlay Examples',
      // theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      initialRoute: '/',
      routes: {'/': (context) => const Home(), ButtonWithOverlayExample.routeName: (context) => const ButtonWithOverlayExample()},
    );
  }
}
