import 'package:ethereum_api/src/apt_router/apt_router.dart';
import 'package:ethereum_api/src/config/models/models.dart';
import 'package:ethereum_api/src/dex/dex.dart';
import 'package:ethereum_api/src/lsp/lsp.dart';
import 'package:ethereum_api/src/wallet/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:shared/shared.dart';

/// {@template config_api_client}
/// Client that manages `Ethereum` related configurations.
/// {@endtemplate}
class ConfigApiClient {
  /// {@macro config_api_client}
  ConfigApiClient({required http.Client httpClient}) : _httpClient = httpClient;

  final http.Client _httpClient;

  final _web3ClientController = BehaviorSubject<Web3Client>();
  final _aptRouterClientController = BehaviorSubject<APTRouter>();
  final _dexClientController = BehaviorSubject<Dex>();

  final _lspClientController = BehaviorSubject<LongShortPair>();

  /// Returns the current [LongShortPair] address synchronously.
  String get currentLspAddress => _lspClientController.value.self.address.hex;

  /// Creates and returns the initial [AppConfig] which is used to pass down
  /// reactive dependencies.
  AppConfig initializeAppConfig() {
    return AppConfig(
      reactiveWeb3Client: _web3ClientController.stream,
      reactiveAptRouterClient: _aptRouterClientController.stream,
      reactiveDexClient: _dexClientController.stream,
      reactiveLspClient: _lspClientController.stream,
    );
  }

  /// Switches dependencies and then disposes of the old ones.
  void switchDependencies(EthereumChain chain) {
    final previousWeb3Client = _web3ClientController.valueOrNull;
    final web3Client = chain.createWeb3Client(_httpClient);
    _web3ClientController.add(web3Client);
    previousWeb3Client?.dispose();

    final aptRouterClient = chain.createAptRouterClient(web3Client);
    _aptRouterClientController.add(aptRouterClient);

    final dexClient = chain.createDexClient(web3Client);
    _dexClientController.add(dexClient);
  }

  /// Switches the [LongShortPair] client.
  void switchLspClient(String pairAddress) {
    final lspClient = LongShortPair(
      address: EthereumAddress.fromHex(pairAddress),
      client: _web3ClientController.value,
    );
    _lspClientController.add(lspClient);
  }
}
