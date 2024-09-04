// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:lyrica_ver2/data/repositories/authentication.dart';
import 'package:lyrica_ver2/features/authentication/controllers/avatar/avatar_controller.dart';
import 'package:lyrica_ver2/features/music/screens/navigation_menu.dart';
import 'package:lyrica_ver2/utils/constants/image_string.dart';
import 'package:lyrica_ver2/utils/effects/loading/fullscreen_loader.dart';

class ChooseAvatarScreen extends StatelessWidget {
  late bool fromEdit;
  ChooseAvatarScreen({
    super.key,
    required this.fromEdit,
  });
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AvatarController());
    return Material(
      child: SingleChildScrollView(
        child: Container(
          height: 1000,
          decoration: const BoxDecoration(color: Color.fromRGBO(33, 15, 51, 1)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Back
              Container(
                margin: const EdgeInsets.only(top: 50, left: 24),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Text(
                    'Set your avatar',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(133, 128, 167, 1),
                        borderRadius: BorderRadius.circular(150),
                      ),
                      margin: EdgeInsets.only(top: 60),
                    ),
                    Positioned(
                      top: 60,
                      left: 0,
                      child: Obx(
                        () => Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(150),
                            image: DecorationImage(
                              image: AssetImage(controller.avatar.value),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  width: 350,
                  height: 300,
                  margin: const EdgeInsets.only(top: 26),
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    children: List.generate(
                      ImageString().imageString.length,
                      (index) {
                        if (index == 0) {
                          return Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 19,
                                  left: 18,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.image_rounded,
                                      color: Colors.black,
                                      size: 50,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return InkWell(
                            onTap: () => controller.setAvatar(
                                'assets/images/avatars/avt$index.png'),
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(60),
                                image: DecorationImage(
                                  image: AssetImage(
                                    ImageString().imageString[index],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 160,
                  margin: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (fromEdit) {
                        Navigator.pop(context);
                      } else {
                        FullScreenLoader.openLoadingDialog('Logging you in...',
                            'assets/animations/lyrica.json');
                        // stop time 1s
                        await Future.delayed(
                            const Duration(milliseconds: 1600));
                        FullScreenLoader.stopLoading();
                        AuthenticationRepository.instance.screenRedirect(
                            AuthenticationRepository().AuthUser);
                      }
                    },
                    child: const Text('Done'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
