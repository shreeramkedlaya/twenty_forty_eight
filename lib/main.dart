import 'package:flutter/material.dart';

import 'twenty_forty_eight.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '2048',
      home: TwentyFortyEight(),
    );
  }
}
