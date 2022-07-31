import 'package:ethereum_api/src/tokens/tokens.dart';
import 'package:ethereum_api/src/wallet/models/models.dart';
import 'package:shared/shared.dart';

/// {@template ethereum_api_client}
/// API client which handles interaction with the `Ethereum` blockchain.
/// {@endtemplate}
class EthereumApiClient {
  /// {@macro ethereum_api_client}
  EthereumApiClient();

  final _tokensController = BehaviorSubject<List<Token>>();

  /// Allows listening to changes to the current [Token]s.
  Stream<List<Token>> get tokensChanges => _tokensController.stream;

  /// Returns the current [Token]s synchronously. The returned [Token]s are
  /// based on the current [EthereumChain].
  List<Token> get tokens => _tokensController.valueOrNull ?? const [];

  /// Allows listening to changes to the [Apt]s (long and short) for the
  /// athlete identified by [athleteId].
  Stream<AptPair> aptPairChanges(int athleteId) =>
      _tokensController.stream.map((tokens) => tokens.whereType<Apt>()).map(
            (tokens) => AptPair(
              longApt: tokens.singleWhere(
                (token) => token.athleteId == athleteId && token.type.isLong,
              ),
              shortApt: tokens.singleWhere(
                (token) => token.athleteId == athleteId && token.type.isShort,
              ),
            ),
          );

  /// Returns the current [AptPair] for the given [athleteId] synchronously.
  AptPair aptPair(int athleteId) {
    final apts = tokens.whereType<Apt>();
    return AptPair(
      longApt: apts.singleWhere(
        (token) => token.athleteId == athleteId && token.type.isLong,
      ),
      shortApt: apts.singleWhere(
        (token) => token.athleteId == athleteId && token.type.isShort,
      ),
    );
  }

  /// Allows switching the current [Token]s, which are set based on the current
  /// [EthereumChain].
  ///
  /// The [Token]s are updated only if the current [EthereumChain] is
  /// supported. Otherwise, we keep the existing data.
  void switchTokens(EthereumChain chain) {
    if (chain.isSupported) {
      _tokensController.add([
        Token.ax(chain),
        Token.sx(chain),
        Token.matic(chain),
        Token.weth(chain),
        Token.usdc(chain),
        ...Token.apts(chain),
      ]);
    }
  }
}
