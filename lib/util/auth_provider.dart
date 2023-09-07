import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/constants/app_titles.dart';
import 'package:mcemeurckart/routes/app_routes.dart';
import 'package:mcemeurckart/screens/auth_screen/signin_screen.dart';
import 'package:mcemeurckart/screens/base_screen/base_screen.dart';
import 'package:mcemeurckart/theme/theme_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AuthProvider extends StatelessWidget {
  const AuthProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return BaseScreen();
            } else {
              return const SignInScreen();
            }
          }),
    );
  }
}
