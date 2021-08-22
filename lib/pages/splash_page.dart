import 'dart:async';

import 'package:ad/utils/navigation/navigator.dart';
import 'package:flutter/material.dart';

import 'dashboard/dashboard_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 3),
      () {
        pushToWithRoute(context, CustomRoutes.fadeIn(DashboardPage()));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Icon(
            Icons.calculate_rounded,
            color: Colors.white,
            size: 180,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
            border: Border.all(
              color: Colors.blue[200],
              width: 10,
            ),
          ),
        ),
      ),
    );
  }
}
