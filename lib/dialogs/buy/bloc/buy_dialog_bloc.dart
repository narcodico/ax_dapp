import 'dart:async';

import 'package:ax_dapp/repositories/subgraph/usecases/get_buy_info_use_case.dart';
import 'package:ax_dapp/service/blockchain_models/apt_buy_info.dart';
import 'package:ax_dapp/service/controller/swap/axt.dart';
import 'package:ax_dapp/service/controller/swap/swap_controller.dart';
import 'package:ax_dapp/service/controller/usecases/get_max_token_input_use_case.dart';
import 'package:ax_dapp/util/bloc_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokens_repository/tokens_repository.dart';

part 'buy_dialog_event.dart';
part 'buy_dialog_state.dart';

class BuyDialogBloc extends Bloc<BuyDialogEvent, BuyDialogState> {
  BuyDialogBloc({
    required TokensRepository tokensRepository,
    required this.repo,
    required this.wallet,
    required this.swapController,
  })  : _tokensRepository = tokensRepository,
        super(const BuyDialogState()) {
    on<WatchAptsStarted>(_onWatchAptsStarted);
    on<TokenTypeSelectionChanged>(_onTokenTypeSelectionChanged);
    on<OnLoadDialog>(_mapLoadDialogEventToState);
    on<OnMaxBuyTap>(_mapMaxBuyTapEventToState);
    on<OnConfirmBuy>(_mapConfirmBuyEventToState);
    on<OnNewAxInput>(_mapNewAxInputEventToState);
  }

  final TokensRepository _tokensRepository;
  final GetBuyInfoUseCase repo;
  final GetTotalTokenBalanceUseCase wallet;
  final SwapController swapController;

  FutureOr<void> _onWatchAptsStarted(
    WatchAptsStarted event,
    Emitter<BuyDialogState> emit,
  ) async {
    await emit.forEach<List<AthletePerformanceToken>>(
      _tokensRepository.apTokensChanges(event.athleteId),
      onData: (tokens) => state.copyWith(
        longApt: tokens.first,
        shortApt: tokens.last,
      ),
    );
  }

  void _onTokenTypeSelectionChanged(
    TokenTypeSelectionChanged event,
    Emitter<BuyDialogState> emit,
  ) {
    emit(state.copyWith(tokenTypeSelection: event.tokenType));
  }

  Future<void> _mapLoadDialogEventToState(
    OnLoadDialog event,
    Emitter<BuyDialogState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final response =
          await repo.fetchAptBuyInfo(aptAddress: event.currentTokenAddress);
      final isSuccess = response.isLeft();

      if (isSuccess) {
        swapController
          ..updateFromAddress(AXT.polygonAddress)
          ..updateToAddress(event.currentTokenAddress);
        final pairInfo = response.getLeft().toNullable()!.aptBuyInfo;
        final balance = await wallet.getTotalAxBalance();

        emit(
          state.copyWith(
            balance: balance,
            status: BlocStatus.success,
            tokenAddress: event.currentTokenAddress,
            aptBuyInfo: AptBuyInfo(
              axPerAptPrice: pairInfo.fromPrice,
              minimumReceived: pairInfo.minimumReceived,
              priceImpact: pairInfo.priceImpact,
              receiveAmount: pairInfo.receiveAmount,
              totalFee: pairInfo.totalFee,
            ),
          ),
        );
      } else {
        // TODO(anyone): Create User facing error messages https://athletex.atlassian.net/browse/AX-466
        emit(
          state.copyWith(
            status: BlocStatus.error,
            aptBuyInfo: AptBuyInfo.empty,
          ),
        );
      }
    } catch (_) {
      emit(
        state.copyWith(
          status: BlocStatus.error,
          aptBuyInfo: AptBuyInfo.empty,
        ),
      );
    }
  }

  Future<void> _mapMaxBuyTapEventToState(
    OnMaxBuyTap event,
    Emitter<BuyDialogState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final maxInput = await wallet.getTotalAxBalance();
      emit(state.copyWith(axInputAmount: maxInput, status: BlocStatus.success));
      add(OnNewAxInput(axInputAmount: maxInput));
    } catch (e) {
      // TODO(anyone): Create User facing error messages https://athletex.atlassian.net/browse/AX-466
      emit(state.copyWith(status: BlocStatus.error));
    }
  }

  void _mapConfirmBuyEventToState(
    OnConfirmBuy event,
    Emitter<BuyDialogState> emit,
  ) {}

  Future<void> _mapNewAxInputEventToState(
    OnNewAxInput event,
    Emitter<BuyDialogState> emit,
  ) async {
    final axInputAmount = event.axInputAmount;
    final balance = await wallet.getTotalAxBalance();
    try {
      final response = await repo.fetchAptBuyInfo(
        aptAddress: state.tokenAddress,
        axInput: axInputAmount,
      );
      final isSuccess = response.isLeft();

      if (isSuccess) {
        if (swapController.amount1.value != axInputAmount) {
          swapController.updateFromAmount(axInputAmount);
        }
        final pairInfo = response.getLeft().toNullable()!.aptBuyInfo;
        emit(
          state.copyWith(
            status: BlocStatus.success,
            balance: balance,
            aptBuyInfo: AptBuyInfo(
              axPerAptPrice: pairInfo.fromPrice,
              minimumReceived: pairInfo.minimumReceived,
              priceImpact: pairInfo.priceImpact,
              receiveAmount: pairInfo.receiveAmount,
              totalFee: pairInfo.totalFee,
            ),
          ),
        );
      } else {
        // TODO(anyone): Create User facing error messages https://athletex.atlassian.net/browse/AX-466
        emit(
          state.copyWith(
            status: BlocStatus.error,
            aptBuyInfo: AptBuyInfo.empty,
          ),
        );
      }
    } catch (_) {
      emit(
        state.copyWith(
          status: BlocStatus.error,
          aptBuyInfo: AptBuyInfo.empty,
        ),
      );
    }
  }
}
