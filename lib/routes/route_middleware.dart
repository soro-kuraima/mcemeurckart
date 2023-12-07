import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/controller/auth_controller_getx.dart';
import 'package:mcemeurckart/routes/app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (Get.find<AuthController>().user.value != null) {
      var currentDateTime = DateTime.now();
      var currentHour = currentDateTime.hour;
      var currentMinute = currentDateTime.minute;
      var currentDay = currentDateTime.weekday;

      log(currentDay.toString());

      log(currentDateTime.toIso8601String());

      if (currentDay == DateTime.friday) {
        log(currentDay.toString());
        return const RouteSettings(name: AppRoutes.orderClosedRoute);
      } else if (currentDay == DateTime.sunday &&
          (currentDateTime.isBefore(DateTime(currentDateTime.year,
                  currentDateTime.month, currentDateTime.day, 6, 0, 0)) ||
              currentDateTime.isAfter(DateTime(currentDateTime.year,
                  currentDateTime.month, currentDateTime.day, 13, 00, 0)))) {
        log(currentHour.toString());

        return const RouteSettings(name: AppRoutes.orderClosedRoute);
      } else if ((currentDateTime.isBefore(DateTime(currentDateTime.year,
                  currentDateTime.month, currentDateTime.day, 15, 0, 0)) ||
              currentDateTime.isAfter(DateTime(currentDateTime.year,
                  currentDateTime.month, currentDateTime.day, 17, 00, 0))) &&
          (currentDateTime.isBefore(DateTime(currentDateTime.year,
                  currentDateTime.month, currentDateTime.day, 6, 0, 0)) ||
              currentDateTime.isAfter(
                  DateTime(currentDateTime.year, currentDateTime.month, currentDateTime.day, 13, 00, 0)))) {
        log(currentMinute.toString());
        return const RouteSettings(name: AppRoutes.orderClosedRoute);
      } else {
        return null;
      }
    } else {
      return const RouteSettings(name: AppRoutes.signInRoute);
    }
  }
}
