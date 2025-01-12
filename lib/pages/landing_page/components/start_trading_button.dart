import 'package:ax_dapp/pages/v1_app.dart';
import 'package:ax_dapp/service/tracking/tracking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartTradingButton extends StatelessWidget {
  const StartTradingButton({
    super.key,
    required this.isWeb,
    required this.tradingTextSize,
  });

  final bool isWeb;
  final double tradingTextSize;

  @override
  Widget build(BuildContext context) {
    return isWeb
        ? TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                  side: BorderSide(color: Colors.amber[400]!),
                ),
              ),
            ),
            onPressed: () {
              context.read<TrackingCubit>().onPressedStartTrading();
              navigateToV1App(context);
            },
            child: Text(
              'Start Trading',
              style: TextStyle(
                color: Colors.amber[400],
                fontSize: tradingTextSize,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        : TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.amber[300]!.withOpacity(0.15),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.transparent),
                ),
              ),
            ),
            onPressed: () {
              context.read<TrackingCubit>().onPressedStartTrading();
              navigateToV1App(context);
            },
            child: Text(
              'Start',
              style: TextStyle(
                color: Colors.amber[400],
                fontSize: tradingTextSize,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w400,
              ),
            ),
          );
  }

  void navigateToV1App(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => const V1App()),
    );
  }
}
