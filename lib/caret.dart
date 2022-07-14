library flutter_pkg;

import 'dart:async';

import 'package:flutter/material.dart';

import 'caret.dart';

class Caret extends StatefulWidget {
  const Caret({Key? key}) : super(key: key);

  @override
  State<Caret> createState() => _CaretState();
}

class _CaretState extends State<Caret> {
  bool _show = true;
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(milliseconds: 600), (_) {
      setState(() => _show = !_show);
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -1,
      top: -3,
      child: Text("|",
          style: _show
              ? TextStyle(
                  fontSize: 20,
                )
              : TextStyle(color: Colors.transparent)),
    );
  }
}
