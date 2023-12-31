import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mcemeurckart/common_widgets/index.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'package:mcemeurckart/routes/app_routes.dart';

import 'package:mcemeurckart/util/signup_utility.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController rankController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController groceryCardNoController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  String? email;

  String? password;

  String? rank;

  String? name;

  String? groceryCardNo;

  String? address;

  String? phone;

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

                  Image.asset(AppAssets.mceme,
                      height: Sizes.deviceHeight * .3,
                      width: Sizes.deviceWidth * .8),
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
                  gapH16,
                  CustomTextField(
                    labelText: 'Rank',
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your rank';
                      }

                      return null;
                    },
                    controller: rankController,
                    onSaved: (value) {
                      rank = value;
                    },
                  ),
                  gapH16,
                  CustomTextField(
                    labelText: 'Name',
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    controller: nameController,
                    onSaved: (value) {
                      name = value;
                    },
                  ),
                  gapH16,
                  CustomTextField(
                    labelText: 'Grocery Card No',
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Grocery Card No';
                      }

                      return null;
                    },
                    controller: groceryCardNoController,
                    onSaved: (value) {
                      groceryCardNo = value;
                    },
                  ),
                  gapH16,
                  CustomTextField(
                    labelText: 'Address',
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Address';
                      }

                      return null;
                    },
                    controller: addressController,
                    onSaved: (value) {
                      address = value;
                    },
                  ),
                  gapH16,
                  CustomTextField(
                    labelText: 'Phone',
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your phone';
                      }
                      if (!GetUtils.isPhoneNumber(value)) {
                        return 'Please enter a valid phone';
                      }
                      return null;
                    },
                    controller: phoneController,
                    onSaved: (value) {
                      phone = value;
                    },
                  ),
                  gapH40,
                  PrimaryButton(
                    buttonColor: AppColors.neutral800,
                    buttonLabel: 'Sign Up',
                    onPressed: () async {
                      if (signUpKey.currentState!.validate()) {
                        signUpKey.currentState!.save();
                        try {
                          final response = await sendAuthRequest({
                            'email': email,
                            'password': password,
                            'rank': rank,
                            'name': name,
                            'groceryCardNo': groceryCardNo,
                            'address': address,
                            'phone': phone,
                          });
                          signUpKey.currentState!.reset();
                          emailController.value = TextEditingValue.empty;
                          passwordController.value = TextEditingValue.empty;
                          rankController.value = TextEditingValue.empty;
                          nameController.value = TextEditingValue.empty;
                          phoneController.value = TextEditingValue.empty;
                          groceryCardNoController.value =
                              TextEditingValue.empty;
                          addressController.value = TextEditingValue.empty;
                          Get.snackbar("success", response.body.toString(),
                              backgroundColor: AppColors.green500,
                              colorText: AppColors.neutral100);
                          Get.offAllNamed(AppRoutes.successfulAuthRequest);
                        } catch (e) {
                          Get.snackbar(
                            'Error',
                            e.toString(),
                            backgroundColor: AppColors.red400,
                            colorText: AppColors.white,
                            duration: const Duration(seconds: 3),
                            snackPosition: SnackPosition.BOTTOM,
                          );
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
                        onPressed: () => Get.offAllNamed(AppRoutes.signInRoute),
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
