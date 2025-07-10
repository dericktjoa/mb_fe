import 'package:flutter/material.dart';
import 'package:mb_fe/authentication//auth_page.dart';
import 'package:provider/provider.dart';
import 'package:mb_fe/dashboard/provider.dart';
import 'package:mb_fe/setting/provider.dart';
import 'package:mb_fe/profile/provider.dart';
import 'package:mb_fe/games/model/provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => providerDashboard()),
          ChangeNotifierProvider(create: (_) => providerSetting()),
          ChangeNotifierProvider(create: (_) => QuizProvider()),
          ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ],
        child: MainApp(),
      )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final prov_setting = Provider.of<providerSetting>(context);
    return MaterialApp(
      title: 'Project',
      debugShowMaterialGrid: false,
      theme: prov_setting.enableDarkMode ? prov_setting.dark : prov_setting.light,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: const loginPage(),
        ),
      ),
    );
  }
}
