import 'package:ethereum_api/ethereum_api.dart';

/// {@template tokens_repository}
/// Repository that manages the token domain.
/// {@endtemplate}
class TokensRepository {
  /// {@macro tokens_repository}
  TokensRepository({
    required EthereumApiClient ethereumApiClient,
  }) : _ethereumApiClient = ethereumApiClient;

  final EthereumApiClient _ethereumApiClient;

  /// Allows listening to changes to the current [Token]s.
  Stream<List<Token>> get tokensChanges => _ethereumApiClient.tokensChanges;

  /// Returns the current [Token]s synchronously. The returned [Token]s are
  /// based on the current [EthereumChain].
  List<Token> get tokens => _ethereumApiClient.tokens;

  /// Allows listening to changes to the current [Apt]s.
  Stream<List<Apt>> get aptsChanges => _ethereumApiClient.aptsChanges;

  /// Returns the current [Apt]s synchronously. The returned [Apt]s are
  /// based on the current [EthereumChain].
  List<Apt> get apts => _ethereumApiClient.apts;

  /// Allows listening to changes to the [Apt]s (long and short) for the
  /// athlete identified by [athleteId].
  Stream<AptPair> aptPairChanges(int athleteId) =>
      _ethereumApiClient.aptPairChanges(athleteId);

  /// Returns the current [AptPair] for the given [athleteId] synchronously.
  /// The returned [AptPair] is based on the current [EthereumChain].
  AptPair aptPair(int athleteId) => _ethereumApiClient.aptPair(athleteId);

  /// Allows switching the current [Token]s, which are set based on the current
  /// [EthereumChain].
  void switchTokens(EthereumChain chain) =>
      _ethereumApiClient.switchTokens(chain);
}
