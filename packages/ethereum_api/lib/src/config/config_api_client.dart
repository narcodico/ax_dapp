import 'package:ethereum_api/src/config/models/models.dart';
import 'package:ethereum_api/src/lsp/lsp.dart';
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
}
