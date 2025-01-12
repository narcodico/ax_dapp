import 'package:ax_dapp/pages/scout/models/athlete_scout_model.dart';
import 'package:ax_dapp/service/failed_dialog.dart';
import 'package:ax_dapp/service/tracking/tracking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// This code changes the state of the button
class AthleteMintApproveButton extends StatefulWidget {
  const AthleteMintApproveButton({
    required this.width,
    required this.height,
    required this.text,
    required this.athlete,
    required this.aptName,
    required this.inputApt,
    required this.valueInAX,
    required this.approveCallback,
    required this.confirmCallback,
    required this.confirmDialog,
    required this.walletAddress,
    super.key,
  });

  final String text;
  final double width;
  final double height;
  final AthleteScoutModel athlete;
  final String aptName;
  final String inputApt;
  final String valueInAX;
  final String walletAddress;
  final Future<void> Function() approveCallback;
  final Future<void> Function() confirmCallback;
  final Dialog Function(BuildContext) confirmDialog;

  @override
  State<AthleteMintApproveButton> createState() =>
      _AthleteMintApproveButtonState();
}

class _AthleteMintApproveButtonState extends State<AthleteMintApproveButton> {
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
      ).then((value) {
        if (mounted) {
          Navigator.pop(context);
        }
      });
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
            //Confirm button pressed
            context.read<TrackingCubit>().trackAthleteMintConfirmButtonClicked(
                  aptName: '${widget.aptName} pair',
                  sport: widget.athlete.sport.toString(),
                  inputApt: widget.inputApt,
                  valueInAx: widget.valueInAX,
                  walletId: widget.walletAddress,
                );
            widget.confirmCallback().then((value) {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) =>
                    widget.confirmDialog(context),
              ).then((value) {
                if (mounted) {
                  Navigator.pop(context);
                }
              });
              context.read<TrackingCubit>().trackAthleteMintSuccess(
                    aptName: '${widget.aptName} pair',
                    sport: widget.athlete.sport.toString(),
                    inputApt: widget.inputApt,
                    valueInAx: widget.valueInAX,
                    walletId: widget.walletAddress,
                  );
            }).catchError((error) {
              showDialog<void>(
                context: context,
                builder: (context) => const FailedDialog(),
              ).then((value) {
                if (mounted) {
                  Navigator.pop(context);
                }
              });
            });
          } else {
            //Approve button was pressed
            context.read<TrackingCubit>().trackAthleteMintApproveButtonClicked(
                  aptName: '${widget.aptName} pair',
                  sport: widget.athlete.sport.toString(),
                  inputApt: widget.inputApt,
                  valueInAx: widget.valueInAX,
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
