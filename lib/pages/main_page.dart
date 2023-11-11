import 'package:flutter/material.dart';
import 'package:new_app/components/new_bottom_nav_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NewBtmNvBar(),
    );
  }
}
