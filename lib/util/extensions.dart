import 'dart:math' as math;

extension IterableExtension on Iterable<double> {
  double get max => reduce(math.max);

  double get min => reduce(math.min);
}
