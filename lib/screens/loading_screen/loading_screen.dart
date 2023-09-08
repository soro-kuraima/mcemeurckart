import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'package:mcemeurckart/routes/app_routes.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    Timer(Duration(seconds: 2), () => Get.offAllNamed(AppRoutes.baseRoute));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitCircle(
                duration: Duration(seconds: 1),
                size: 70.0,
                color: AppColors.blue500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
