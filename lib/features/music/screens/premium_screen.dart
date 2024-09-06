import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lyrica_ver2/common/widgets/premium_feature_text/premium_feature_text.dart';
import 'package:lyrica_ver2/common/widgets/premium_pack/premium_pack.dart';
import 'package:lyrica_ver2/common/widgets/special/avatar.dart';
import 'package:lyrica_ver2/features/personalization/controllers/premium_controller/premium_controller.dart';
import 'package:lyrica_ver2/features/personalization/controllers/user_controller.dart';
import 'package:lyrica_ver2/features/personalization/screens/upload_music_screen.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PremiumController());
    final userController = UserController.to;
    return Obx(
      () => Scaffold(
        body: userController.isPremium.value
            ? UpLoadMusicScreen()
            : Container(
                color: const Color.fromRGBO(13, 3, 25, 1),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Header

                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 70, left: 30),
                            width: 190,
                            child: Text(
                              'Upgrade      to Premium',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .apply(
                                    letterSpacingDelta: 4,
                                  ),
                            ),
                          ),
                          // Avatar
                          Container(
                              margin: const EdgeInsets.only(top: 70, left: 120),
                              child: Avatar(
                                  height: 50,
                                  width: 50,
                                  img: 'assets/images/avatars/avt5.png')),
                        ],
                      ),

                      //Banner
                      Container(
                        margin: const EdgeInsets.only(top: 40),
                        height: 180,
                        width: 360,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(152, 103, 255, 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),

                      // Features

                      Container(
                        margin: const EdgeInsets.only(top: 40, left: 100),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 100, bottom: 20),
                              child: Text('Full access',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                            ),
                            const PremiumFeatureText(text: 'Puslish your own music'),
                            const PremiumFeatureText(text: 'Ad-free experience'),
                            const PremiumFeatureText(text: 'Personalized playlists'),
                            const PremiumFeatureText(text: 'AI-powered suggestions'),
                          ],
                        ),
                      ),

                      // pack
                      Obx(
                        () => InkWell(
                          onTap: () {
                            controller.pick1();
                            //show dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Premium Pack'),
                                  content: const Text(
                                      'Are you sure about choosing that package?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        userController.updateUserField(
                                            userController.user.value.id,
                                            'isPremium',
                                            true);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 30),
                            child: PremiumPack(
                              isBestChoice: controller.isPicked1.value,
                              title: 'Annual',
                              price: '\$19.99/year',
                            ),
                          ),
                        ),
                      ),

                      Obx(
                        () => InkWell(
                          onTap: () {
                            controller.pick2();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Premium Pack'),
                                  content: const Text(
                                      'Are you sure about choosing that package?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        userController.updateUserField(
                                            userController.user.value.id,
                                            'isPremium',
                                            true);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: PremiumPack(
                                isBestChoice: controller.isPicked2.value,
                                title: 'Monthly',
                                price: '\$1.99/month'),
                          ),
                        ),
                      ),
                      Obx(
                        () => InkWell(
                          onTap: () {
                            controller.pick3();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Premium Pack'),
                                  content: const Text(
                                      'Are you sure about choosing that package?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        userController.updateUserField(
                                            userController.user.value.id,
                                            'isPremium',
                                            true);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 30),
                            child: PremiumPack(
                              isBestChoice: controller.isPicked3.value,
                              title: 'Mini',
                              price: '\$0.09/day',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
