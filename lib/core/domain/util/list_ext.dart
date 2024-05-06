import 'dart:math';

extension RandomItemExtension<T> on List<T> {
  T getRandomItem() {
    final randomIndex = Random().nextInt(length);
    return this[randomIndex];
  }
}
