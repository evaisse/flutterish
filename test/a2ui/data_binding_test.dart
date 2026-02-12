import 'package:flutter_test/flutter_test.dart';
import 'package:flutterish/flutterish.dart';

void main() {
  group('DataBindingResolver', () {
    test('resolves simple path', () {
      final data = {'name': 'Bob'};
      expect(DataBindingResolver.resolve(data, '/name'), 'Bob');
    });

    test('resolves nested path', () {
      final data = {'user': {'address': {'city': 'New York'}}};
      expect(DataBindingResolver.resolve(data, '/user/address/city'), 'New York');
    });

    test('returns null for missing key', () {
      final data = {'name': 'Bob'};
      expect(DataBindingResolver.resolve(data, '/age'), null);
    });

    test('updates simple path', () {
      final data = <String, dynamic>{'name': 'Bob'};
      DataBindingResolver.update(data, null, {'name': 'Alice'});
      expect(data['name'], 'Alice');
    });

    test('updates nested path', () {
      final data = <String, dynamic>{'user': {'name': 'Bob'}};
      DataBindingResolver.update(data, '/user', {'name': 'Alice'});
      expect(data['user']['name'], 'Alice');
    });

    test('updates nested path creating parents', () {
      final data = <String, dynamic>{};
      DataBindingResolver.update(data, '/user/profile', {'age': 30});
      expect(data['user']['profile']['age'], 30);
    });
  });
}
