import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'package:mcemeurckart/controller/user_controller_getx.dart';
import 'package:mcemeurckart/util/firebase_storage_helper.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  final ImagePicker _imagePicker = ImagePicker();
  Uint8List? _imageFile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: SizedBox(
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.neutral500),
                borderRadius: BorderRadius.circular(Sizes.p8),
              ),
              child: GetBuilder<UserController>(builder: (userController) {
                return Center(
                    child: userController.user['displayPicture'] != null &&
                            _imageFile == null
                        ? Stack(children: [
                            CachedNetworkImage(
                              imageUrl:
                                  userController.user['displayPicture'] ?? '',
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                radius: 100,
                                backgroundImage: imageProvider,
                              ),
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                  onPressed: () async {
                                    final pickedImage =
                                        await _imagePicker.pickImage(
                                      source: ImageSource.gallery,
                                    );
                                    final data =
                                        await pickedImage?.readAsBytes();

                                    setState(() {
                                      _imageFile = data;
                                    });
                                  },
                                  icon: Icon(Icons.edit,
                                      size: Sizes.p28,
                                      color: AppColors.neutral600)),
                            )
                          ])
                        : _imageFile != null
                            ? Stack(
                                children: [
                                  Image.memory(
                                    _imageFile!,
                                    fit: BoxFit.cover,
                                    width: Sizes.deviceWidth * 0.85,
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 20,
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(Sizes.p8),
                                        ),
                                        child: IconButton(
                                          onPressed: () async {
                                            String imageUrl =
                                                await FirebaseStorageHelper
                                                    .updateUserImage(
                                                        _imageFile!);

                                            await userController
                                                .updateUserPicture(imageUrl);

                                            setState(() {
                                              _imageFile = null;
                                            });
                                            Get.forceAppUpdate();
                                          },
                                          icon: Icon(
                                            Icons.check,
                                            size: Sizes.p64,
                                            color: AppColors.green500,
                                          ),
                                        )),
                                  ),
                                ],
                              )
                            : GestureDetector(
                                onTap: () async {
                                  final pickedImage =
                                      await _imagePicker.pickImage(
                                    source: ImageSource.gallery,
                                  );
                                  final data = await pickedImage?.readAsBytes();

                                  setState(() {
                                    _imageFile = data;
                                  });
                                },
                                child: Icon(
                                  Icons.person,
                                  color: AppColors.neutral500,
                                  size: Sizes.p100,
                                ),
                              ));
              })),
        ),
      ),
    );
  }
}
