import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/common_widgets/index.dart';
import 'package:mcemeurckart/constants/index.dart';

class CustomSearchBar extends StatelessWidget {
  CustomSearchBar({Key? key}) : super(key: key);

  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchController,
      onChanged: (value) {},
      decoration: InputDecoration(
        counterText: '',
        isDense: true,
        prefixIcon: Padding(
            padding: EdgeInsets.all(
              Sizes.p4,
            ),
            child: Icon(
              Icons.search,
              color: AppColors.neutral600,
            )),
        hintText: 'Search by keyword or categories',
        hintStyle: Get.textTheme.displaySmall?.copyWith(
          color: AppColors.neutral400,
          fontWeight: Fonts.interRegular,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }
}
