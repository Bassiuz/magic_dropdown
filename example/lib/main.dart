import 'package:flutter/material.dart';
import 'package:magic_dropdown/dropdown_mode.dart';
import 'package:magic_dropdown/magic_dropdown.dart';
import 'package:magic_dropdown/widgets/magic_dropdown_multi_select.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic Dropdown Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Magic Dropdown Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _selection;
  String _selection2 = "Two";
  List<String> _selection3 = ["Three", "Four"];
  List<String> _selection4 = ["Three", "Four"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey.shade200),
              ),
            ),
            Center(
              child: MagicDropdown(
                filterTitle: "Single Selectable List",
                dropdownMode: DropdownMode.single,
                selectableValues: const ["One", "Two", "Three", "Four", "Five"],
                selectedValues: _selection == null ? [] : [_selection!],
                onSingleValueSelected: (String? value) {
                  setState(() {
                    _selection = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey.shade200),
              ),
            ),
            Center(
              child: MagicDropdown(
                filterTitle: "Single Selectable List With Preselection",
                dropdownMode: DropdownMode.single,
                selectableValues: const ["One", "Two", "Three", "Four", "Five"],
                selectedValues: [_selection2],
                onSingleValueSelected: (String? value) {
                  setState(() {
                    _selection2 = value!;
                  });
                },
              ),
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey.shade200),
              ),
            ),
            Center(
              child: MagicDropdown(
                filterTitle: "Multi Selectable List With Preselection",
                dropdownMode: DropdownMode.multi,
                selectableValues: const ["One", "Two", "Three", "Four", "Five"],
                selectedValues: _selection3,
                onMultiValueSelected: (List<String>? value) {
                  setState(() {
                    _selection3 = value!;
                  });
                },
              ),
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey.shade200),
              ),
            ),
            Center(
              child: MagicDropdown(
                filterTitle: "Multi Selectable List With capped height",
                dropdownMode: DropdownMode.multi,
                height: 200,
                selectableValues: const ["One", "Two", "Three", "Four", "Five"],
                selectedValues: _selection3,
                onMultiValueSelected: (List<String>? value) {
                  setState(() {
                    _selection3 = value!;
                  });
                },
              ),
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey.shade200),
              ),
            ),
            Center(
              child: MagicDropdown(
                filterTitle: "Multi Selectable List As Custom Child",
                dropdownMode: DropdownMode.customChild,
                child: Column(
                  children: [
                    const Card(child: Text('Multi select some of these:')),
                    MagicDropdownMultiSelect(
                        onChanged: (selection) {
                          setState(() {
                            _selection4 = selection;
                          });
                        },
                        selected: _selection4,
                        selectableValues: const [
                          "One",
                          "Two",
                          "Three",
                          "Four",
                          "Five"
                        ]),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey.shade200),
              ),
            ),
            Center(
              child: MagicDropdown(
                filterTitle: "Custom child",
                child: SizedBox(
                  width: 120,
                  height: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Custom child",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey.shade200),
              ),
            ),
            Center(
              child: MagicDropdown(
                filterTitle: "Custom child and custom button",
                customButton: Card(
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.amber),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text("Custom child and custom button"),
                    ),
                  ),
                ),
                child: SizedBox(
                  width: 120,
                  height: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Custom child",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey.shade200),
              ),
            ),
            Center(
              child: MagicDropdown(
                filterTitle: "Custom child with custom width",
                customWidth: 400,
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey.shade200),
              ),
            ),
            Center(
              child: MagicDropdown(
                filterTitle: "Custom child with different animation duration",
                animationDuration: const Duration(seconds: 2),
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey.shade200),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class MyTest extends StatefulWidget {
  const MyTest({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyTest> createState() => _MyTestState();
}

class _MyTestState extends State<MyTest> {
  OverlayEntry? _outsideClickDetector;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(children: [
          Column(
            children: [
              TextButton(
                  onPressed: (() => _showOverlay()),
                  child: const Text("Button 1")),
              TextButton(
                  onPressed: (() => _showOverlay()),
                  child: const Text("Button 2"))
            ],
          ),
          Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (details) async {
              print('hallo');
            },
            child: Container(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(100, 0, 0, 0)),
            ),
          )
        ]),
      ),
    );
  }

  void _showOverlay() {
    print('button click');

    _outsideClickDetector = createClickDetector();
    Overlay.of(context)!.insert(_outsideClickDetector!);
  }

  OverlayEntry? createClickDetector() {
    return OverlayEntry(
        builder: (context) => Positioned(
                child: Listener(
              behavior: HitTestBehavior.translucent,
              onPointerDown: (details) async {
                _outsideClickDetector?.remove();
              },
              child: Container(
                decoration:
                    const BoxDecoration(color: Color.fromARGB(100, 0, 0, 0)),
              ),
            )));
  }
}
