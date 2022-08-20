part of 'add_liquidity_bloc.dart';

abstract class AddLiquidityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PageRefreshEvent extends AddLiquidityEvent {}

class Token0SelectionChanged extends AddLiquidityEvent {
  Token0SelectionChanged({required this.token0});

  final Token token0;

  @override
  List<Object?> get props => [token0];
}

class Token1SelectionChanged extends AddLiquidityEvent {
  Token1SelectionChanged({required this.token1});

  final Token token1;

  @override
  List<Object?> get props => [token1];
}

class MaxToken0InputButtonClicked extends AddLiquidityEvent {}

class MaxToken1InputButtonClicked extends AddLiquidityEvent {}

class Token0InputChanged extends AddLiquidityEvent {
  Token0InputChanged(this.token0Input);

  final String token0Input;

  @override
  List<Object?> get props => [token0Input];
}

class Token1InputChanged extends AddLiquidityEvent {
  Token1InputChanged(this.token1Input);

  final String token1Input;

  @override
  List<Object?> get props => [token1Input];
}

class AddLiquidityButtonClicked extends AddLiquidityEvent {}

class SwapTokens extends AddLiquidityEvent {}
