import 'package:ax_dapp/service/dialog.dart';
import 'package:ax_dapp/util/supported_sports.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class BadgeToken extends StatelessWidget {
  const BadgeToken({
    super.key,
    required this.sport,
    required this.symbol,
  });

  final SupportedSport sport;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Badge(
      shape: BadgeShape.square,
      borderRadius: BorderRadius.circular(8),
      badgeContent: Text(
        sport.name.toUpperCase(),
        style: textStyle(Colors.white, 12, true),
      ),
      position: BadgePosition.topEnd(top: -10, end: -12),
      padding: const EdgeInsets.only(top: 2, bottom: 2, left: 5, right: 5),
      child: Text(
        symbol,
        style: textStyle(Colors.white, 24, true),
      ),
    );
  }
}

class SimpleToken extends StatelessWidget {
  const SimpleToken({super.key, required this.symbol});

  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        symbol,
        style: textStyle(Colors.white, 24, true),
      ),
    );
  }
}

class SportToken extends StatelessWidget {
  const SportToken({
    super.key,
    required this.sport,
    required this.symbol,
  });

  final SupportedSport sport;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    if (sport == SupportedSport.all) return SimpleToken(symbol: symbol);
    return BadgeToken(sport: sport, symbol: symbol);
  }
}
