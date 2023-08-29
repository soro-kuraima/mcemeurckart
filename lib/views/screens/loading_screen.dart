import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mcemeurckart/util/auth_provider.dart';

class LoadingScreen extends StatelessWidget {
  static String id = 'loading_screen';

  const LoadingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    //Timer For Splash Screen
    timeDilation = 3.0;
    Timer(const Duration(seconds: 2),
        () => Navigator.pushNamed(context, AuthProvider.id));
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitCircle(
                duration: Duration(seconds: 1),
                size: 70.0,
                color: Color.fromARGB(255, 57, 76, 181),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
