import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_todo/pages/Login.dart';
import 'package:super_todo/pages/home.dart';
import 'package:super_todo/pages/onboarding/onboarding.dart';
import 'package:super_todo/styles/colors.dart';

import '../firebase.dart';

class SplashScreen extends StatefulWidget {
  static final route = "splash";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SharedPreferences _store;

  @override
  void initState() {
    super.initState();
    this._initState();
  }

  void _initState() async {
    _store = await SharedPreferences.getInstance();

    /// if isFirstRun == (true || null ) ~ means the user has not finish the onboarding process
    ///
    /// else isFirstRun == false ~ means the user has finish the onboarding process
    bool isFirstRun = _store.getBool("isFirstRun") ?? true;

    final user = fAuth.currentUser;

    Future.delayed(Duration(seconds: 1), () {
      if (isFirstRun) {
        gotoOnBoarding();
      } else if (user != null) {
        user.reload();
        gotoHome();
      } else {
        gotoLogin();
      }
    });
  }

  void gotoOnBoarding() {
    Navigator.of(context).pushNamed(OnBoarding.route);
  }

  void gotoLogin() {
    Navigator.of(context).pushNamed(Login.route);
  }

  void gotoHome() {
    Navigator.of(context).pushNamed(Home.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        color: cLight,
        // gradient: LinearGradient(
        //     begin: Alignment.topLeft, colors: [cAccent, cPrimary])
      ),
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline_rounded, color: cPrimary, size: 100),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Tungar Messenger",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: cPrimary, fontWeight: FontWeight.bold)),
          ),
        ],
      )),
    ));
  }
}
