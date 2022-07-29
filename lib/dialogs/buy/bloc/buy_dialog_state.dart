part of 'buy_dialog_bloc.dart';

class BuyDialogState extends Equatable {
  const BuyDialogState({
    this.status = BlocStatus.initial,
    this.tokenTypeSelection = TokenType.long,
    this.longApt = const AthletePerformanceToken.empty(),
    this.shortApt = const AthletePerformanceToken.empty(),
    this.balance = 0,
    this.axInputAmount = 0,
    this.tokenAddress = '',
    this.aptBuyInfo = AptBuyInfo.empty,
  });

  final TokenType tokenTypeSelection;
  final AthletePerformanceToken longApt;
  final AthletePerformanceToken shortApt;
  final double balance;
  final double axInputAmount;
  final BlocStatus status;
  final String tokenAddress;
  final AptBuyInfo aptBuyInfo;

  @override
  List<Object> get props {
    return [
      tokenTypeSelection,
      longApt,
      shortApt,
      balance,
      axInputAmount,
      status,
      tokenAddress,
      aptBuyInfo,
    ];
  }

  BuyDialogState copyWith({
    TokenType? tokenTypeSelection,
    AthletePerformanceToken? longApt,
    AthletePerformanceToken? shortApt,
    double? balance,
    double? axInputAmount,
    BlocStatus? status,
    String? tokenAddress,
    AptBuyInfo? aptBuyInfo,
  }) {
    return BuyDialogState(
      tokenTypeSelection: tokenTypeSelection ?? this.tokenTypeSelection,
      longApt: longApt ?? this.longApt,
      shortApt: shortApt ?? this.shortApt,
      balance: balance ?? this.balance,
      axInputAmount: axInputAmount ?? this.axInputAmount,
      status: status ?? this.status,
      tokenAddress: tokenAddress ?? this.tokenAddress,
      aptBuyInfo: aptBuyInfo ?? this.aptBuyInfo,
    );
  }
}
