import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_todo/pages/onboarding/screen1.dart';
import 'package:super_todo/pages/onboarding/screen2.dart';
import 'package:super_todo/pages/onboarding/screen3.dart';

import '../Login.dart';

class OnBoarding extends StatefulWidget {
  static final String route = "onboarding";

  OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late final PageController _pageController;
  late final SharedPreferences _store;

  @override
  void initState() {
    super.initState();
    init();
    _pageController = PageController(initialPage: 0);
  }

  void init() async {
    _store = await SharedPreferences.getInstance();
  }

  void goNext() {
    _pageController.nextPage(
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  void skip() async {
    _store.setBool("isFirstRun", false);
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Login.route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: BouncingScrollPhysics(),
        children: [
          Screen1(
            next: goNext,
            skip: skip,
          ),
          Screen2(
            next: goNext,
            skip: skip,
          ),
          Screen3(
            next: skip,
            skip: skip,
          )
        ],
      ),
    );
  }
}
