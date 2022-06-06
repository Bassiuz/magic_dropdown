import 'package:flutter/material.dart';

class MagicDropdownMultiSelect extends StatefulWidget {
  const MagicDropdownMultiSelect({
    Key? key,
    required this.selectableValues,
    required this.onChanged,
    this.selected = const [],
  }) : super(key: key);

  final List<String> selectableValues;
  final void Function(List<String>) onChanged;
  final List<String> selected;

  @override
  State<MagicDropdownMultiSelect> createState() =>
      _MagicDropdownMultiSelectState();
}

class _MagicDropdownMultiSelectState extends State<MagicDropdownMultiSelect> {
  List<String>? _selection;

  @override
  Widget build(BuildContext context) {
    _selection = widget.selected;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          child: Column(
            children: widget.selectableValues
                .map((e) => CheckboxListTile(
                      title: Text(e),
                      value: _selection?.contains(e),
                      onChanged: (newValue) {
                        setState(() {
                          if (newValue!) {
                            _selection!.add(e);
                          } else {
                            _selection!.remove(e);
                          }
                        });
                        widget.onChanged(_selection!);
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
