import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:mcemeurckart/common_widgets/index.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'package:mcemeurckart/routes/app_routes.dart';
import 'package:mcemeurckart/theme/app_style.dart';
import 'package:mcemeurckart/util/firebase_auth_helper.dart';
import 'package:mcemeurckart/util/firestore_helper.dart';

final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
String? email;
String? password;

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: Form(
            key: signUpKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                Sizes.p24,
                Sizes.p24,
                Sizes.p24,
                0,
              ),
              child: Column(
                children: [
                  // App Logo
                  SvgPicture.asset(
                    AppAssets.appLogoMceme,
                    width: Sizes.p100,
                    height: Sizes.p100,
                  ),
                  gapH40,
                  Text(
                    'Create account',
                    style: Get.textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  gapH16,
                  Text(
                    'Sign up to get all your groceries and essentials delivered',
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
                    buttonLabel: 'Sign Up',
                    onPressed: () async {
                      if (signUpKey.currentState!.validate()) {
                        signUpKey.currentState!.save();
                        Map<String, dynamic> res = await FirebaseAuthHelper
                            .firebaseAuthHelper
                            .createUserWithEmailPassword(
                                email: email, password: password);
                        if (res['error'] != null) {
                          ScaffoldMessenger.of(Get.context!).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: AppColors.red500,
                              content: Text(res['error'],
                                  style: AppStyle.paragraph1Bold),
                            ),
                          );
                        } else if (res['user'] != null) {
                          ScaffoldMessenger.of(Get.context!).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: AppColors.green500,
                              content: Text(
                                'Successful Signed up',
                                style: AppStyle.paragraph1Bold,
                              ),
                            ),
                          );
                          FireBaseStoreHelper.createWishList();
                          FireBaseStoreHelper.createCart();
                          Get.offAndToNamed(AppRoutes.baseRoute);
                        }
                      }
                    },
                  ),
                  gapH24,
                  Text.rich(
                    TextSpan(
                      style: Get.textTheme.bodyMedium,
                      text: 'By continuing you accept our standard ',
                      children: const [
                        WidgetSpan(
                          child: Text(
                            'terms and conditions ',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: Text(
                            'and our ',
                            style: TextStyle(),
                          ),
                        ),
                        WidgetSpan(
                          child: Text(
                            'privacy policy.',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  gapH24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: Get.textTheme.bodyMedium,
                      ),
                      PrimaryTextButton(
                        defaultTextStyle: false,
                        style: Get.textTheme.bodyMedium?.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                        buttonLabel: 'Log in',
                        onPressed: () => Get.offAndToNamed(
                          AppRoutes.signInRoute,
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
