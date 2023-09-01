import 'dart:developer';

import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import "package:get/get.dart";
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mcemeurckart/common_widgets/index.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'package:mcemeurckart/routes/app_routes.dart';
import 'package:mcemeurckart/theme/app_style.dart';
import 'package:mcemeurckart/util/firebase_auth_helper.dart';

final GlobalKey<FormState> signInKey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
String? email;
String? password;

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                  SvgPicture.asset(
                    AppAssets.appLogoMceme,
                    width: Sizes.p100,
                    height: Sizes.p100,
                  ),
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
                          Fluttertoast.showToast(
                            msg: res['error'],
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: AppColors.red400,
                            textColor: AppColors.white,
                          );
                        } else if (res['user'] != null) {
                          Fluttertoast.showToast(
                            msg: "Successfully Signed In",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: AppColors.green300,
                            textColor: AppColors.white,
                          );
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
                        onPressed: () => Get.toNamed(
                          AppRoutes.signUpRoute,
                        ),
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
