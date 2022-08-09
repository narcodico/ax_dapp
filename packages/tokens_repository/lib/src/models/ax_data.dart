import 'package:shared/shared.dart';

/// {@template ax_data}
/// Holds `AthleteX` market data.
/// {@endtemplate}
class AxData extends Equatable {
  /// {@macro ax_data}
  const AxData({
    this.price,
    this.totalSupply,
    this.circulatingSupply,
  });

  /// `AthleteX` price.
  final double? price;

  /// `AthleteX` total supply.
  final double? totalSupply;

  /// `AthleteX` circulating supply.
  final double? circulatingSupply;

  /// Default [AxData].
  static const empty = AxData();

  @override
  List<Object?> get props => [price, totalSupply, circulatingSupply];
}
