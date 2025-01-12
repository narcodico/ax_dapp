import 'package:ax_dapp/service/failed_dialog.dart';
import 'package:ax_dapp/service/tracking/tracking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// This code changes the state of the button
class TradeApproveButton extends StatefulWidget {
  const TradeApproveButton({
    required this.width,
    required this.height,
    required this.text,
    required this.approveCallback,
    required this.confirmCallback,
    required this.confirmDialog,
    required this.fromCurrency,
    required this.toCurrency,
    required this.fromUnits,
    required this.toUnits,
    required this.totalFee,
    required this.walletAddress,
    super.key,
  });

  final String text;
  final double width;
  final double height;
  final String fromCurrency;
  final String toCurrency;
  final String fromUnits;
  final String toUnits;
  final String totalFee;
  final String walletAddress;
  final Future<void> Function() approveCallback;
  final Future<void> Function() confirmCallback;
  final Dialog Function(BuildContext) confirmDialog;

  @override
  State<TradeApproveButton> createState() => _TradeApproveButtonState();
}

class _TradeApproveButtonState extends State<TradeApproveButton> {
  double width = 0;
  double height = 0;
  String text = '';
  bool isApproved = false;
  Color? fillcolor;
  Color? textcolor;
  Widget? dialog;

  @override
  void initState() {
    super.initState();
    width = widget.width;
    height = widget.height;
    text = widget.text;
    fillcolor = Colors.transparent;
    textcolor = Colors.amber;
  }

  void changeButton() {
    //Changes from approve button to confirm
    widget.approveCallback().then((_) {
      setState(() {
        isApproved = true;
        text = 'Confirm';
        fillcolor = Colors.amber;
        textcolor = Colors.black;
      });
    }).catchError((_) {
      showDialog<void>(
        context: context,
        builder: (context) => const FailedDialog(),
      );
      setState(() {
        isApproved = false;
        text = 'Approve';
        fillcolor = Colors.transparent;
        textcolor = Colors.amber;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.amber),
        color: fillcolor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextButton(
        onPressed: () {
          if (isApproved) {
            context.read<TrackingCubit>().onSwapConfirmClick(
                  fromCurrency: widget.fromCurrency,
                  toCurrency: widget.toCurrency,
                  fromUnits: widget.fromUnits,
                  toUnits: widget.toUnits,
                  totalFee: widget.totalFee,
                  walletId: widget.walletAddress,
                );
            //Confirm button pressed
            widget.confirmCallback().then((value) {
              context.read<TrackingCubit>().onSwapConfirmedTransaction(
                    fromCurrency: widget.fromCurrency,
                    toCurrency: widget.toCurrency,
                    fromUnits: widget.fromUnits,
                    toUnits: widget.toUnits,
                    totalFee: widget.totalFee,
                    walletId: widget.walletAddress,
                  );
              showDialog<void>(
                context: context,
                builder: (BuildContext context) =>
                    widget.confirmDialog(context),
              );
            }).catchError((error) {
              showDialog<void>(
                context: context,
                builder: (context) => const FailedDialog(),
              );
            });
          } else {
            //Approve button was pressed
            context.read<TrackingCubit>().onSwapApproveClick(
                  fromCurrency: widget.fromCurrency,
                  toCurrency: widget.toCurrency,
                  fromUnits: widget.fromUnits,
                  toUnits: widget.toUnits,
                  totalFee: widget.totalFee,
                  walletId: widget.walletAddress,
                );
            changeButton();
          }
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: textcolor,
          ),
        ),
      ),
    );
  }
}
