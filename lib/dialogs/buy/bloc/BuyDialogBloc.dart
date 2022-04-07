
import 'dart:async';

import 'package:ax_dapp/dialogs/buy/models/BuyDialogEvent.dart';
import 'package:ax_dapp/dialogs/buy/models/BuyDialogState.dart';
import 'package:ax_dapp/dialogs/buy/usecases/GetAPTBuyInfoUseCase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyDialogBloc extends Bloc<BuyDialogEvent, BuyDialogState> {
  GetAPTBuyInfoUseCase repo;
  BuyDialogBloc({required this.repo}): super(const BuyDialogState()){
    on<OnLoadDialog>(_mapLoadDialogEventToState);
    on<OnMaxBuyTap>(_mapMaxBuyTapEventToState);
    on<OnConfirmBuy>(_mapConfirmBuyEventToState);
  }


  void _mapLoadDialogEventToState(OnLoadDialog event, Emitter<BuyDialogState> emit) {
  }

  void _mapMaxBuyTapEventToState(OnMaxBuyTap event, Emitter<BuyDialogState> emit) {
  }

  void _mapConfirmBuyEventToState(OnConfirmBuy event, Emitter<BuyDialogState> emit) {
  }
}