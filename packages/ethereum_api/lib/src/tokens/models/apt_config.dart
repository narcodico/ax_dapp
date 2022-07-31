part of 'token.dart';

/// {@template athlete_performance_token_config}
/// Configures an [Apt].
/// {@endtemplate}
class AptConfig extends Equatable {
  /// {@macro athlete_performance_token_config}
  const AptConfig({
    required this.athleteId,
    required this.athleteName,
    required this.longTicker,
    required this.shortTicker,
    required this.pairAddressConfig,
    required this.longAddressConfig,
    required this.shortAddressConfig,
    required this.sport,
  });

  /// {@template athlete_id}
  /// Represents athelete's ID.
  /// {@endtemplate}
  final int athleteId;

  /// {@template athlete_name}
  /// Represents athlete's name.
  /// {@endtemplate}
  final String athleteName;

  /// Represents [Apt.long]'s ticker.
  final String longTicker;

  /// Represents [Apt.short]'s ticker.
  final String shortTicker;

  /// Represents [Apt]'s pair address configuration.
  final TokenAddressConfig pairAddressConfig;

  /// Represents [Apt.long]'s address configuration.
  final TokenAddressConfig longAddressConfig;

  /// Represents [Apt.short]'s address configuration.
  final TokenAddressConfig shortAddressConfig;

  /// Represents athlete's [SupportedSport].
  final SupportedSport sport;

  @override
  List<Object?> get props => [
        athleteId,
        athleteName,
        longTicker,
        shortTicker,
        pairAddressConfig,
        longAddressConfig,
        shortAddressConfig,
        sport,
      ];

  /// Represents an empty [AptConfig]. Useful as default value.
  static const empty = AptConfig(
    athleteId: 0,
    athleteName: '',
    longTicker: '',
    shortTicker: '',
    pairAddressConfig: TokenAddressConfig.empty(),
    longAddressConfig: TokenAddressConfig.empty(),
    shortAddressConfig: TokenAddressConfig.empty(),
    sport: SupportedSport.all,
  );

  /// Static list of [AptConfig]s used to generate [Token.shortAp]s and
  /// [Token.longAp]s.
  static const List<AptConfig> values = _kAthletePerformanceTokenConfigs;
}

/// [AptConfig] extensions.
extension AthletePerformanceTokenConfigX on AptConfig {
  /// Returns [Apt]'s name based on [AptType], e.g.: `Aaron Judge Long APT`.
  String aptName(AptType tokenType) =>
      '$athleteName ${tokenType.name.capitalize()} APT';
}

