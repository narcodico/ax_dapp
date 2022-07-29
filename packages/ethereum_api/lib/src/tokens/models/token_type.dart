part of 'token.dart';

/// Represents types of [Token].
enum TokenType {
  /// Type of [Token.longApt].
  long,

  /// Type of [Token.shortApt].
  short,
}

/// [TokenType] extensions.
extension TokenTypeX on TokenType {
  /// Returns `true` if the [TokenType] is long.
  bool get isLong => this == TokenType.long;

  /// Returns `true` if the [TokenType] is short.
  bool get isShort => this == TokenType.short;
}
