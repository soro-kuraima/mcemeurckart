import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/routes/app_routes.dart';
import 'package:mcemeurckart/screens/auth_screen/signin_screen.dart';
import 'package:mcemeurckart/screens/loading_screen/loading_screen.dart';

class AuthProvider extends StatelessWidget {
  const AuthProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return LoadingScreen();
            } else {
              return const SignInScreen();
            }
          }),
    );
  }
}
