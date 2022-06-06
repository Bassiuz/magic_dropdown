import 'package:flutter/material.dart';

class MagicDropdownSingleSelect extends StatefulWidget {
  const MagicDropdownSingleSelect(
      {Key? key,
      required this.selectableValues,
      required this.onChanged,
      this.selected})
      : super(key: key);

  final List<String> selectableValues;
  final void Function(String) onChanged;
  final String? selected;

  @override
  State<MagicDropdownSingleSelect> createState() =>
      _MagicDropdownSingleSelectState();
}

class _MagicDropdownSingleSelectState extends State<MagicDropdownSingleSelect> {
  String? _selection;

  @override
  Widget build(BuildContext context) {
    _selection = widget.selected;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          child: Column(
            children: widget.selectableValues
                .map((e) => ListTile(
                      title: Text(e),
                      leading: Radio<String>(
                        value: e,
                        groupValue: _selection,
                        onChanged: (String? value) {
                          setState(() {
                            _selection = value;
                          });
                          widget.onChanged(_selection!);
                        },
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
