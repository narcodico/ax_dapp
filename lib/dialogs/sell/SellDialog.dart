import 'package:ax_dapp/dialogs/sell/bloc/SellDialogBloc.dart';
import 'package:ax_dapp/service/ApproveButton.dart';
import 'package:ax_dapp/service/Dialog.dart';
import 'package:ax_dapp/service/TokenList.dart';
import 'package:ax_dapp/util/TokenType.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SellDialog extends StatefulWidget {
  final String athleteName;
  final double aptPrice;
  final int athleteId;

  SellDialog(this.athleteName, this.aptPrice, this.athleteId);

  @override
  State<StatefulWidget> createState() => _SellDialogState();
}

class _SellDialogState extends State<SellDialog> {
  double paddingHorizontal = 20;
  double hgt = 500;
  TextEditingController _aptAmountController = TextEditingController();

  TokenType _currentTokenTypeSelection = TokenType.Long;
  double slippageTolerance =
      1; // in percents, slippage tolerance determines the upper bound of the receive amount, below which transaction gets reverted

  Widget toggleLongShortToken(double wid, double hgt) {
    return Container(
      padding: EdgeInsets.all(1.5),
      width: wid * 0.25,
      height: hgt * 0.05,
      decoration: boxDecoration(Colors.transparent, 20, 1, Colors.grey[800]!),
      child: Container(
        child: Row(
          children: [
            Expanded(
              //Long apt toggle button
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.zero,
                  minimumSize: Size(50, 30),
                  primary: (_currentTokenTypeSelection == TokenType.Long)
                      ? Colors.amber
                      : Colors.transparent,
                ),
                onPressed: () {
                  setState(() {
                    _currentTokenTypeSelection = TokenType.Long;
                  });
                },
                child: Text(
                  "Long",
                  style: TextStyle(
                      color: (_currentTokenTypeSelection == TokenType.Long)
                          ? Colors.black
                          : Color.fromRGBO(154, 154, 154, 1),
                      fontSize: 11),
                ),
              ),
            ),
            Expanded(
              //short apt toggle button
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.zero,
                    minimumSize: Size(50, 30),
                    primary: (_currentTokenTypeSelection == TokenType.Long)
                        ? Colors.transparent
                        : Colors.black),
                onPressed: () {
                  setState(() {
                    _currentTokenTypeSelection = TokenType.Short;
                  });
                },
                child: Text(
                  "Short",
                  style: TextStyle(
                      color: (_currentTokenTypeSelection == TokenType.Long)
                          ? Color.fromRGBO(154, 154, 154, 1)
                          : Colors.amber,
                      fontSize: 11),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget showPrice(price) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Price:", style: textStyle(Colors.white, 15, false)),
          Text(
            "$price AX per " +
                widget.athleteName +
                " " +
                _currentTokenTypeSelection.name +
                " APT",
            style: textStyle(Colors.white, 15, false),
          ),
        ],
      ),
    );
  }

