import 'package:flutter/services.dart';

abstract final class JobTrackHaptics {
  static void button() {
    HapticFeedback.lightImpact();
  }

  static void selection() {
    HapticFeedback.selectionClick();
  }

  static void action() {
    HapticFeedback.mediumImpact();
  }
}
