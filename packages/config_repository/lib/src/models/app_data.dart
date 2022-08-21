import 'package:ethereum_api/tokens_api.dart';
import 'package:shared/shared.dart';

/// {@template app_data}
/// Holds app related data([EthereumChain], [Token]s).
/// {@endtemplate}
class AppData extends Equatable {
  /// {@macro app_data}
  const AppData({
    required this.chain,
    required this.tokens,
  });

  /// Current [EthereumChain].
  final EthereumChain chain;

  /// Current [Token]s.
  final List<Token> tokens;

  @override
  List<Object?> get props => [chain, tokens];
}
