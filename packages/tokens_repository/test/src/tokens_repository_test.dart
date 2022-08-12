// ignore_for_file: prefer_const_constructors
import 'package:ethereum_api/lsp_api.dart';
import 'package:ethereum_api/tokens_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:tokens_repository/tokens_repository.dart';

class MockTokensApiClient extends Mock implements TokensApiClient {}

class MockLongShortPair extends Mock implements LongShortPair {}

void main() {
  group('TokensRepository', () {
    late TokensApiClient tokensApiClient;
    late LongShortPair lspClient;

    setUp(() {
      tokensApiClient = MockTokensApiClient();
      lspClient = MockLongShortPair();
    });

    TokensRepository createSubject() => TokensRepository(
          tokensApiClient: tokensApiClient,
          lspClient: lspClient,
        );

    test('can be instantiated', () {
      expect(createSubject(), isNotNull);
    });
  });
}
