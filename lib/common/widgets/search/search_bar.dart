import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lyrica_ver2/features/music/controllers/search_controller.dart';

class MySearchBar extends StatelessWidget {
  final SearchingController searchingController =
      Get.put(SearchingController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color.fromRGBO(106, 53, 219, 0.85),
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            controller: searchingController.searchEditController,
            onTap: () {
              searchingController.changeShowListView();
              print('ok');
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
            decoration: InputDecoration(
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
      ],
    );
  }
}
