part of 'token.dart';

/// {@template athlete_performance_token_pair}
/// Represents a pair of [Apt]s.
/// {@endtemplate}
class AptPair extends Equatable {
  /// {@macro athlete_performance_token_pair}
  const AptPair({
    required this.longApt,
    required this.shortApt,
  });

  /// Represents [Apt.long].
  final Apt longApt;

  /// Represents [Apt.short].
  final Apt shortApt;

  @override
  List<Object?> get props => [longApt, shortApt];
}
