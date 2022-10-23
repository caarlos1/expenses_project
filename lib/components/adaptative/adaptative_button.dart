import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;

  const AdaptativeButton(
      {required this.label, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton.filled(
            onPressed: onPressed,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(label),
          )
        : ElevatedButton(onPressed: onPressed, child: Text(label));
  }
}
