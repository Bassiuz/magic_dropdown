import 'dart:async';

import 'package:flutter/material.dart';

import '../menu_state.dart';

/// Renders the overlay linked to the button pressed and displaying the dropdown.
///
/// The [layerLink] maps this overlays positioned starting point to the origin of the button.
/// The [heightOffset] is used to place the overlay exactly beneath the button
/// The [width] and [fullHeight] are used as a way to give a custom sizing to the overlay
/// The [child] is the widget rendered inside the overlay
/// With the [animationDuration] the duration of the slide up/down is given. This is experimental.
/// The [changeController] is used to listen to closing and opening events
OverlayEntry createOverlayEntry({
  required LayerLink layerLink,
  required double heightOffset,
  required double width,
  required double fullHeight,
  required Widget child,
  required Duration animationDuration,
  required StreamController<MenuState> changeController,
}) {
  return OverlayEntry(
      builder: (context) => _OverlayEntryWrapper(
            width: width,
            heightOffset: heightOffset,
            layerLink: layerLink,
            fullHeight: fullHeight,
            animationDuration: animationDuration,
            changeController: changeController,
            child: child,
          ));
}

class _OverlayEntryWrapper extends StatefulWidget {
  const _OverlayEntryWrapper({
    Key? key,
    required this.width,
    required this.heightOffset,
    required this.layerLink,
    required this.fullHeight,
    required this.child,
    required this.animationDuration,
    required this.changeController,
  }) : super(key: key);

  final double? width;
  final double heightOffset;
  final LayerLink layerLink;

  final double fullHeight;
  final Widget child;
  final Duration animationDuration;
  final StreamController<MenuState> changeController;

  @override
  State<_OverlayEntryWrapper> createState() => _OverlayEntryWrapperState();
}

class _OverlayEntryWrapperState extends State<_OverlayEntryWrapper> {
  MenuState menuState = MenuState.closed;
  @override
  void initState() {
    super.initState();
    widget.changeController.stream.listen(
      (event) {
        if (event == MenuState.closed) {
          setState(() {
            menuState = MenuState.closed;
          });
        }
        if (event == MenuState.open) {
          setState(() {
            menuState = MenuState.open;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: widget.width,
      child: CompositedTransformFollower(
        link: widget.layerLink,
        showWhenUnlinked: false,
        offset: Offset(0.0, widget.heightOffset),
        child: AnimatedSize(
          duration: widget.animationDuration,
          child: GestureDetector(
            child: Container(
                constraints: menuState == MenuState.closed
                    ? const BoxConstraints(maxHeight: 0.0)
                    : const BoxConstraints(maxHeight: double.infinity),
                child: widget.child),
          ),
        ),
      ),
    );
  }
}
