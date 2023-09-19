import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/controller/auth_controller_getx.dart';
import 'package:mcemeurckart/controller/category_controller_getx.dart';
import 'package:mcemeurckart/controller/generics_controller_getx.dart';
import 'package:mcemeurckart/controller/products_controller_getx.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mcemeurckart/routes/app_routes.dart';
import 'package:mcemeurckart/theme/theme_provider.dart';
import 'package:mcemeurckart/constants/index.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    Get.put(AuthController());
    Get.put(GenericsController());
    Get.put(CategoriesController());
    Get.put(ProductsController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppTitles.appTitle,
      theme: AppThemes().lightTheme,
      darkTheme: AppThemes().darkTheme,
      title: AppTitles.appTitle,
      initialRoute: AppPages.initial,
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
