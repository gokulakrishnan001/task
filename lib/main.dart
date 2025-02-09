import 'package:flutter/material.dart';
import 'package:flutter_map/VechileScreen/EditingPage.dart';
import 'package:flutter_map/VechileScreen/LandingPage.dart';
import 'package:flutter_map/VechileScreen/RegisterPage.dart';
import 'package:flutter_map/router/AppRoute.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async{
  await Hive.initFlutter();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Portal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: AppRouteConfig.router.routeInformationParser,
      routerDelegate: AppRouteConfig.router.routerDelegate,
      routeInformationProvider: AppRouteConfig.router.routeInformationProvider,
    );
  }
}
