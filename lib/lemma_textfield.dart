library flutter_pkg;

import 'package:flutter/material.dart';

import 'caret.dart';

class LemmaTextField extends StatefulWidget {
  var placeholder;

  LemmaTextField({Key? key, this.placeholder}) : super(key: key);

  @override
  State<LemmaTextField> createState() => _LemmaTextFieldState();
}

class _LemmaTextFieldState extends State<LemmaTextField> {
  late bool _caretVisibility = false;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {});
  }

  void showCaret() {
    if (mounted) {
      setState(() => _caretVisibility = true);
    }
  }

  void hideCaret() {
    if (mounted) {
      setState(() => _caretVisibility = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        cursor: SystemMouseCursors.text,
        child: InkWell(
          focusNode: _focusNode,
          onFocusChange: (hasFocus) {
            hasFocus ? showCaret() : hideCaret();
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.blueAccent)),
            child: Stack(
              children: [
                Text(
                  widget.placeholder,
                  style: TextStyle(
                      color: Color.fromRGBO(191, 191, 191, 1), fontSize: 18),
                ),
                Visibility(
                  child: Caret(),
                  visible: _caretVisibility,
                )
              ],
            ),
          ),
          onTap: () {
            _focusNode.requestFocus();
          },
        ));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
