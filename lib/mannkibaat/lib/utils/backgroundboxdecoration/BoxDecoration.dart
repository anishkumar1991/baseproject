import 'package:flutter/material.dart';

class BoxDecorationWidget {
  static getBoxDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFFFFFF), Color(0xFFF3F7FF)],
      ),
    );
  }
}
