class TransactionInfo {
  final BigInt? minimumReceived;
  final BigInt? estimatedSlippage;
  final BigInt? receiveAmount;

  TransactionInfo(this.minimumReceived, this.estimatedSlippage, this.receiveAmount);
}