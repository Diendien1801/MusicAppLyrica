import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:lyrica_ver2/features/music/controllers/search_controller.dart';

class MySearchBar extends StatelessWidget {
  final SearchingController searchingController =
      Get.put(SearchingController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              colors: [
                Color.fromRGBO(106, 53, 219, 1),
                Color.fromRGBO(195, 71, 216, 1),
              ],
              tileMode: TileMode.mirror,
            ).createShader(bounds);
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white,
                width: 1,
              ),
            ),
            child: TextField(
              controller: searchingController.searchEditController,
              onTap: () {
                searchingController.changeShowListView();
              },
              onEditingComplete: () {
                searchingController.changeShowListView();
                FocusScope.of(context).unfocus();
              },
              onChanged: (value) {
                if (searchingController.searchEditController.text.isEmpty) {
                  searchingController.searchSongList.clear();
                }
                searchingController.getNames();
              },
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 12),
                hintText: 'Search ',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
