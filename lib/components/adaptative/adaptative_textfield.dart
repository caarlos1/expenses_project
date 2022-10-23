import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptativeTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onSubmitted;
  final TextInputType keyboardType;
  final String label;

  const AdaptativeTextField({
    required this.controller,
    required this.onSubmitted,
    required this.label,
    this.keyboardType = TextInputType.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: CupertinoTextField(
              controller: controller,
              onSubmitted: onSubmitted,
              keyboardType: keyboardType,
              placeholder: label,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            ),
          )
        : TextField(
            controller: controller,
            onSubmitted: onSubmitted,
            keyboardType: keyboardType,
            decoration: InputDecoration(labelText: label),
          );
  }
}
