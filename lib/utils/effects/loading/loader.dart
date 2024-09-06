// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:lyrica_ver2/utils/constants/colors.dart';

// Widget for displaying a loading animation indicator with optional text and action button
// ignore: must_be_immutable
class AnimationLoaderWidget extends StatelessWidget {
  /// Default constructor for the AnimationLoaderWidget
  ///
  /// Parameters:
  /// - text: The text to display below the animation
  /// - animation: The path to the Lottie animation file
  /// - showAction: Whether to show the action button below the text
  /// - actionText: The text to display on the action button
  /// - onActionPressed: The callback function to call when the action button is pressed
  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;
  bool isIntro;
  AnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
    required this.isIntro,
  });
  @override
  Widget build(BuildContext context) {
    return isIntro == false
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(animation,
                    width: MediaQuery.of(context).size.width * 0.8),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16,
                ),
                showAction
                    ? SizedBox(
                        width: 250,
                        child: OutlinedButton(
                          onPressed: onActionPressed,
                          child: Text(
                            actionText!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: TColors.light),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          )
        : Container(
            child: Lottie.asset(animation,
                width: MediaQuery.of(context).size.width),
          );
  }
}
