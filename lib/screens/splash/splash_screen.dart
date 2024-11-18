import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wetrack/app/app_theme.dart';
import 'package:wetrack/screens/home/home_page.dart';
//import '../login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool skip = false;
  int _splashStage = 1;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (!skip) {
        setState(() {
          _splashStage = 2;
        });

        Timer(const Duration(seconds: 3), () {
          if (!skip) {
            _toHomePage();
          }
        });
      }
    });
  }

  void _toHomePage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  void _skip() {
    setState(() {
      skip = true;
    });
    _toHomePage();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _skip,
        child: Scaffold(
            body: DecoratedBox(
                decoration:
                    const BoxDecoration(gradient: AppTheme.appBackground),
                child: Center(
                  child: Stack(
                    children: [
                      if (_splashStage == 1)
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'photos/logo.png',
                                width: 150,
                              ),
                            ],
                          ),
                        ),
                      if (_splashStage == 2)
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'photos/app_logo.png',
                                width: 180,
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                ))));
  }
}
