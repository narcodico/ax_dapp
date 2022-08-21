import 'package:config_repository/src/models/models.dart';
import 'package:ethereum_api/config_api.dart';
import 'package:ethereum_api/lsp_api.dart';
import 'package:ethereum_api/tokens_api.dart';
import 'package:ethereum_api/wallet_api.dart';
import 'package:shared/shared.dart';

/// {@template config_repository}
/// Repository that manages configurations.
/// {@endtemplate}
class ConfigRepository {
  /// {@macro config_repository}
  ConfigRepository({
    required ConfigApiClient configApiClient,
    required WalletApiClient walletApiClient,
    required TokensApiClient tokensApiClient,
  })  : _configApiClient = configApiClient,
        _walletApiClient = walletApiClient,
        _tokensApiClient = tokensApiClient;

  final ConfigApiClient _configApiClient;
  final WalletApiClient _walletApiClient;
  final TokensApiClient _tokensApiClient;

  /// Allows listening to when all app data has finished changing as a result
  /// of chain switching.
  ///
  /// This is particularly useful when we need to make sure the chain, tokens
  /// and dependencies finished changing before refetching information.
  Stream<AppData> get appDataChanges =>
      ZipStream.zip3<EthereumChain, List<Token>, void, AppData>(
        _walletApiClient.chainChanges,
        _tokensApiClient.tokensChanges,
        _configApiClient.dependenciesChanges,
        (chain, tokens, _) => AppData(chain: chain, tokens: tokens),
      );

  /// Allows listening to when dependencies change. Used to refetch data that
  /// is based on reactive dependencies.
  Stream<void> get dependenciesChanges => _configApiClient.dependenciesChanges;

  /// Returns the current [LongShortPair] address synchronously.
  String get currentLspAddress => _configApiClient.currentLspAddress;

  /// Creates and returns the initial [AppConfig] which is used to pass down
  /// reactive dependencies.
  AppConfig initializeAppConfig() => _configApiClient.initializeAppConfig();

  /// Switches dependencies and then disposes of the old ones.
  void switchDependencies(EthereumChain chain) =>
      _configApiClient.switchDependencies(chain);

  /// Switches the [LongShortPair] client.
  void switchLspClient(String pairAddress) =>
      _configApiClient.switchLspClient(pairAddress);
}
