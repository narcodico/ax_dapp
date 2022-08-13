import 'package:ethereum_api/src/config/models/models.dart';
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
  final _lspController = BehaviorSubject<LongShortPair>();

  /// Creates and returns the initial [AppConfig] which is used to pass down
  /// reactive dependencies.
  AppConfig initializeAppConfig() {
    return AppConfig(
      reactiveWeb3Client: _web3ClientController.stream,
      reactiveLspClient: _lspController.stream,
    );
  }

  /// Switches dependencies and then disposes of the old ones.
  void switchDependencies(EthereumChain chain) {
    final previousWeb3Client = _web3ClientController.valueOrNull;
    final web3Client = chain.createWeb3Client(_httpClient);
    _web3ClientController.add(web3Client);
    previousWeb3Client?.dispose();

    // When chain changes, we recreate an existing [LongShortPair] at the same
    // address but with the latest [Web3Client].
    final previousLspClient = _lspController.valueOrNull;
    if (previousLspClient != null) {
      final previousLspAddress = previousLspClient.self.address;
      final lspClient =
          LongShortPair(address: previousLspAddress, client: web3Client);
      _lspController.add(lspClient);
    }
  }

  /// Switches the [LongShortPair] client.
  void switchLspClient(String pairAddress) {
    final lspClient = LongShortPair(
      address: EthereumAddress.fromHex(pairAddress),
      client: _web3ClientController.value,
    );
    _lspController.add(lspClient);
  }
}
