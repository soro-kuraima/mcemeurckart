import 'dart:developer';

import "package:flutter/material.dart";
import "package:get/get.dart";

import 'package:mcemeurckart/common_widgets/index.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'package:mcemeurckart/routes/app_routes.dart';
import 'package:mcemeurckart/util/firebase_auth_helper.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> signInKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  String? email;

  String? password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: Form(
            key: signInKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                Sizes.p24,
                Sizes.p24,
                Sizes.p24,
                0,
              ),
              child: Column(
                children: [
                  Image.asset(AppAssets.mceme,
                      height: Sizes.deviceHeight * .3,
                      width: Sizes.deviceWidth * .8),
                  gapH48,
                  Text(
                    'Sign in to your account',
                    style: Get.textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  gapH16,
                  Text(
                    'Log in to get all your groceries and essentials delivered',
                    style: Get.textTheme.bodyMedium?.copyWith(
                      color: AppColors.neutral600,
                      fontWeight: Fonts.interRegular,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  gapH40,
                  const CustomDivider(
                    hasText: false,
                  ),
                  gapH40,
                  CustomTextField(
                    labelText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    controller: emailController,
                    onSaved: (value) {
                      email = value;
                    },
                  ),
                  gapH16,
                  CustomTextField(
                    labelText: 'Password',
                    isSecret: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    controller: passwordController,
                    onSaved: (value) {
                      password = value;
                    },
                  ),
                  gapH40,
                  PrimaryButton(
                    buttonColor: AppColors.neutral800,
                    buttonLabel: 'Log in',
                    onPressed: () async {
                      log("login button pressed");
                      if (signInKey.currentState!.validate()) {
                        signInKey.currentState!.save();
                        Map<String, dynamic> res = await FirebaseAuthHelper
                            .firebaseAuthHelper
                            .signInUserWithEmailPassword(
                                email: email, password: password);

                        if (res['error'] != null) {
                          Get.snackbar(
                            'Error',
                            res['error'],
                            backgroundColor: AppColors.red400,
                            colorText: AppColors.white,
                            duration: const Duration(seconds: 3),
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } else if (res['user'] != null) {
                          Get.snackbar("", "Successfully signed in",
                              backgroundColor: AppColors.green500,
                              colorText: AppColors.white,
                              duration: const Duration(seconds: 3),
                              snackPosition: SnackPosition.BOTTOM);

                          signInKey.currentState!.reset();
                          emailController.value = TextEditingValue.empty;
                          passwordController.value = TextEditingValue.empty;

                          Get.offAllNamed(AppRoutes.baseRoute);
                        }
                      }
                    },
                  ),
                  gapH24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: Get.textTheme.bodyMedium,
                      ),
                      PrimaryTextButton(
                        defaultTextStyle: false,
                        style: Get.textTheme.bodyMedium?.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                        buttonLabel: 'Sign up',
                        onPressed: () => Get.offAllNamed(AppRoutes.signUpRoute),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
