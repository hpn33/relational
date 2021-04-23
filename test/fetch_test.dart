import 'package:flutter_test/flutter_test.dart';
import 'package:relational/util/fetch.dart';

void main() {
  group('fetch value', () {
    test('simple', () {
      final fetch = FetchValue<String>((v) => '1');

      expect(fetch.value, '1');
    });

    test('with fetch', () {
      int index = 1;
      final fetch = FetchValue<int>((v) => index);

      expect(fetch.value, index);

      index++;
      fetch();

      expect(fetch.value, index);
    });
  });

  group('fetch list', () {
    test('simple', () {
      final fetch = FetchListValue<int>((list) => [0, 0, 1]);

      expect(fetch.list, [0, 0, 1]);
    });
  });
}
