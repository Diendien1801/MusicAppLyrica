import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lyrica_ver2/features/music/screens/album_screen.dart';
import 'package:lyrica_ver2/features/music/screens/home_screen.dart';
import 'package:lyrica_ver2/features/music/screens/premium_screen.dart';
import 'package:lyrica_ver2/features/music/screens/search_screen.dart';


class NavigationController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Widget> screens = [
    const HomeScreen(),
    SearchScreen(),
    const AlbumScreen(),
    const PremiumScreen(),
  ];
}
