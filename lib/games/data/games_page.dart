import 'package:flutter/material.dart';
import 'package:mb_fe/appbar/custom_appbar.dart';

class gamesPage extends StatelessWidget {
  const gamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Games'),
      body: Center(child: Text('Games')),

    );

  }
}
