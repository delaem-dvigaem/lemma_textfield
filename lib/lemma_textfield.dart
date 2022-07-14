library flutter_pkg;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LemmaTextField extends StatefulWidget {
  var placeholder;

  LemmaTextField({Key? key, this.placeholder}) : super(key: key);

  @override
  State<LemmaTextField> createState() => _LemmaTextFieldState();
}

class _LemmaTextFieldState extends State<LemmaTextField> {
  late bool _caretVisibility = false;
  late bool _placeholderVisibility = true;
  late double _caretX;
  late double _caretY;
  bool _show = true;
  late Timer _timer;
  final _focusNode = FocusNode();
  final focusNode = FocusNode();
  late var content = '';

  @override
  void initState() {
    _caretX = 0;
    _caretY = -1;
    super.initState();
    _focusNode.addListener(() {});
    _timer = Timer.periodic(Duration(milliseconds: 600), (_) {
      setState(() => _show = !_show);
    });
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

  void showPlaceholder() {
    if (mounted) {
      setState(() => _placeholderVisibility = true);
    }
  }

  void hidePlaceholder() {
    if (mounted) {
      setState(() => _placeholderVisibility = false);
    }
  }

  void addCharacter(character) {
    setState(() {
      content = content + character;
      _caretX = _caretX + 2;
    });
  }

  void removeCharacter() {
    setState(() {
      if (content != null && content.length > 0) {
        content = content.substring(0, content.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
        onKeyEvent: (node, event) {
          if (event.character != ' ' &&
              event.character != null &&
              event.logicalKey.keyLabel != 'Backspace') {
            addCharacter(event.character);
          }
          if (event.character == ' ' &&
              event.logicalKey.keyLabel != 'Backspace') {
            addCharacter(event.character);
          }
          if (event.logicalKey.keyLabel == 'Backspace') {
            removeCharacter();
          }
          if (content.length > 0) {
            hidePlaceholder();
          } else {
            showPlaceholder();
          }
          return KeyEventResult.handled;
        },
        child: MouseRegion(
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
                    Text.rich(TextSpan(
                      text: content,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      children: [
                        TextSpan(
                            text: "|",
                            style: _show
                                ? TextStyle(
                                    fontSize: 18,
                                  )
                                : TextStyle(color: Colors.transparent))
                      ],
                    )),
                    Visibility(
                      visible: _placeholderVisibility,
                      child: Text(
                        widget.placeholder,
                        style: const TextStyle(
                            color: Color.fromRGBO(191, 191, 191, 1),
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                _focusNode.requestFocus();
              },
            )));
  }

  @override
  void dispose() {
    _timer.cancel();
    _focusNode.dispose();
    super.dispose();
  }
}
