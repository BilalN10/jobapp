import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:job_app/view/preferances/preferances_page.dart';

class SearchInputField extends StatelessWidget {
  SearchInputField({super.key, required this.searchController, this.hintText});
  String? hintText;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.black),
      onTap: () {
        Get.to(() => const PreferancesPage());
      },
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: GestureDetector(
            onTap: () {
              Get.to(() => const PreferancesPage());
            },
            child: SvgPicture.asset(
              "assets/icons/Filter.svg",
            ),
          ),
        ),
        prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              "assets/icons/search.svg",
            )),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
          //<-- SEE HERE
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
          //<-- SEE HERE
        ),
      ),
    );
  }
}
