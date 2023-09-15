import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/controller/auth_controller_getx.dart';
import 'package:mcemeurckart/routes/app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (Get.find<AuthController>().user.value != null) {
      return null;
    } else {
      return const RouteSettings(name: AppRoutes.signInRoute);
    }
  }
}
