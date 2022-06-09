import 'package:flutter/material.dart';

/// The DropdownIcon animates a chevron down and rotates it up when dropdown is opened.
///
/// Provide a [controller] that controls the animation for the icon to actually animate.
class DropdownIcon extends StatelessWidget {
  const DropdownIcon({Key? key, required this.controller}) : super(key: key);
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween<double>(begin: 0, end: -0.5).animate(controller),
      child: const Icon(Icons.keyboard_arrow_down),
    );
  }
}
