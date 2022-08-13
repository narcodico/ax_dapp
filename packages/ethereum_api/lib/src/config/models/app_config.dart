import 'package:ethereum_api/src/lsp/lsp.dart';
import 'package:shared/shared.dart';

/// {@template app_config}
/// Holds reactive dependencies.
/// {@endtemplate}
class AppConfig extends Equatable {
  /// {@macro app_config}
  const AppConfig({
    required this.reactiveWeb3Client,
    required this.reactiveLspClient,
  });

  /// Reactive [Web3Client].
  final ValueStream<Web3Client> reactiveWeb3Client;

  /// Reactive [LongShortPair] client.
  final ValueStream<LongShortPair> reactiveLspClient;

  @override
  List<Object?> get props => [reactiveWeb3Client, reactiveLspClient];
}
