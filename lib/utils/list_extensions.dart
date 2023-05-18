import 'dart:math' as math;

extension ListExtensions<T> on List<T> {
  List<T> everyNth(int n, {int start = 0}) => [for (var i = start; i < length; i += n) this[i]];

  List<List<T>> groupN(int n) => [for (var i = 0; i < length; i += n) getRange(i, math.min(i + n, length)).toList()];
}