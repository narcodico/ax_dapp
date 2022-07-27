// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import 'package:tokens_repository/tokens_repository.dart';

void main() {
  group('TokensRepository', () {
    test('can be instantiated', () {
      expect(TokensRepository(), isNotNull);
    });
  });
}
