import 'package:flutter/material.dart';
import 'package:mcemeurckart/constants/index.dart';

import 'widgets/custom_search_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: Sizes.p24,
          right: Sizes.p24,
          top: Sizes.p48,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomSearchBar(),
              gapH12,
            ],
          ),
        ),
      ),
    );
  }
}
