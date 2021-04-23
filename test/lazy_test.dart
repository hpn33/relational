import 'package:flutter_test/flutter_test.dart';
import 'package:relational/util/lazy.dart';

void main() {
  group('lazy value', () {
    test('simple', () {
      final lazy = LazyValue<String>(() => '1');

      expect(lazy.value, '1');
    });
  });

  group('lazy list', () {
    test('simple', () {
      final lazy = LazyListValue<int>(() => [0, 0, 1]);

      expect(lazy.list, [0, 0, 1]);
    });
  });
}
