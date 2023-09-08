import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/util/auth_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mcemeurckart/routes/app_routes.dart';
import 'package:mcemeurckart/theme/theme_provider.dart';
import 'package:mcemeurckart/constants/index.dart';

import 'controller/cart_controller_getx.dart';
import 'controller/category_controller_getx.dart';
import 'controller/generics_controller_getx.dart';
import 'controller/orders_controller_getx.dart';
import 'controller/products_controller_getx.dart';
import 'controller/wishlist_controller_getx.dart';

Future main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Get.put(GenericsController());
    Get.put(CategoriesController());
    Get.put(ProductsController());
    Get.put(WishlistController());
    Get.put(CartController());
    Get.put(OrdersController());
    Future.delayed(const Duration(seconds: 3), () {
      FlutterNativeSplash.remove();
    });

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppTitles.appTitle,
      theme: AppThemes().lightTheme,
      darkTheme: AppThemes().darkTheme,
      title: AppTitles.appTitle,
      home: const AuthProvider(),
      getPages: AppPages.pages,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(
            start: 0,
            end: 350,
            name: MOBILE,
          ),
          const Breakpoint(
            start: 351,
            end: 600,
            name: TABLET,
          ),
          const Breakpoint(
            start: 601,
            end: 800,
            name: DESKTOP,
          ),
          const Breakpoint(
            start: 801,
            end: double.infinity,
            name: 'XL',
          ),
        ],
      ),
    );
  }
}
