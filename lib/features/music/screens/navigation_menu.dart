import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrica_ver2/features/music/controllers/navigation_menu_controller.dart';

class NavigationMenu extends StatelessWidget {
  final NavigationController navigationController =
      Get.put(NavigationController());
  final int initialIndex;
  NavigationMenu({super.key, this.initialIndex = 0}) {
    navigationController.selectedIndex.value = initialIndex;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          indicatorColor: Colors.transparent,
          overlayColor:
              MaterialStateProperty.resolveWith((states) => Colors.transparent),
          height: 80,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedIndex: navigationController.selectedIndex.value,
          onDestinationSelected: (index) =>
              navigationController.selectedIndex.value = index,
          destinations: [
            NavigationDestination(
              icon: Image.asset(
                'assets/icons/home.png',
                color: Colors.white,
                height: 20,
                width: 20,
              ),
              selectedIcon: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                child: Image.asset(
                  'assets/icons/home.png',
                  color: Colors.white,
                  height: 25,
                  width: 25,
                ),
              ),
              label: '',
            ),
            NavigationDestination(
              icon: Image.asset(
                'assets/icons/search2.png',
                color: Colors.white,
                height: 20,
                width: 20,
              ),
              selectedIcon: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                child: Image.asset(
                  'assets/icons/search2.png',
                  color: Colors.white,
                  height: 23,
                  width: 23,
                ),
              ),
              label: '',
            ),
            NavigationDestination(
              icon: Image.asset(
                'assets/icons/album2.png',
                color: Colors.white,
                height: 22,
                width: 22,
              ),
              selectedIcon: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                child: Image.asset(
                  'assets/icons/album2.png',
                  color: Colors.white,
                  height: 26,
                  width: 26,
                ),
              ),
              label: '',
            ),
            NavigationDestination(
              icon: Image.asset(
                'assets/icons/dimond.png',
                color: Colors.white,
                height: 22,
                width: 22,
              ),
              selectedIcon: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                child: Image.asset(
                  'assets/icons/dimond.png',
                  color: Colors.white,
                  height: 26,
                  width: 26,
                ),
              ),
              label: '',
            ),
          ],
        ),
      ),
      body: Obx(() => navigationController
          .screens[navigationController.selectedIndex.value]),
    );
  }
}
