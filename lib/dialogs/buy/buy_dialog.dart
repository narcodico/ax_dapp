import 'package:ax_dapp/dialogs/buy/bloc/buy_dialog_bloc.dart';
import 'package:ax_dapp/pages/athlete/components/athlete_buy_approve_button.dart';
import 'package:ax_dapp/pages/scout/models/athlete_scout_model.dart';
import 'package:ax_dapp/service/controller/controller.dart';
import 'package:ax_dapp/service/dialog.dart';
import 'package:ax_dapp/service/token_list.dart';
import 'package:ax_dapp/util/bloc_status.dart';
import 'package:ax_dapp/util/format_wallet_address.dart';
import 'package:ax_dapp/util/toastx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:url_launcher/url_launcher.dart';

class BuyDialog extends StatefulWidget {
  const BuyDialog({
    required this.athlete,
    required this.athleteName,
    required this.aptPrice,
    required this.athleteId,
    required this.isLongApt,
    required this.goToTradePage,
    super.key,
  });
  final AthleteScoutModel athlete;
  final String athleteName;
  final double aptPrice;
  final int athleteId;
  final bool isLongApt;
  final void Function() goToTradePage;

  @override
  State<StatefulWidget> createState() => _BuyDialogState();
}

class _BuyDialogState extends State<BuyDialog> {
  double paddingHorizontal = 20;
  double hgt = 500;
  final TextEditingController _aptAmountController = TextEditingController();

  bool isFirst = true;
  bool isLongSelected = true;
  // in percents, slippage tolerance determines the upper bound of the receive
  // amount, below which transaction gets reverted
  double slippageTolerance = 1;
  Controller controller = Get.find();

  @override
  void dispose() {
    _aptAmountController.dispose();
    super.dispose();
  }

  Widget toggleLongShortToken(double wid, double hgt) {
    return Container(
      padding: const EdgeInsets.all(1.5),
      width: wid * 0.25,
      height: hgt * 0.05,
      decoration: boxDecoration(Colors.transparent, 20, 1, Colors.grey[800]!),
      child: Row(
        children: [
          Expanded(
            //Long apt toggle button
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
                primary: (isFirst ? widget.isLongApt : isLongSelected)
                    ? Colors.amber
                    : Colors.transparent,
              ),
              onPressed: () {
                setState(() {
                  isLongSelected = true;
                  isFirst = false;
                });
              },
              child: Text(
                'Long',
                style: TextStyle(
                  color: (isFirst ? widget.isLongApt : isLongSelected)
                      ? Colors.black
                      : const Color.fromRGBO(154, 154, 154, 1),
                  fontSize: 11,
                ),
              ),
            ),
          ),
          Expanded(
            //short apt toggle button
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
                primary: (isFirst ? widget.isLongApt : isLongSelected)
                    ? Colors.transparent
                    : Colors.black,
              ),
              onPressed: () {
                setState(() {
                  isLongSelected = false;
                  isFirst = false;
                });
              },
              child: Text(
                'Short',
                style: TextStyle(
                  color: (isFirst ? widget.isLongApt : isLongSelected)
                      ? const Color.fromRGBO(154, 154, 154, 1)
                      : Colors.amber,
                  fontSize: 11,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget showPrice(String price) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Price:', style: textStyle(Colors.white, 15, false)),
          if (isFirst ? widget.isLongApt : isLongSelected)
            Text(
              '$price AX per ${getLongAthleteSymbol(widget.athleteId)} APT',
              style: textStyle(Colors.white, 15, false),
            )
          else
            Text(
              '$price AX per ${getShortAthleteSymbol(widget.athleteId)} APT',
              style: textStyle(Colors.white, 15, false),
            )
        ],
      ),
    );
  }

