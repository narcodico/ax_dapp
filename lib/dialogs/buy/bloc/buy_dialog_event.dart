part of 'buy_dialog_bloc.dart';

abstract class BuyDialogEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class WatchApTokensStarted extends BuyDialogEvent {
  WatchApTokensStarted(this.athleteId);

  final int athleteId;

  @override
  List<Object?> get props => [athleteId];
}

class TokenTypeSelectionChanged extends BuyDialogEvent {
  TokenTypeSelectionChanged(this.tokenType);

  final TokenType tokenType;

  @override
  List<Object?> get props => [tokenType];
}

class OnLoadDialog extends BuyDialogEvent {
  OnLoadDialog({required this.currentTokenAddress});

  final String currentTokenAddress;
}

class OnNewAxInput extends BuyDialogEvent {
  OnNewAxInput({required this.axInputAmount});

  final double axInputAmount;
}

class OnMaxBuyTap extends BuyDialogEvent {}

class OnConfirmBuy extends BuyDialogEvent {
  OnConfirmBuy({required this.buyPrice});
  final double buyPrice;

  @override
  List<Object?> get props => [buyPrice];
}
