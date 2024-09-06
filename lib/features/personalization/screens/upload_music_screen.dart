
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lyrica_ver2/common/widgets/special/avatar.dart';
import 'package:lyrica_ver2/features/personalization/controllers/upload_music_controller.dart';
import 'package:lyrica_ver2/utils/validators/validator_text_form.dart';

class UpLoadMusicScreen extends StatelessWidget {
  const UpLoadMusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final upLoadController = Get.put(UpLoadMusicController());

    return Scaffold(
      body: Container(
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
                      'Share         your music',
                      style: Theme.of(context).textTheme.headlineMedium!.apply(
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
              InkWell(
                onTap: () {
                  upLoadController.pickImage();
                },
                child: Obx(
                  () => Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 40, left: 120),
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(152, 103, 255, 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      upLoadController.image.value.path.isEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 186, top: 80),
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/icons/uploadImage.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 140, top: 20),
                                  height: 70,
                                  width: 300,
                                  child: Text(
                                    'Upload cover image ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .apply(
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                              ],
                            )
                          : Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 186, top: 100),
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/icons/uploadImage.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 180,
                                  width: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: FileImage(
                                          upLoadController.image.value),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),

              // Features

              Form(
                child: Column(
                  children: [
                    SizedBox(
                      height: 110,
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 30),
                            height: 56,
                            width: 360,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.transparent),
                              color: const Color.fromRGBO(41, 27, 60, 1),
                            ),
                          ),
                          Positioned(
                            top: 32,
                            left: 24,
                            child: SizedBox(
                              height: 120,
                              width: 360,
                              child: TextFormField(
                                controller: upLoadController.songName,
                                validator: (value) =>
                                    ValidatorTextForm.validateInput(value!),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(top: 5),
                                  hintText: 'Song Name',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .apply(
                                        color: const Color.fromRGBO(133, 128, 167, 1),
                                      ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .transparent), // Customize the border color when there's an error
                                  ),
                                  focusedErrorBorder:
                                      const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    // Customize the border color when focused and there's an error
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 0),
                            height: 56,
                            width: 360,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.transparent),
                              color: const Color.fromRGBO(41, 27, 60, 1),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 24,
                            child: SizedBox(
                              height: 120,
                              width: 360,
                              child: TextFormField(
                                controller: upLoadController.artist,
                                validator: (value) =>
                                    ValidatorTextForm.validateInput(value!),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(top: 5),
                                  hintText: 'Artist\'s Name',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .apply(
                                        color: const Color.fromRGBO(133, 128, 167, 1),
                                      ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .transparent), // Customize the border color when there's an error
                                  ),
                                  focusedErrorBorder:
                                      const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .transparent), // Customize the border color when focused and there's an error
                                  ),
                                ), // Add closing parenthesis here
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 56,
                            width: 360,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.transparent),
                              color: const Color.fromRGBO(41, 27, 60, 1),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 24,
                            child: SizedBox(
                              height: 120,
                              width: 360,
                              child: TextFormField(
                                controller: upLoadController.genre,
                                validator: (value) =>
                                    ValidatorTextForm.validateInput(value!),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(top: 5),
                                  hintText: 'Music genre',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .apply(
                                        color: const Color.fromRGBO(133, 128, 167, 1),
                                      ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .transparent), // Customize the border color when there's an error
                                  ),
                                  focusedErrorBorder:
                                      const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .transparent), // Customize the border color when focused and there's an error
                                  ),
                                ), // Add closing parenthesis here
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Upload Button
              InkWell(
                onTap: () {
                  upLoadController.upLoad();
                },
                child: Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(218, 0, 255, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(top: 10, bottom: 40),
                  child: Center(
                    child: Text(
                      'Upload',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
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

// InkWell(
//             onTap: () async {
//               
//             },
//             child: Icon(Icons.add),
//           ),
