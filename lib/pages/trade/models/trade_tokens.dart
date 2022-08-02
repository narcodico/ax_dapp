import 'package:equatable/equatable.dart';
import 'package:tokens_repository/tokens_repository.dart';

class TradeTokens extends Equatable {
  const TradeTokens({
    required this.tokenFrom,
    required this.tokenTo,
  });

  final Token tokenFrom;
  final Token tokenTo;

  static const empty =
      TradeTokens(tokenFrom: Token.empty, tokenTo: Token.empty);

  @override
  List<Object?> get props => [tokenFrom, tokenTo];
}

extension EthereumChainX on EthereumChain {
  TradeTokens tradeTokens({
    required bool isBuyAX,
    required List<Token> tokens,
  }) {
    var tokenFrom = tokens.axt;
    var tokenTo = tokens.weth;
    if (isBuyAX) {
      switch (this) {
        case EthereumChain.none:
        case EthereumChain.unsupported:
          return TradeTokens.empty;
        case EthereumChain.polygonMainnet:
        case EthereumChain.polygonTestnet:
          tokenFrom = tokens.matic;
          tokenTo = tokens.axt;
          break;
        case EthereumChain.sxMainnet:
        case EthereumChain.sxTestnet:
          tokenFrom = tokens.sxt;
          tokenTo = tokens.axt;
          break;
      }
    }
    return TradeTokens(tokenFrom: tokenFrom, tokenTo: tokenTo);
  }
}
