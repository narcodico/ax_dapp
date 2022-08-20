import 'package:ax_dapp/add_liquidity/models/models.dart';
import 'package:ax_dapp/repositories/subgraph/usecases/get_pool_info_use_case.dart';
import 'package:ax_dapp/service/controller/pool/pool_controller.dart';
import 'package:ax_dapp/util/bloc_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokens_repository/tokens_repository.dart';
import 'package:wallet_repository/wallet_repository.dart';

part 'add_liquidity_event.dart';
part 'add_liquidity_state.dart';

class AddLiquidityBloc extends Bloc<AddLiquidityEvent, AddLiquidityState> {
  AddLiquidityBloc({
    required WalletRepository walletRepository,
    required TokensRepository tokensRepository,
    required this.repo,
    required this.poolController,
  })  : _walletRepository = walletRepository,
        super(
          AddLiquidityState(
            token0: tokensRepository.currentTokens.first,
            token1: tokensRepository.currentTokens[1],
          ),
        ) {
    on<FetchPairInfoRequested>(_onFetchPairInfoRequested);
    on<Token0SelectionChanged>(_mapToken0SelectionChangedEventToState);
    on<Token1SelectionChanged>(_mapToken1SelectionChangedEventToState);
    on<Token0AmountChanged>(_onToken0AmountChanged);
    on<Token1AmountChanged>(_onToken1AmountChanged);
    on<ApproveLiquidityInitiated>(_onApproveLiquidityInitiated);
    on<SwapTokensRequested>(_onSwapTokensRequested);

    add(const FetchPairInfoRequested());
  }

  final WalletRepository _walletRepository;
  final GetPoolInfoUseCase repo;
  final PoolController poolController;

// todo -- tokenchanges should drive setting up token0 an 1 on state, to reset
//their position basically if they're swapped

