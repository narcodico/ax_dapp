import 'package:ax_dapp/dialogs/buy/models/BuyDialogEvent.dart';
import 'package:ax_dapp/dialogs/buy/models/BuyDialogState.dart';
import 'package:ax_dapp/dialogs/buy/models/TransactionInfo.dart';
import 'package:ax_dapp/dialogs/buy/usecases/GetAPTBuyInfoUseCase.dart';
import 'package:ax_dapp/service/BlockchainModels/AptBuyInfo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyDialogBloc extends Bloc<BuyDialogEvent, BuyDialogState> {
  GetAPTBuyInfoUseCase repo;

  BuyDialogBloc({required this.repo}) : super(const BuyDialogState()) {
    on<OnLoadDialog>(_mapLoadDialogEventToState);
    on<OnMaxBuyTap>(_mapMaxBuyTapEventToState);
    on<OnConfirmBuy>(_mapConfirmBuyEventToState);
  }

  get initialState => BuyDialogState();

  void _mapLoadDialogEventToState(
      OnLoadDialog event, Emitter<BuyDialogState> emit) async {
    emit(state.copy(status: Status.loading));
    try {
      final buyInfo = await repo.fetchAptBuyInfo(event.initialTokenAddress);
      final transactionInfo = calculateBuyPricingInfo(buyInfo);

      //do some math
      emit(state.copy(
          status: Status.success,
          minimumReceived: transactionInfo.minimumReceived!.toDouble(),
          estimatedSlippage: transactionInfo.estimatedSlippage!.toDouble(),
          receiveAmount: transactionInfo.receiveAmount!.toDouble()));
    } catch (e) {
      emit(state.copy(status: Status.error));
    }
  }

  TransactionInfo calculateBuyPricingInfo(AptBuyInfo? buyInfo) {
    final aptLiquidity = buyInfo!.aptLiquidity;
    final axLiquidity = buyInfo.axLiquidity;
    final aptInputAmount = BigInt.from(state.aptInputAmount);
    final currentPrice = (axLiquidity / aptLiquidity);
    final nextPrice = axLiquidity / (aptLiquidity + aptInputAmount);
    final slippage = ((nextPrice - currentPrice) / currentPrice) * 100;
    final minimumReceiveAmt = (aptInputAmount * BigInt.from(nextPrice));
    return TransactionInfo(
        minimumReceiveAmt, BigInt.from(slippage), minimumReceiveAmt);
  }

  void _mapMaxBuyTapEventToState(
      OnMaxBuyTap event, Emitter<BuyDialogState> emit) {}

  void _mapConfirmBuyEventToState(
      OnConfirmBuy event, Emitter<BuyDialogState> emit) {}
}
