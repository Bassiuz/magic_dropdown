import 'package:flutter/material.dart';

class DropdownIcon extends StatefulWidget {
  const DropdownIcon({Key? key, required this.controller}) : super(key: key);
  final AnimationController controller;

  @override
  DropdownIconState createState() => DropdownIconState();
}

class DropdownIconState extends State<DropdownIcon>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    _rotationAnimation =
        Tween<double>(begin: 0, end: -0.5).animate(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _rotationAnimation,
      child: const Icon(Icons.keyboard_arrow_down),
    );
  }
}