  Future<void> _onFetchPairInfoRequested(
    FetchPairInfoRequested event,
    Emitter<AddLiquidityState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));
    poolController
      ..updateTknAddress1(state.token0.address)
      ..updateTknAddress2(state.token1.address);
    try {
      final balance0 =
          await _walletRepository.getTokenBalance(state.token0.address);
      final balance1 =
          await _walletRepository.getTokenBalance(state.token1.address);
      emit(
        state.copyWith(
          balance0: balance0 ?? 0,
          balance1: balance1 ?? 0,
        ),
      );
      final response = await repo.fetchPairInfo(
        tokenA: state.token0.address,
        tokenB: state.token1.address,
      );
      final isSuccess = response.isLeft();

      if (isSuccess) {
        final poolInfo = response.getLeft().toNullable()!.pairInfo;
        emit(
          state.copyWith(
            status: BlocStatus.success,
            poolPairInfo: poolInfo,
          ),
        );
      } else {
        // TODO(anyone): Create User facing error messages https://athletex.atlassian.net/browse/AX-466
        emit(
          state.copyWith(
            status: BlocStatus.noData,
            poolPairInfo: PoolPairInfo.empty,
          ),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: BlocStatus.error));
    }
  }

  Future<void> _mapToken0SelectionChangedEventToState(
    Token0SelectionChanged event,
    Emitter<AddLiquidityState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));
    final token0 = event.token0;
    emit(state.copyWith(token0: token0));
    final balance0 = await _walletRepository.getTokenBalance(token0.address);
    poolController.updateTknAddress1(token0.address);
    emit(state.copyWith(token0: token0, balance0: balance0 ?? 0));
    try {
      final response = await repo.fetchPairInfo(
        tokenA: state.token0.address,
        tokenB: state.token1.address,
      );
      final isSuccess = response.isLeft();

      if (isSuccess) {
        final poolInfo = response.getLeft().toNullable()!.pairInfo;
        emit(
          state.copyWith(
            status: BlocStatus.success,
            poolPairInfo: poolInfo,
          ),
        );
      } else {
        // TODO(anyone): Create User facing error messages https://athletex.atlassian.net/browse/AX-466
        emit(state.copyWith(status: BlocStatus.error));
      }
    } catch (_) {
      emit(state.copyWith(status: BlocStatus.error));
    }
  }

  Future<void> _mapToken1SelectionChangedEventToState(
    Token1SelectionChanged event,
    Emitter<AddLiquidityState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));
    final token1 = event.token1;
    emit(state.copyWith(token1: token1));
    final balance1 = await _walletRepository.getTokenBalance(token1.address);
    poolController.updateTknAddress2(token1.address);
    emit(state.copyWith(token1: token1, balance1: balance1 ?? 0));
    try {
      final response = await repo.fetchPairInfo(
        tokenA: state.token0.address,
        tokenB: state.token1.address,
      );
      final isSuccess = response.isLeft();

      if (isSuccess) {
        final poolInfo = response.getLeft().toNullable()!.pairInfo;
        emit(
          state.copyWith(
            status: BlocStatus.success,
            poolPairInfo: poolInfo,
          ),
        );
      } else {
        // TODO(aynone): Create User facing error messages https://athletex.atlassian.net/browse/AX-466
        emit(state.copyWith(status: BlocStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.error));
    }
  }

  Future<void> _onToken0AmountChanged(
    Token0AmountChanged event,
    Emitter<AddLiquidityState> emit,
  ) async {
    final token0Amount = double.parse(event.amount);
    if (poolController.amount1.value != token0Amount) {
      poolController.updateTopAmount(token0Amount);
    }
    try {
      final response = await repo.fetchPairInfo(
        tokenA: state.token0.address,
        tokenB: state.token1.address,
        tokenAInput: token0Amount,
        tokenBInput: state.token1AmountInput,
      );
      final isSuccess = response.isLeft();
      if (isSuccess) {
        final poolInfo = response.getLeft().toNullable()!.pairInfo;
        final token1Amount = token0Amount / poolInfo.ratio;
        emit(
          state.copyWith(
            status: BlocStatus.success,
            token0AmountInput: token0Amount,
            poolPairInfo: poolInfo,
          ),
        );
        add(Token1AmountChanged(token1Amount.toString()));
      } else {
        // TODO(anyone): Create User facing error messages https://athletex.atlassian.net/browse/AX-466
        emit(state.copyWith(status: BlocStatus.noData));
      }
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.error));
    }
  }

  Future<void> _onToken1AmountChanged(
    Token1AmountChanged event,
    Emitter<AddLiquidityState> emit,
  ) async {
    final token1Amount = double.parse(event.amount);
    if (poolController.amount2.value != token1Amount) {
      poolController.updateBottomAmount(token1Amount);
    }
    try {
      final response = await repo.fetchPairInfo(
        tokenA: state.token0.address,
        tokenB: state.token1.address,
        tokenAInput: state.token0AmountInput,
        tokenBInput: token1Amount,
      );
      final isSuccess = response.isLeft();

      if (isSuccess) {
        final poolInfo = response.getLeft().toNullable()!.pairInfo;
        emit(
          state.copyWith(
            status: BlocStatus.success,
            poolPairInfo: poolInfo,
            token1AmountInput: token1Amount,
          ),
        );
      } else {
        // TODO(anyone): Create User facing error messages https://athletex.atlassian.net/browse/AX-466
        emit(state.copyWith(status: BlocStatus.noData));
      }
    } catch (_) {
      emit(state.copyWith(status: BlocStatus.error));
    }
  }

  void _onApproveLiquidityInitiated(
    ApproveLiquidityInitiated event,
    Emitter<AddLiquidityState> emit,
  ) {}

  void _onSwapTokensRequested(
    SwapTokensRequested event,
    Emitter<AddLiquidityState> emit,
  ) {
    final token0 = state.token1;
    final token1 = state.token0;
    final token0AmountInput = state.token1AmountInput;
    final token1AmountInput = state.token0AmountInput;
    emit(
      state.copyWith(
        token0: token0,
        token1: token1,
        token0AmountInput: token0AmountInput,
        token1AmountInput: token1AmountInput,
      ),
    );
  }
}
