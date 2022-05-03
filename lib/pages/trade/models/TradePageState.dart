import 'package:ax_dapp/service/Controller/Token.dart';
import 'package:ax_dapp/service/TokenList.dart';
import 'package:equatable/equatable.dart';

enum Status { initial, success, error, loading }

class TradePageState extends Equatable {
  final double price;
  final double balance;
  final double priceImpact;
  final double tokenInputFromAmount;
  final double tokenInputToAmount;
  final double minimumReceived;
  final double estimatedSlippage;
  final double receiveAmount;
  final double lpFee;
  final Status status;
  final Token? tokenFrom;
  final Token? tokenTo;

  const TradePageState({
    this.status = Status.initial,
    double? tokenInputFromAmount,
    double? tokenInputToAmount,
    double? price,
    double? balance,
    double? priceImpact,
    double? minimumReceived,
    double? estimatedSlippage,
    double? receiveAmount,
    double? lpFee,
    Token? tokenFrom,
    Token? tokenTo,
  })  : tokenInputFromAmount = tokenInputFromAmount ?? 0.0,
        tokenInputToAmount = tokenInputToAmount ?? 0.0,
        price = price ?? 0.0,
        balance = balance ?? 0.0,
        priceImpact = priceImpact ?? 0.0,
        minimumReceived = minimumReceived ?? 0.0,
        lpFee = lpFee ?? 0.003,
        estimatedSlippage = estimatedSlippage ?? 0.0,
        receiveAmount = receiveAmount ?? 0.0,
        tokenFrom = tokenFrom ?? tokenFrom,
        tokenTo = tokenTo ?? tokenTo;

  @override
  List<Object?> get props {
    return [
      price,
      balance,
      priceImpact,
      tokenInputFromAmount,
      tokenInputToAmount,
      minimumReceived,
      estimatedSlippage,
      receiveAmount,
      lpFee,
      status,
      tokenFrom,
      tokenTo,
    ];
  }

  TradePageState copyWith({
    double? price,
    double? balance,
    double? priceImpact,
    double? tokenInputFromAmount,
    double? tokenInputToAmount,
    double? minimumReceived,
    double? estimatedSlippage,
    double? receiveAmount,
    double? lpFee,
    Status? status,
    Token? tokenFrom,
    Token? tokenTo,
  }) {
    return TradePageState(
      price: price ?? this.price,
      balance: balance ?? this.balance,
      priceImpact: priceImpact ?? this.priceImpact,
      tokenInputFromAmount: tokenInputFromAmount ?? this.tokenInputFromAmount,
      tokenInputToAmount: tokenInputToAmount ?? this.tokenInputToAmount,
      minimumReceived: minimumReceived ?? this.minimumReceived,
      estimatedSlippage: estimatedSlippage ?? this.estimatedSlippage,
      receiveAmount: receiveAmount ?? this.receiveAmount,
      lpFee: lpFee ?? this.lpFee,
      status: status ?? this.status,
      tokenFrom: tokenFrom ?? this.tokenFrom,
      tokenTo: tokenTo ?? this.tokenTo,
    );
  }
}
