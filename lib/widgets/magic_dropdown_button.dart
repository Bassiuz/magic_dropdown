import 'package:flutter/material.dart';

import 'dropdown_icon.dart';

class MagicDropdownButton extends StatelessWidget {
  const MagicDropdownButton(
      {Key? key, required this.animationController, required this.filterTitle})
      : super(key: key);
  final AnimationController? animationController;
  final String filterTitle;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(filterTitle),
            const SizedBox(width: 16),
            DropdownIcon(
              controller: animationController!,
            ),
          ],
        ),
      ),
    );
  }
}