const _kAthletePerformanceTokenConfigs = [
  AptConfig(
    athleteId: 10002087,
    athleteName: 'Aaron Judge',
    sport: SupportedSport.MLB,
    longTicker: 'AJLT1010',
    shortTicker: 'AJST1010',
    pairAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0x19d5b8f926596a31CA1c25cEf8C79A267EDC9864',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
    longAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0x481Bf3dbdE952CE684Dc500Fd9EdEF88f6607A8C',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
    shortAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0xA16dd54C674AE300d6DF436E536584eb3AB2F081',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
  ),
  AptConfig(
    athleteId: 10001365,
    athleteName: 'Bryce Harper',
    sport: SupportedSport.MLB,
    longTicker: 'BHLT1010',
    shortTicker: 'BHLT1010',
    pairAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0xD1f6F00a83b1938D697c730dDcad4410F00787De',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
    longAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0x9fd9b5164EAe6E78887beAE74Cbed54D853A6b33',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
    shortAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0xBc9095AFF510544846E34926757aCAFd471e0b33',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
  ),
  AptConfig(
    athleteId: 10001918,
    athleteName: 'Carlos Correa',
    sport: SupportedSport.MLB,
    longTicker: 'CCLT1010',
    shortTicker: 'CCST1010',
    pairAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0x53eCe60F883a8C7E16Bb3294808bA589Ab210a6E',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
    longAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0x056A9154d86a994A840935ba995F701370B070F3',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
    shortAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0x9229d63a787ab7005E43b716e39096be90F4A77E',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
  ),
  AptConfig(
    athleteId: 10007217,
    athleteName: 'Fernando Tatis Jr.',
    sport: SupportedSport.MLB,
    longTicker: 'FTJLT1010',
    shortTicker: 'FTJST1010',
    pairAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0x251C607fF5680d5c98761E34464E8Dfe849Ce842',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
    longAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0xFbD2CF33E9aE10bE77AF3A4c3Cac04B4314ceBAc',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
    shortAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0x5Ce78a5bA2956895583C4EDf40053E17b2b5744c',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
  ),
  AptConfig(
    athleteId: 10000352,
    athleteName: 'Jose Ramirez',
    sport: SupportedSport.MLB,
    longTicker: 'JRLT1010',
    shortTicker: 'JRST1010',
    pairAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0x34Ca688D00CaAF3a492f46Bc8676c3A48EaBff4e',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
    longAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0xC524e925bdad2419aD31d180300582F7025873dF',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
    shortAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0x037fC21641B60e747b46E72F55e1B1337aEB2776',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
  ),
  AptConfig(
    athleteId: 10006794,
    athleteName: 'Juan Soto',
    sport: SupportedSport.MLB,
    longTicker: 'JSLT1010',
    shortTicker: 'JSST1010',
    pairAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0x8ae25fB4fa812395B6d4dD4a4C7ac10D627Ac1fE',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
    longAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0x7057BE5B6E897E910D30178630529643469D9BfB',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
    shortAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0xcE44443d4F652fC6c48f62258c75278E11909d6a',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
  ),
  AptConfig(
    athleteId: 10000908,
    athleteName: 'Marcus Semien',
    sport: SupportedSport.MLB,
    longTicker: 'MSLT1010',
    shortTicker: 'MSST1010',
    pairAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0xc98E1EC69D9413c0D74FE6723Dc7D05e3F95dBd0',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
    longAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0xDf40952AAA578272061BD40bEcC125a5a510a62F',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
    shortAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0x0860e4C9728E6658F36B314Cdb996CdbD561f8E0',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
  ),
  AptConfig(
    athleteId: 10001009,
    athleteName: 'Starling Marte',
    sport: SupportedSport.MLB,
    longTicker: 'SMLT1010',
    shortTicker: 'SMST1010',
    pairAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0x01c86DeADD7f6993b92D746A53Bab5c8Dd2A97bA',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
    longAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0xa33acF2F8e7CF4e522d0958380d1BC00E42199DB',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
    shortAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0xAD9f9A1EBF43725aBEAcb8B9777CBebE42a5693d',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
  ),
  AptConfig(
    athleteId: 10002094,
    athleteName: 'Trea Turner',
    sport: SupportedSport.MLB,
    longTicker: 'TTLT1010',
    shortTicker: 'TTST1010',
    pairAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0x5bB30505Fa69487eC79501a58bb73dEA4D402b80',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
    longAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0x8c5297bC8dFc42Fe4dC5Dd84f3fa8E1dE74D6f66',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
    shortAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0x09602a00D9E7a6C93544d74B006739B6D0CF4c1D',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
  ),
  AptConfig(
    athleteId: 10007501,
    athleteName: 'Vladimir Guerrero Jr.',
    sport: SupportedSport.MLB,
    longTicker: 'VGJLT1010',
    shortTicker: 'VGJST1010',
    pairAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0xbe065AD544D911b101c7393f4e99b43418535daD',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
    longAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0xE91c7952Be8AcbfE6088aAfC50516496273A8aDA',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
    shortAddressConfig: TokenAddressConfig.apt(
      polygonMainnet: '0x37d388321c2cE1E130e36443e8dAE91836a786C0',
      polygonTestnet: 'TODO',
      sxMainnet: 'TODO',
      sxTestnet: 'TODO',
    ),
  ),
];