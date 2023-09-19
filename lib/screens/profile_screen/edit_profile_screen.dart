import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mcemeurckart/common_widgets/index.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'package:mcemeurckart/controller/user_controller_getx.dart';
import 'package:mcemeurckart/util/firebase_storage_helper.dart';
import 'package:mcemeurckart/util/firestore_helper.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _imagePicker = ImagePicker();

  final _editProfileKey = GlobalKey<FormState>();

  final _rankController = TextEditingController();

  final _addressController = TextEditingController();

  final _phoneController = TextEditingController();

  String? _rank;

  String? _address;

  String? _phone;

  Uint8List? _imageFile;

  @override
  Widget build(BuildContext context) {
    final user = Get.find<UserController>().user;
    _rankController.value = TextEditingValue(text: user['displayName']);
    _addressController.value = TextEditingValue(text: user['address']);
    _phoneController.value = TextEditingValue(text: user['phone'] ?? '');
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    centerTitle: false,
                    title: Padding(
                      padding: const EdgeInsets.only(
                        left: Sizes.p8,
                      ),
                      child: Text(
                        'Edit Profile',
                        style: Get.textTheme.headlineSmall,
                      ),
                    ),
                    actions: const [],
                  ),
                ],
            body: GetBuilder<UserController>(
              builder: (userController) {
                return Form(
                  key: _editProfileKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      Sizes.p24,
                      Sizes.p24,
                      Sizes.p24,
                      0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          labelText: 'Name',
                          textInputType: TextInputType.text,
                          isReadOnly: true,
                          initialValue: userController.user['displayName'],
                        ),
                        gapH40,
                        CustomTextField(
                          labelText: 'Rank',
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your rank';
                            }

                            return null;
                          },
                          controller: _rankController,
                          onSaved: (value) {
                            _rank = value;
                          },
                        ),
                        gapH40,
                        CustomTextField(
                          labelText: 'Address',
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter an address';
                            }

                            return null;
                          },
                          controller: _addressController,
                          onSaved: (value) {
                            _address = value;
                          },
                        ),
                        gapH40,
                        CustomTextField(
                          labelText: 'Phone',
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number';
                            }

                            return null;
                          },
                          controller: _phoneController,
                          onSaved: (value) {
                            _phone = value;
                          },
                        ),
                        gapH40,
                        SizedBox(
                          child: GestureDetector(
                            onTap: () async {
                              final pickedImage = await _imagePicker.pickImage(
                                source: ImageSource.gallery,
                              );
                              final data = await pickedImage?.readAsBytes();

                              setState(() {
                                _imageFile = data;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.neutral500),
                                borderRadius: BorderRadius.circular(Sizes.p8),
                              ),
                              child: Center(
                                  child: _imageFile == null &&
                                          userController
                                                  .user['displayPicture'] ==
                                              null
                                      ? Image.asset(
                                          AppAssets.profileEmpty,
                                          fit: BoxFit.cover,
                                          width: Sizes.deviceWidth * 0.85,
                                        )
                                      : _imageFile != null
                                          ? Image.memory(
                                              _imageFile!,
                                              fit: BoxFit.cover,
                                              width: Sizes.deviceWidth * 0.85,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: userController
                                                      .user['displayPicture'] ??
                                                  '',
                                              fit: BoxFit.cover,
                                              width: Sizes.deviceWidth * 0.85)),
                            ),
                          ),
                        ),
                        gapH40,
                        PrimaryButton(
                          buttonColor: AppColors.neutral800,
                          buttonLabel: 'Update Profile',
                          onPressed: () async {
                            if (_editProfileKey.currentState!.validate()) {
                              _editProfileKey.currentState!.save();

                              String imageUrl;

                              if (_imageFile != null) {
                                imageUrl =
                                    await FirebaseStorageHelper.updateUserImage(
                                        _imageFile!);
                              } else {
                                imageUrl =
                                    userController.user['displayPicture'];
                              }

                              await FireBaseStoreHelper.updateUser({
                                'rank': _rank,
                                'address': _address,
                                'phone': _phone,
                                'displayPicture': imageUrl,
                              });
                            }
                            Get.snackbar(
                              "User updated Successfully",
                              "",
                              backgroundColor: AppColors.green500,
                              colorText: AppColors.white,
                              duration: const Duration(seconds: 2),
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            _editProfileKey.currentState!.reset();
                            setState(() {
                              _imageFile = null;

                              _rankController.value = TextEditingValue.empty;
                              _addressController.value = TextEditingValue.empty;
                              _phoneController.value = TextEditingValue.empty;
                            });
                          },
                        ),
                        gapH40,
                      ],
                    ),
                  ),
                );
              },
            )));
  }
}
