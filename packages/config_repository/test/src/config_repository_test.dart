// ignore_for_file: prefer_const_constructors
import 'package:config_repository/config_repository.dart';
import 'package:test/test.dart';

void main() {
  group('ConfigRepository', () {
    test('can be instantiated', () {
      expect(ConfigRepository(), isNotNull);
    });
  });
}
