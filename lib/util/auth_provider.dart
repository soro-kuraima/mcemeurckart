import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mcemeurckart/screens/auth_screen/signin_screen.dart';
import 'package:mcemeurckart/screens/home_screen/home_screen.dart';

class AuthProvider extends StatelessWidget {
  static String id = ('main_page');

  const AuthProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print('homescreen');
              return const HomeScreen();
            } else {
              print('Login Screen');
              return const SignInScreen();
            }
          }),
    );
  }
}
