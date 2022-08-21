// ignore_for_file: prefer_const_constructors
import 'package:config_repository/config_repository.dart';
import 'package:ethereum_api/config_api.dart';
import 'package:ethereum_api/tokens_api.dart';
import 'package:ethereum_api/wallet_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockConfigApiClient extends Mock implements ConfigApiClient {}

class MockWalletApiClient extends Mock implements WalletApiClient {}

class MockTokensApiClient extends Mock implements TokensApiClient {}

void main() {
  late ConfigApiClient configApiClient;
  late WalletApiClient walletApiClient;
  late TokensApiClient tokensApiClient;

  group('ConfigRepository', () {
    setUp(() {
      configApiClient = MockConfigApiClient();
      walletApiClient = MockWalletApiClient();
      tokensApiClient = MockTokensApiClient();
    });

    test('can be instantiated', () {
      expect(
        ConfigRepository(
          configApiClient: configApiClient,
          walletApiClient: walletApiClient,
          tokensApiClient: tokensApiClient,
        ),
        isNotNull,
      );
    });
  });
}
