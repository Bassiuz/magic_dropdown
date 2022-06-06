import 'dart:async';

import 'package:flutter/material.dart';
import 'package:magic_dropdown/dropdown_mode.dart';
import 'package:magic_dropdown/widgets/magic_dropdown_button.dart';
import 'package:magic_dropdown/widgets/magic_dropdown_multi_select.dart';
import 'package:magic_dropdown/widgets/magic_dropdown_single_select.dart';

import 'menu_state.dart';
import 'overlay_entries/overlay_entry_wrapper.dart';

class MagicDropdown extends StatefulWidget {
  const MagicDropdown(
      {Key? key,
      this.child,
      this.customWidth,
      this.selectableValues,
      this.selectedValues = const [],
      this.height = 400,
      this.filterTitle = "No Filter Title Provided",
      this.animationDuration = const Duration(milliseconds: 1),
      this.onSingleValueSelected,
      this.onMultiValueSelected,
      this.dropdownMode = DropdownMode.customChild})
      : super(key: key);
  final Widget? child;
  final double? customWidth;
  final double height;
  final String filterTitle;
  final Duration animationDuration;
  final List<String>? selectableValues;
  final List<String> selectedValues;
  final void Function(String)? onSingleValueSelected;
  final void Function(List<String>)? onMultiValueSelected;

  final DropdownMode dropdownMode;

  @override
  MagicDropdownState createState() => MagicDropdownState();
}

class MagicDropdownState extends State<MagicDropdown>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  OverlayEntry? _outsideClickDetector;

  final GlobalKey _globalKey = GlobalKey(debugLabel: "magic_dropdown_key");

  final LayerLink _layerLink = LayerLink();
  AnimationController? animationController;
  StreamController<MenuState>? changeController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  void dispose() {
    animationController?.dispose();
    changeController?.close();

    super.dispose();
  }

  MenuState menuState = MenuState.closed;

  void _onTap() {
    switch (menuState) {
      case MenuState.closed:
        _openMenu();
        break;
      case MenuState.animating:
        break;
      case MenuState.open:
        _closeMenu();
        break;
    }
  }

  Future<void> _closeMenu() async {
    menuState = MenuState.animating;
    animationController?.reverse();
    changeController!.add(MenuState.closed);

    await Future.delayed(widget.animationDuration, () {
      _overlayEntry?.remove();
      _outsideClickDetector?.remove();

      changeController?.close();
      menuState = MenuState.closed;
    });
  }

  Future<void> _openMenu() async {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    menuState = MenuState.animating;
    changeController = StreamController<MenuState>();

    animationController?.forward();

    _outsideClickDetector = createClickDetector();
    Overlay.of(context)!.insert(_outsideClickDetector!);

    _overlayEntry = createOverlayEntry(
        layerLink: _layerLink,
        heightOffset: size.height,
        width: widget.customWidth ?? size.width,
        fullHeight: widget.height,
        changeController: changeController!,
        animationDuration: widget.animationDuration,
        child: widget.dropdownMode == DropdownMode.customChild
            ? widget.child!
            : widget.dropdownMode == DropdownMode.single
                ? _createSingleSelect()
                : _createMultiSelect());

    Overlay.of(context)!.insert(_overlayEntry!);

    changeController!.add(MenuState.open);

    await Future.delayed(widget.animationDuration, () {
      menuState = MenuState.open;
    });
  }

  Widget _createSingleSelect() {
    return MagicDropdownSingleSelect(
        onChanged: (selection) {
          _closeMenu();
          if (widget.onSingleValueSelected != null) {
            widget.onSingleValueSelected!(selection);
          }
        },
        selected:
            widget.selectedValues.isNotEmpty ? widget.selectedValues[0] : null,
        selectableValues: widget.selectableValues!);
  }

  Widget _createMultiSelect() {
    return MagicDropdownMultiSelect(
        onChanged: (selection) {
          if (widget.onMultiValueSelected != null) {
            widget.onMultiValueSelected!(selection);
          }
        },
        selected: widget.selectedValues,
        selectableValues: widget.selectableValues!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onTap();
      },
      child: CompositedTransformTarget(
        link: _layerLink,
        child: Container(
          key: _globalKey,
          child: MagicDropdownButton(
            filterTitle: widget.filterTitle,
            animationController: animationController,
          ),
        ),
      ),
    );
  }

  OverlayEntry? createClickDetector() {
    return OverlayEntry(
        builder: (context) => Positioned(
                child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTapDown: (details) async {
                await _closeMenu();
              },
              child: Container(
                decoration:
                    const BoxDecoration(color: Color.fromARGB(10, 0, 0, 0)),
              ),
            )));
  }
}