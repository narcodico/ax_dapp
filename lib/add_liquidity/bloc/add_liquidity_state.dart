part of 'add_liquidity_bloc.dart';

class AddLiquidityState extends Equatable {
  const AddLiquidityState({
    this.shareOfPool = '0.0',
    this.apy = '0.0',
    this.balance0 = 0.0,
    this.balance1 = 0.0,
    this.token0AmountInput = 0,
    this.token1AmountInput = 0,
    required this.token0,
    required this.token1,
    this.status = BlocStatus.initial,
    this.poolPairInfo = PoolPairInfo.empty,
  });

  final String shareOfPool;
  final String apy;
  final double balance0;
  final double balance1;
  final double token0AmountInput;
  final double token1AmountInput;
  final Token token0;
  final Token token1;
  final BlocStatus status;
  final PoolPairInfo poolPairInfo;

  @override
  List<Object?> get props => [
        shareOfPool,
        apy,
        balance0,
        balance1,
        token0AmountInput,
        token1AmountInput,
        token0,
        token1,
        status,
        poolPairInfo,
      ];

  AddLiquidityState copyWith({
    String? shareOfPool,
    String? apy,
    double? balance0,
    double? balance1,
    double? token0AmountInput,
    double? token1AmountInput,
    Token? token0,
    Token? token1,
    BlocStatus? status,
    PoolPairInfo? poolPairInfo,
  }) {
    return AddLiquidityState(
      shareOfPool: shareOfPool ?? this.shareOfPool,
      apy: apy ?? this.apy,
      balance0: balance0 ?? this.balance0,
      balance1: balance1 ?? this.balance1,
      token0AmountInput: token0AmountInput ?? this.token0AmountInput,
      token1AmountInput: token1AmountInput ?? this.token1AmountInput,
      token0: token0 ?? this.token0,
      token1: token1 ?? this.token1,
      status: status ?? this.status,
      poolPairInfo: poolPairInfo ?? this.poolPairInfo,
    );
  }
}