  Widget showTotalFee(String totalFee) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total Fees:', style: textStyle(Colors.grey[600]!, 15, false)),
          Text(
            '$totalFee AX(0.3%)',
            style: textStyle(Colors.grey[600]!, 15, false),
          ),
        ],
      ),
    );
  }

  Widget showBalance(double balance) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Balance: $balance',
            style: textStyle(Colors.grey[600]!, 15, false),
          ),
        ],
      ),
    );
  }

  Widget showMarketPriceImpact(String marketPriceImpact) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Market Price Impact:',
            style: textStyle(Colors.grey[600]!, 15, false),
          ),
          Text(
            '$marketPriceImpact %',
            style: textStyle(Colors.grey[600]!, 15, false),
          ),
        ],
      ),
    );
  }

  Widget showMinimumReceived(String minimumReceived) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Minimum Received:',
            style: textStyle(Colors.grey[600]!, 15, false),
          ),
          Text(
            '$minimumReceived APT',
            style: textStyle(Colors.grey[600]!, 15, false),
          ),
        ],
      ),
    );
  }

  Widget showSlippage(double slipageTolerance) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Slippage Tolerance:',
            style: textStyle(Colors.grey[600]!, 15, false),
          ),
          Text(
            '$slipageTolerance %',
            style: textStyle(Colors.grey[600]!, 15, false),
          ),
        ],
      ),
    );
  }

  Widget showYouReceived(String amountToReceive) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'You Receive:',
            style: textStyle(Colors.white, 15, false),
          ),
          if (isFirst ? widget.isLongApt : isLongSelected)
            Text(
              '$amountToReceive '
              '${getLongAthleteSymbol(widget.athleteId)}'
              ' APT',
              style: textStyle(Colors.white, 15, false),
            )
          else
            Text(
              '$amountToReceive ${getShortAthleteSymbol(widget.athleteId)} APT',
              style: textStyle(Colors.white, 15, false),
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var isWeb = true;
    isWeb =
        kIsWeb && (MediaQuery.of(context).orientation == Orientation.landscape);
    final _height = MediaQuery.of(context).size.height;
    final wid = isWeb ? 400.0 : 355.0;
    var hgt = 500.0;
    if (_height < 505) hgt = _height;

    var aptLongOrShort = 'Long Apt';
    if (isFirst ? widget.isLongApt : isLongSelected) {
      aptLongOrShort = 'Long Apt';
    } else {
      aptLongOrShort = 'Short Apt';
    }
    final userWalletAddress = FormatWalletAddress.getWalletAddress(
      controller.publicAddress.toString(),
    );

    return BlocConsumer<BuyDialogBloc, BuyDialogState>(
      listenWhen: (_, current) =>
          current.status == BlocStatus.error ||
          current.status == BlocStatus.noData,
      listener: (context, state) {
        if (state.status == BlocStatus.noData) {
          context.showWarningToast(
            title: 'No Data for APT',
            description: state.errorMessage,
          );
        } else {
          context.showWarningToast(
            title: 'Action Error',
            description: state.errorMessage,
          );
        }
      },
      builder: (context, state) {
        final bloc = context.read<BuyDialogBloc>();
        final aptBuyInfo = state.aptBuyInfo;
        final price = state.aptBuyInfo.axPerAptPrice.toStringAsFixed(6);
        final balance = state.balance;
        final minReceived = state.aptBuyInfo.minimumReceived.toStringAsFixed(6);
        final priceImpact = state.aptBuyInfo.priceImpact.toStringAsFixed(6);
        final receiveAmount = state.aptBuyInfo.receiveAmount.toStringAsFixed(6);
        final totalFee = state.aptBuyInfo.totalFee;
        if ((state.tokenAddress.isEmpty ||
                state.tokenAddress != _getCurrentTokenAddress()) &&
            state.status == BlocStatus.initial) {
          reloadBuyDialog(bloc);
        }
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
            height: hgt,
            width: wid,
            decoration: boxDecoration(Colors.grey[900]!, 30, 0, Colors.black),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: wid,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Buy ${widget.athleteName} APT',
                        style: textStyle(Colors.white, 20, false),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: wid,
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              '''You can purchase APTs at Market Price with AX.\n''',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: isWeb ? 14 : 12,
                          ),
                        ),
                        TextSpan(
                          text: 'Click here to',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: isWeb ? 14 : 12,
                          ),
                        ),
                        TextSpan(
                          text: ' Buy AX',
                          style: TextStyle(
                            color: Colors.amber[400],
                            fontSize: isWeb ? 14 : 12,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                              widget.goToTradePage();
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  width: wid,
                  child: GestureDetector(
                    onTap: () {
                      const urlString =
                          'https://athletex-markets.gitbook.io/athletex-huddle/how-to.../buy-ax-coin';
                      launchUrl(Uri.parse(urlString));
                    },
                    child: Text(
                      'Learn How to buy AX',
                      style: TextStyle(color: Colors.amber[400], fontSize: 14),
                    ),
                  ),
                ),
                //Input apt text with toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isWeb
                          ? 'Input AX:'
                          : 'Input AX amount you want to spend:',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    toggleLongShortToken(wid, hgt),
                  ],
                ),
                //APT input box
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  width: wid,
                  height: 70,
                  decoration: boxDecoration(
                    Colors.transparent,
                    14,
                    0.5,
                    Colors.grey[400]!,
                  ),
                  child: Column(
                    children: [
                      //APT icon - athlete name - max button - input field
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(width: 5),
                          Container(
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                scale: 0.5,
                                image: AssetImage(
                                  'assets/images/X_Logo_Black_BR.png',
                                ),
                              ),
                            ),
                          ),
                          Container(width: 15),
                          Expanded(
                            child: Text(
                              'AX',
                              style: textStyle(Colors.white, 15, false),
                            ),
                          ),
                          Container(
                            height: 28,
                            width: 48,
                            decoration: boxDecoration(
                              Colors.transparent,
                              100,
                              0.5,
                              Colors.grey[400]!,
                            ),
                            child: TextButton(
                              onPressed: () {
                                bloc.add(OnMaxBuyTap());
                                _aptAmountController.text =
                                    state.balance.toStringAsFixed(6);
                              },
                              child: Text(
                                'MAX',
                                style: textStyle(Colors.grey[400]!, 9, false),
                              ),
                            ),
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: wid * 0.4),
                            child: IntrinsicWidth(
                              child: TextField(
                                controller: _aptAmountController,
                                style: textStyle(Colors.grey[400]!, 22, false),
                                decoration: InputDecoration(
                                  hintText: '0.00',
                                  hintStyle:
                                      textStyle(Colors.grey[400]!, 22, false),
                                  contentPadding:
                                      const EdgeInsets.only(left: 3),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  if (value.isEmpty) value = '0';
                                  bloc.add(
                                    OnNewAxInput(
                                      axInputAmount: double.parse(value),
                                    ),
                                  );
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^(\d+)?\.?\d{0,6}'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          showBalance(balance),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.35,
                  color: Colors.grey[400],
                ),
                SizedBox(
                  width: wid,
                  height: 125,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          showPrice(price),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          showTotalFee(totalFee.toStringAsFixed(6)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [showMarketPriceImpact(priceImpact)],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          showMinimumReceived(minReceived),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          showSlippage(slippageTolerance),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: wid,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      showYouReceived(receiveAmount),
                    ],
                  ),
                ),

                SizedBox(
                  width: wid,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AthleteBuyApproveButton(
                        width: 175,
                        height: 40,
                        text: 'Approve',
                        amountInputted: _aptAmountController.text,
                        aptBuyInfo: aptBuyInfo,
                        athlete: widget.athlete,
                        aptName: widget.athleteName,
                        aptId: widget.athleteId,
                        longOrShort: aptLongOrShort,
                        approveCallback: bloc.swapController.approve,
                        confirmCallback: bloc.swapController.swap,
                        confirmDialog: transactionConfirmed,
                        walletAddress: userWalletAddress.walletAddress,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void reloadBuyDialog(BuyDialogBloc bloc) {
    bloc.add(OnLoadDialog(currentTokenAddress: _getCurrentTokenAddress()));
  }

  String _getCurrentTokenAddress() {
    return (isFirst ? widget.isLongApt : isLongSelected)
        ? getLongAptAddress(widget.athleteId)
        : getShortAptAddress(widget.athleteId);
  }
}
