// ignore_for_file: avoid_positional_boolean_parameters

import 'package:ax_dapp/dialogs/buy/bloc/buy_dialog_bloc.dart';
import 'package:ax_dapp/dialogs/buy/buy_dialog.dart';
import 'package:ax_dapp/dialogs/sell/bloc/sell_dialog_bloc.dart';
import 'package:ax_dapp/dialogs/sell/sell_dialog.dart';
import 'package:ax_dapp/pages/scout/dialogs/athlete_page_dialogs.dart';
import 'package:ax_dapp/pages/scout/models/athlete_scout_model.dart';
import 'package:ax_dapp/repositories/subgraph/usecases/get_buy_info_use_case.dart';
import 'package:ax_dapp/repositories/subgraph/usecases/get_sell_info_use_case.dart';
import 'package:ax_dapp/service/controller/controller.dart';
import 'package:ax_dapp/service/controller/usecases/get_max_token_input_use_case.dart';
import 'package:ax_dapp/util/athlete_page_format_helper.dart';
import 'package:ax_dapp/util/colors.dart';
import 'package:ax_dapp/util/toastx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

Container buyButton(
  BuildContext context,
  AthleteScoutModel athlete,
  bool isPortraitMode,
  double containerWdt,
  bool isLongApt,
  void Function() goToTradePage,
) {
  final controller = Get.find<Controller>();
  return Container(
    width: isPortraitMode ? containerWdt / 3 : 175,
    height: 50,
    //if app is in portrait, buyButton will use 1/4 of the total width
    decoration: boxDecoration(primaryOrangeColor, 100, 0, primaryOrangeColor),
    child: TextButton(
      onPressed: () {
        if (controller.walletConnected) {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) => BlocProvider(
              create: (BuildContext context) => BuyDialogBloc(
                repo: RepositoryProvider.of<GetBuyInfoUseCase>(context),
                wallet: GetTotalTokenBalanceUseCase(Get.find()),
                swapController: Get.find(),
              ),
              child: BuyDialog(
                athlete: athlete,
                athleteName: athlete.name,
                aptPrice: athlete.longTokenBookPrice!,
                athleteId: athlete.id,
                isLongApt: isLongApt,
                goToTradePage: goToTradePage,
              ),
            ),
          );
        } else {
          context.showWalletWarningToast();
        }
      },
      child: Text('Buy', style: textStyle(Colors.black, 20, false, false)),
    ),
  );
}

Container sellButton(
  BuildContext context,
  AthleteScoutModel athlete,
  bool isPortraitMode,
  bool isLongApt,
  double containerWdt,
) {
  final controller = Get.find<Controller>();
  return Container(
    width: isPortraitMode ? containerWdt / 3 : 175,
    height: 50,
    // if portrait mode, use 1/3 of container width
    decoration: boxDecoration(Colors.white, 100, 0, Colors.white),
    child: TextButton(
      onPressed: () {
        if (controller.walletConnected) {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) => BlocProvider(
              create: (BuildContext context) => SellDialogBloc(
                repo: RepositoryProvider.of<GetSellInfoUseCase>(context),
                wallet: GetTotalTokenBalanceUseCase(Get.find()),
                swapController: Get.find(),
              ),
              child: SellDialog(
                athlete: athlete,
                athleteName: athlete.name,
                aptPrice: athlete.longTokenBookPrice!,
                isLongApt: isLongApt,
                athleteId: athlete.id,
              ),
            ),
          );
        } else {
          context.showWalletWarningToast();
        }
      },
      child: Text('Sell', style: textStyle(Colors.black, 20, false, false)),
    ),
  );
}

Container mintButton(
  BuildContext context,
  AthleteScoutModel athlete,
  bool isPortraitMode,
  double containerWdt,
  void Function() goToTradePage,
) {
  final controller = Get.find<Controller>();
  return Container(
    width: isPortraitMode ? containerWdt / 3 : 175,
    height: 50,
    decoration: boxDecoration(Colors.transparent, 100, 2, Colors.white),
    child: TextButton(
      onPressed: () {
        if (controller.walletConnected) {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) =>
                MintDialog(athlete: athlete, goToTradePage: goToTradePage),
          );
        } else {
          context.showWalletWarningToast();
        }
      },
      child:
          Text('Mint Pair', style: textStyle(Colors.white, 20, false, false)),
    ),
  );
}

Container redeemButton(
  BuildContext context,
  AthleteScoutModel athlete,
  String inputLongApt,
  String inputShortApt,
  String valueInAX,
  bool isPortraitMode,
  double containerWdt,
) {
  final controller = Get.find<Controller>();
  return Container(
    width: isPortraitMode ? containerWdt / 3 : 175,
    height: 50,
    decoration: boxDecoration(Colors.transparent, 100, 2, Colors.white),
    child: TextButton(
      onPressed: () {
        if (controller.walletConnected) {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) => RedeemDialog(
              athlete,
              athlete.sport.toString(),
              inputLongApt,
              inputShortApt,
              valueInAX,
            ),
          );
        } else {
          context.showWalletWarningToast();
        }
      },
      child: Text(
        'Redeem Pair',
        style: textStyle(Colors.white, 20, false, false),
      ),
    ),
  );
}
