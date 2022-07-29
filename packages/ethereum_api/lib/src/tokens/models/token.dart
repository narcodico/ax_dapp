import 'package:ethereum_api/src/ethereum/models/models.dart';
import 'package:ethereum_api/src/wallet/models/models.dart';
import 'package:shared/shared.dart';

part 'athlete_performance_token.dart';
part 'athlete_performance_token_config.dart';
part 'token_address_config.dart';
part 'token_type.dart';

/// {@template token}
/// Represents an `Ethereum` token.
/// {@endtemplate}
class Token extends Equatable {
  /// {@macro token}
  const Token({
    required this.name,
    required this.ticker,
    this.sport = SupportedSport.all,
    required TokenAddressConfig addressConfig,
    required this.chain,
  }) : _addressConfig = addressConfig;

  /// Represents an `AthleteX` [Token].
  const Token.axt(EthereumChain chain)
      : this(
          name: 'AthleteX',
          ticker: 'AX',
          addressConfig: const TokenAddressConfig.axt(),
          chain: chain,
        );

  /// Represents a `SportX` [Token].
  const Token.sxt(EthereumChain chain)
      : this(
          name: 'SportX',
          ticker: 'SX',
          addressConfig: const TokenAddressConfig.sxt(),
          chain: chain,
        );

  /// Represents a `Matic` [Token].
  const Token.matic(EthereumChain chain)
      : this(
          name: 'Matic/Polygon',
          ticker: 'Matic',
          addressConfig: const TokenAddressConfig.matic(),
          chain: chain,
        );

  /// Represents a `Wrapped Ether` [Token].
  const Token.weth(EthereumChain chain)
      : this(
          name: 'WETH',
          ticker: 'WETH',
          addressConfig: const TokenAddressConfig.weth(),
          chain: chain,
        );

  /// Represents an `USD Coin` [Token].
  const Token.usdc(EthereumChain chain)
      : this(
          name: 'USDC',
          ticker: 'USDC',
          addressConfig: const TokenAddressConfig.usdc(),
          chain: chain,
        );

  /// {@macro athlete_performance_token}
  ///
  /// {@macro long_athlete_performance_token}
  factory Token.longApt(
    EthereumChain chain, {
    required AthletePerformanceTokenConfig aptConfig,
  }) = AthletePerformanceToken.long;

  /// {@macro athlete_performance_token}
  ///
  /// {@macro short_athlete_performance_token}
  factory Token.shortApt(
    EthereumChain chain, {
    required AthletePerformanceTokenConfig aptConfig,
  }) = AthletePerformanceToken.short;

  /// Represents [Token]'s name.
  final String name;

  /// Represents a [Token]'s ticker, e.g.: `AX` for `AthleteX` [Token].
  final String ticker;

  /// The [SupportedSport] for this [Token].
  final SupportedSport sport;

  /// {@macro token_address_config}
  final TokenAddressConfig _addressConfig;

  /// Represents current [EthereumChain].
  final EthereumChain chain;

  /// Represents an empty [Token].
  static const empty = Token(
    name: '__empty__',
    ticker: '',
    addressConfig: TokenAddressConfig.empty(),
    chain: EthereumChain.none,
  );

  @override
  List<Object?> get props => [
        name,
        ticker,
        sport,
        _addressConfig,
        chain,
      ];

  /// Static list of [AthletePerformanceToken]'s. Composed based on a list of
  /// [AthletePerformanceTokenConfig]s.
  static List<Token> apts(EthereumChain chain) =>
      AthletePerformanceTokenConfig.values
          .expand(
            (aptConfig) => [
              Token.longApt(chain, aptConfig: aptConfig),
              Token.shortApt(chain, aptConfig: aptConfig),
            ],
          )
          .toList();
}

/// [Token] extensions.
extension TokenX on Token {
  /// Returns the correspondent [Token]'s address based on the current
  /// [EthereumChain]. For [EthereumChain.none] and [EthereumChain.unsupported]
  /// it will return [kEmptyTokenAddress].
  String get address => _addressConfig.address(chain);
}
