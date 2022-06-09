import 'package:flutter/material.dart';

import 'dropdown_icon.dart';

/// The default used button for the dropdown menu
///
/// [filterTitle] is the default text in the button. Provide an [animationController]
/// to animate the icon inside the button
class MagicDropdownButton extends StatelessWidget {
  const MagicDropdownButton(
      {Key? key, required this.animationController, required this.filterTitle})
      : super(key: key);
  final AnimationController? animationController;
  final String filterTitle;

  @override
  Widget build(BuildContext context) {
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
