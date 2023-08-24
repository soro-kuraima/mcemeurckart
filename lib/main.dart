import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mcemeurckart/theme/theme_provider.dart';
import 'package:mcemeurckart/util/auth_provider.dart';
import 'package:mcemeurckart/views/screens/categories_screen.dart';
import 'package:mcemeurckart/views/screens/home_screen.dart';
import 'package:mcemeurckart/views/screens/loading_screen.dart';
import 'package:mcemeurckart/views/screens/login_screen.dart';
import 'package:mcemeurckart/views/screens/orders_screen.dart';
import 'package:mcemeurckart/views/screens/product_screen.dart';
import 'package:mcemeurckart/views/screens/profile_screen.dart';
import 'package:mcemeurckart/views/screens/registration_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

var message;
final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeProvider.lightTheme,
      darkTheme: ThemeProvider.darkTheme,
      initialRoute: AuthProvider.id,
      routes: {
        LoadingScreen.id: (context) => LoadingScreen(),
        AuthProvider.id: (context) => AuthProvider(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        LogInScreen.id: (context) => const LogInScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        CategoriesScreen.id: (context) => const CategoriesScreen(),
        ProductScreen.id: (context) => const ProductScreen(),
        OrdersScreen.id: (context) => const OrdersScreen(),
        ProfileScreen.id: (context) => const ProfileScreen(),
      },
    );
  }
}
