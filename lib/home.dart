import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Overlay Examples')),
      body: ListView(
        children: [
          ListTile(title: const Text('Button with Overlay Example'), onTap: () => Navigator.pushNamed(context, '/button_with_overlay')),
        ],
      ),
    );
  }
}