  Widget showTotalFee(totalFee) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Total Fees:", style: textStyle(Colors.grey[600]!, 15, false)),
          Text(
            "$totalFee APT(0.3%)",
            style: textStyle(Colors.grey[600]!, 15, false),
          ),
        ],
      ),
    );
  }

  Widget showBalance(balance) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Balance: $balance",
            style: textStyle(Colors.grey[600]!, 15, false),
          ),
        ],
      ),
    );
  }

  Widget showMarketPriceImpact(marketPriceImpact) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Market Price Impact:",
              style: textStyle(Colors.grey[600]!, 15, false)),
          Text(
            "$marketPriceImpact %",
            style: textStyle(Colors.grey[600]!, 15, false),
          ),
        ],
      ),
    );
  }

  Widget showMinimumReceived(minimumReceived) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Minimum Received:",
            style: textStyle(Colors.grey[600]!, 15, false),
          ),
          Text(
            "$minimumReceived AX",
            style: textStyle(Colors.grey[600]!, 15, false),
          ),
        ],
      ),
    );
  }

  Widget showSlippage(slipageTolerance) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Slippage Tolerance:",
            style: textStyle(Colors.grey[600]!, 15, false),
          ),
          Text(
            "$slipageTolerance %",
            style: textStyle(Colors.grey[600]!, 15, false),
          ),
        ],
      ),
    );
  }

  Widget showYouReceived(amountToReceive) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "You Receive:",
            style: textStyle(Colors.white, 15, false),
          ),
          Text(
            "$amountToReceive AX",
            style: textStyle(Colors.white, 15, false),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isWeb = true;
    isWeb =
        kIsWeb && (MediaQuery.of(context).orientation == Orientation.landscape);
    double _height = MediaQuery.of(context).size.height;
    double wid = isWeb ? 400 : 355;
    double hgt = 500;
    if (_height < 505) hgt = _height;

    return BlocBuilder<SellDialogBloc, SellDialogState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          final bloc = context.read<SellDialogBloc>();
          final price = state.aptSellInfo.axPrice.toStringAsFixed(6);
          final balance = state.balance;
          final minReceived = state.aptSellInfo.minimumReceived.toStringAsFixed(6);
          final priceImpact = state.aptSellInfo.priceImpact.toStringAsFixed(6);
          final receiveAmount = state.aptSellInfo.receiveAmount.toStringAsFixed(6);
          final totalFee = state.aptSellInfo.totalFee;
          if (state.tokenAddress.isEmpty ||
              state.tokenAddress != _getCurrentTokenAddress()) {
            reloadSellDialog(bloc);
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
                children: <Widget>[
                  Container(
                      width: wid,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Sell " + widget.athleteName + " APT",
                              style: textStyle(Colors.white, 20, false)),
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      )),
                  Container(
                    width: wid,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  "You can sell APT's at Market Price for AX.",
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: isWeb ? 14 : 12)),
                          TextSpan(
                              text:
                                  " You can access other funds with AX on the Matic network through",
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: isWeb ? 14 : 12)),
                          TextSpan(
                              text: " SushiSwap",
                              style: TextStyle(
                                  color: Colors.amber[400],
                                  fontSize: isWeb ? 14 : 12)),
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
                        String urlString =
                            "https://athletex-markets.gitbook.io/athletex-huddle/how-to.../buy-ax-coin";
                        launchUrl(Uri.parse(urlString));
                      },
                      child: Text(
                        'Learn How to buy AX',
                        style:
                            TextStyle(color: Colors.amber[400], fontSize: 14),
                      ),
                    ),
                  ),
                  //Input apt text with toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isWeb
                            ? "Input APT:"
                            : "Input APT amount you want to sell:",
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
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    width: wid,
                    height: 70,
                    decoration: boxDecoration(
                        Colors.transparent, 14, 0.5, Colors.grey[400]!),
                    child: Column(
                      children: [
                        //APT icon - athlete name - max button - input field
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(width: 5),
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  scale: 0.5,
                                  image: AssetImage("assets/images/x.png"),
                                ),
                              ),
                            ),
                            Container(width: 15),
                            Expanded(
                              child: Text(
                                widget.athleteName + " " + _currentTokenTypeSelection.name + " " +
                                    " APT",
                                style: textStyle(Colors.white, 15, false),
                              ),
                            ),
                            Container(
                              height: 28,
                              width: 48,
                              decoration: boxDecoration(Colors.transparent, 100,
                                  0.5, Colors.grey[400]!),
                              child: TextButton(
                                onPressed: () {
                                  bloc.add(MaxSellTap());
                                  _aptAmountController.text = state.balance.toStringAsFixed(6);
                                },
                                child: Text(
                                  "MAX",
                                  style: textStyle(Colors.grey[400]!, 9, false),
                                ),
                              ),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: wid * 0.4),
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: _aptAmountController,
                                  style:
                                      textStyle(Colors.grey[400]!, 22, false),
                                  decoration: InputDecoration(
                                    hintText: '0.00',
                                    hintStyle:
                                        textStyle(Colors.grey[400]!, 22, false),
                                    contentPadding: EdgeInsets.only(left: 3),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (newAptInput) {
                                    if (newAptInput.isEmpty) newAptInput = "0";
                                    bloc.add(NewAptInput(
                                        aptInputAmount:
                                            double.parse(newAptInput)));
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        (RegExp(r'^(\d+)?\.?\d{0,6}'))),
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
                  Container(
                      width: wid,
                      height: 125,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              showPrice(price),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              showTotalFee(totalFee.toStringAsFixed(6)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [showMarketPriceImpact(priceImpact)],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              showMinimumReceived(minReceived),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              showSlippage(slippageTolerance),
                            ],
                          ),
                        ],
                      )),
                  Container(
                    width: wid,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        showYouReceived(receiveAmount),
                      ],
                    ),
                  ),
                  Container(
                    width: wid,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ApproveButton(
                            175,
                            40,
                            "Approve",
                            bloc.swapController.approve,
                            bloc.swapController.swap,
                            transactionConfirmed),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void reloadSellDialog(SellDialogBloc bloc) {
    bloc.add(LoadDialog(currentTokenAddress: _getCurrentTokenAddress()));
  }

  String _getCurrentTokenAddress() {
    return (_currentTokenTypeSelection == TokenType.Long)
        ? getLongAptAddress(widget.athleteId)
        : getShortAptAddress(widget.athleteId);
  }
}