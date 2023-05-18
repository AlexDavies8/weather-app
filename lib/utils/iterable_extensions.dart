extension IterableZipExtension<T> on Iterable<Iterable<T>> {
  Iterable<List<T>> zip() sync* {
    if (isEmpty) return;
    final iterators = map((e) => e.iterator).toList(growable: false);
    while (iterators.every((e) => e.moveNext())) {
      yield iterators.map((e) => e.current).toList(growable: false);
    }
  }
}