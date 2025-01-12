// ignore_for_file: avoid_positional_boolean_parameters

import 'package:ax_dapp/pages/farm/components/sport_token.dart';
import 'package:ax_dapp/pages/farm/dialogs/stake_dialog.dart';
import 'package:ax_dapp/pages/farm/modules/box_decoration.dart';
import 'package:ax_dapp/pages/farm/modules/page_text_style.dart';
import 'package:ax_dapp/service/controller/farms/farm_controller.dart';
import 'package:flutter/material.dart';

Widget singleLogoFarmTitle(
  BuildContext context,
  bool isWeb,
  FarmController farm,
  double cardWidth,
) {
  //Dialog that appears when stake button is pressed

  return SizedBox(
    width: cardWidth,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/x.jpg'),
            ),
          ),
        ),
        Container(width: 15),
        Expanded(
          child: farm.athlete == null
              ? SportToken(sport: farm.sport, symbol: '${farm.strName} Farm')
              : SportToken(sport: farm.sport, symbol: '${farm.athlete!} Farm'),
        ),
        Container(
          width: 120,
          height: 35,
          decoration: boxDecoration(
            Colors.amber[600]!,
            100,
            0,
            Colors.amber[600]!,
          ),
          child: TextButton(
            onPressed: () => showDialog<void>(
              context: context,
              builder: (BuildContext builderContext) => StakeDialog(
                context: builderContext,
                farm: farm,
                layoutWdt: cardWidth,
                isWeb: isWeb,
              ),
            ),
            child: Text(
              'Stake',
              style: textStyle(Colors.black, 14, true, false),
            ),
          ),
        ),
      ],
    ),
  );
}
