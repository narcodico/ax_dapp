part of 'token.dart';

/// {@template athlete_performance_token}
/// Represents an `Athlete Performance` [Token], aka `APT`.
/// {@endtemplate}
class AthletePerformanceToken extends Token {
  /// {@template long_athlete_performance_token}
  /// Creates a long [AthletePerformanceToken].
  /// {@endtemplate}
  AthletePerformanceToken.long(
    EthereumChain chain, {
    required AthletePerformanceTokenConfig aptConfig,
  })  : _aptConfig = aptConfig,
        super(
          name: aptConfig.aptName(TokenType.long),
          ticker: aptConfig.longTicker,
          sport: aptConfig.sport,
          addressConfig: aptConfig.longAddressConfig,
          chain: chain,
        );

  /// {@template short_athlete_performance_token}
  /// Creates a short [AthletePerformanceToken].
  /// {@endtemplate}
  AthletePerformanceToken.short(
    EthereumChain chain, {
    required AthletePerformanceTokenConfig aptConfig,
  })  : _aptConfig = aptConfig,
        super(
          name: aptConfig.aptName(TokenType.short),
          ticker: aptConfig.shortTicker,
          sport: aptConfig.sport,
          addressConfig: aptConfig.shortAddressConfig,
          chain: chain,
        );

  final AthletePerformanceTokenConfig _aptConfig;

  @override
  List<Object?> get props => super.props..add(_aptConfig);
}

/// [AthletePerformanceToken] extensions.
extension AthletePerformanceTokenX on AthletePerformanceToken {
  /// {@macro athlete_id}
  int get athleteId => _aptConfig.athleteId;

  /// {@macro athlete_name}
  String get athleteName => _aptConfig.athleteName;

  /// Returns [AthletePerformanceToken]'s pair address.
  String get pairAddress => _aptConfig.pairAddressConfig.address(chain);
}
