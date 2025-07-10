import 'package:flutter/material.dart';
import 'package:mb_fe/appbar/custom_appbar.dart';

class libraryPage extends StatelessWidget {
  const libraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Library'),
      body: Center(child: Text('Library')),

    );

  }
}
