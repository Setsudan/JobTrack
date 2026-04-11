import 'dart:math';

String newJobApplicationId() {
  final r = Random();
  return '${DateTime.now().microsecondsSinceEpoch}_${r.nextInt(1 << 30)}';
}
