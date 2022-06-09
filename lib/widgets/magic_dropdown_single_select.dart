import 'package:flutter/material.dart';

/// The [MagicDropdownSingleSelect] provides a standard way to render checkboxes in a list as a means to filter through your items.
///
/// All values and already selected value are provided with [selectableValues] and [selected] respectively. The [onChanged] handler returns the currently selected option after making a selection.
/// With the [width] and [height], a custom sizing can be provided
class MagicDropdownSingleSelect extends StatefulWidget {
  const MagicDropdownSingleSelect(
      {Key? key,
      required this.selectableValues,
      required this.onChanged,
      this.selected,
      this.height,
      this.width})
      : super(key: key);

  final List<String> selectableValues;
  final void Function(String) onChanged;
  final String? selected;
  final double? height;
  final double? width;

  @override
  State<MagicDropdownSingleSelect> createState() =>
      _MagicDropdownSingleSelectState();
}

class _MagicDropdownSingleSelectState extends State<MagicDropdownSingleSelect> {
  String? _selection;

  @override
  Widget build(BuildContext context) {
    _selection = widget.selected;
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: SingleChildScrollView(
        child: Card(
          child: SingleChildScrollView(
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
        ),
      ),
    );
  }
}
