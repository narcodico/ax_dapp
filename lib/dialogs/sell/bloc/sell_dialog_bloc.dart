import 'dart:async';

import 'package:ax_dapp/repositories/subgraph/usecases/get_sell_info_use_case.dart';
import 'package:ax_dapp/service/blockchain_models/apt_sell_info.dart';
import 'package:ax_dapp/service/controller/swap/swap_controller.dart';
import 'package:ax_dapp/service/controller/usecases/get_max_token_input_use_case.dart';
import 'package:ax_dapp/util/bloc_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokens_repository/tokens_repository.dart';

part 'sell_dialog_event.dart';
part 'sell_dialog_state.dart';

class SellDialogBloc extends Bloc<SellDialogEvent, SellDialogState> {
  SellDialogBloc({
    required TokensRepository tokensRepository,
    required this.repo,
    required this.wallet,
    required this.swapController,
    required int athleteId,
  })  : _tokensRepository = tokensRepository,
        super(
          // setting the apt corresponding to the default aptType which is long
          SellDialogState(
            longApt: tokensRepository.aptPair(athleteId).longApt,
          ),
        ) {
    on<WatchAptPairStarted>(_onWatchAptPairStarted);
    on<TokenTypeSelectionChanged>(_onTokenTypeSelectionChanged);
    on<FetchAptSellInfoRequested>(_onFetchAptSellInfoRequested);
    on<MaxSellTap>(_mapMaxSellTapEventToState);
    on<ConfirmSell>(_mapConfirmSellEventToState);
    on<NewAptInput>(_mapNewAptInputEventToState);

    add(WatchAptPairStarted(athleteId));
    add(const FetchAptSellInfoRequested());
  }

  final TokensRepository _tokensRepository;
  final GetSellInfoUseCase repo;
  final GetTotalTokenBalanceUseCase wallet;
  final SwapController swapController;

  Future<void> _onWatchAptPairStarted(
    WatchAptPairStarted event,
    Emitter<SellDialogState> emit,
  ) async {
    await emit.onEach<AptPair>(
      _tokensRepository.aptPairChanges(event.athleteId),
      onData: (aptPair) {
        emit(
          state.copyWith(longApt: aptPair.longApt, shortApt: aptPair.shortApt),
        );
        add(const FetchAptSellInfoRequested());
      },
    );
  }

  void _onTokenTypeSelectionChanged(
    TokenTypeSelectionChanged event,
    Emitter<SellDialogState> emit,
  ) {
    emit(state.copyWith(aptTypeSelection: event.aptType));
    add(const FetchAptSellInfoRequested());
  }

  Future<void> _onFetchAptSellInfoRequested(
    FetchAptSellInfoRequested event,
    Emitter<SellDialogState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final selectedTokenAddress = state.selectedTokenAddress;
      final response =
          await repo.fetchAptSellInfo(aptAddress: selectedTokenAddress);
      final isSuccess = response.isLeft();

      if (isSuccess) {
        swapController
          ..updateFromAddress(selectedTokenAddress)
          ..updateToAddress(_tokensRepository.tokens.axt.address);
        final swapInfo = response.getLeft().toNullable()!.sellInfo;
        final balance =
            await wallet.getTotalBalanceForToken(selectedTokenAddress);
        //do some math
        emit(
          state.copyWith(
            balance: balance,
            status: BlocStatus.success,
            aptSellInfo: AptSellInfo(
              axPrice: swapInfo.toPrice,
              minimumReceived: swapInfo.minimumReceived,
              priceImpact: swapInfo.priceImpact,
              receiveAmount: swapInfo.receiveAmount,
              totalFee: swapInfo.totalFee,
            ),
          ),
        );
      } else {
        // TODO(anyone): Create User facing error messages https://athletex.atlassian.net/browse/AX-466
        emit(
          state.copyWith(
            status: BlocStatus.error,
            aptSellInfo: AptSellInfo.empty,
          ),
        );
      }
    } catch (_) {
      emit(
        state.copyWith(
          status: BlocStatus.error,
          aptSellInfo: AptSellInfo.empty,
        ),
      );
    }
  }

  Future<void> _mapMaxSellTapEventToState(
    MaxSellTap event,
    Emitter<SellDialogState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final maxInput =
          await wallet.getTotalBalanceForToken(state.selectedTokenAddress);
      emit(
        state.copyWith(aptInputAmount: maxInput, status: BlocStatus.success),
      );
      add(NewAptInput(aptInputAmount: maxInput));
    } catch (_) {
      // TODO(anyone): Create User facing error messages https://athletex.atlassian.net/browse/AX-466
      emit(state.copyWith(status: BlocStatus.error));
    }
  }

  void _mapConfirmSellEventToState(
    ConfirmSell event,
    Emitter<SellDialogState> emit,
  ) {}

  Future<void> _mapNewAptInputEventToState(
    NewAptInput event,
    Emitter<SellDialogState> emit,
  ) async {
    final aptInputAmount = event.aptInputAmount;
    try {
      final selectedTokenAddress = state.selectedTokenAddress;
      final balance =
          await wallet.getTotalBalanceForToken(selectedTokenAddress);
      final response = await repo.fetchAptSellInfo(
        aptAddress: selectedTokenAddress,
        aptInput: aptInputAmount,
      );
      final isSuccess = response.isLeft();

      if (isSuccess) {
        if (swapController.amount1.value != aptInputAmount) {
          swapController.updateFromAmount(aptInputAmount);
        }
        final swapInfo = response.getLeft().toNullable()!.sellInfo;
        //do some math
        emit(
          state.copyWith(
            balance: balance,
            status: BlocStatus.success,
            aptSellInfo: AptSellInfo(
              axPrice: swapInfo.toPrice,
              minimumReceived: swapInfo.minimumReceived,
              priceImpact: swapInfo.priceImpact,
              receiveAmount: swapInfo.receiveAmount,
              totalFee: swapInfo.totalFee,
            ),
          ),
        );
      } else {
        // TODO(anyone): Create User facing error messages https://athletex.atlassian.net/browse/AX-466
        emit(
          state.copyWith(
            status: BlocStatus.error,
            aptSellInfo: AptSellInfo.empty,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: BlocStatus.error,
          aptSellInfo: AptSellInfo.empty,
        ),
      );
    }
  }
}
