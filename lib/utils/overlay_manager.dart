import 'package:flutter/material.dart';

class OverlayIndicatorManager {
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  static void show(BuildContext context) {
    if (!_isVisible) {
      _overlayEntry = OverlayEntry(
        builder: (BuildContext context) {
          return Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child:
                  CircularProgressIndicator(), // Show CircularProgressIndicator when loading
            ),
          );
        },
      );
      Overlay.of(context).insert(_overlayEntry!);
      _isVisible = true;
    }
  }

  static void hide() {
    if (_isVisible) {
      _overlayEntry?.remove();
      _isVisible = false;
    }
  }
}
