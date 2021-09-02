import 'package:ae_dapp/service/AllAthletesList.dart';
import 'package:ae_dapp/service/AthleteProfile.dart';
import 'package:ae_dapp/style/Style.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

Widget _mintAPT(BuildContext context) {
  return new AlertDialog(
    backgroundColor: Colors.grey[900],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    title: Text('Confirm Swap', textAlign: TextAlign.left, style: confirmText),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //FROM
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [Text('From', style: confirmText)],
              ),
              Column(
                children: [Text('~\$1,300.00', style: confirmText)],
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [Text('ETH', style: confirmTextCoin)],
              ),
              Column(
                children: [Text('10.0702', style: confirmTextCoin)],
              )
            ],
          ),
        ),
        //DOWN ARROW
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [Icon(Icons.arrow_downward, size: 15)],
              )
            ],
          ),
        ),
        //TO
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [Text('To', style: confirmText)],
              ),
              Row(children: [
                Column(children: [Text('~\$1,290.00', style: confirmText)]),
                Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Column(children: [
                      Text('(0.079%)', style: confirmTextPercent)
                    ]))
              ])
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'AX',
                    style: confirmTextCoin,
                  )
                ],
              ),
              Column(
                children: [Text('9.1000', style: confirmTextCoin)],
              )
            ],
          ),
        ),
        //PRICE
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Price',
                    style: confirmText,
                  )
                ],
              ),
              Column(
                children: [
                  Text('1 AX = .00589 ETH', style: confirmTextOtherBold)
                ],
              )
            ],
          ),
        ),
        //OTHER INFO
        Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Liquidity Provider Fee',
                    style: confirmTextOther,
                  )
                ],
              ),
              Column(
                children: [Text('0.000824 ETH', style: confirmTextOtherBold)],
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Price Impact',
                    style: confirmTextOther,
                  )
                ],
              ),
              Column(
                children: [Text('-0.03%', style: confirmTextOtherBold)],
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Maximum sent',
                    style: confirmTextOther,
                  )
                ],
              ),
              Column(
                children: [Text('0.289529 ETH', style: confirmTextOtherBold)],
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Slippage tolerance',
                    style: confirmTextOther,
                  )
                ],
              ),
              Column(
                children: [Text('0.05%', style: confirmTextOtherBold)],
              )
            ],
          ),
        ),
        //CONFIRMATION BUTTON
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () {},
                  style: confirmSwap,
                  child: Text('Confirm Swap'))
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _redeemAX(BuildContext context) {
  return new AlertDialog(
    backgroundColor: Colors.grey[900],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    title: Text('Confirm Swap', textAlign: TextAlign.left, style: confirmText),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //FROM
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [Text('From', style: confirmText)],
              ),
              Column(
                children: [Text('~\$1,300.00', style: confirmText)],
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [Text('ETH', style: confirmTextCoin)],
              ),
              Column(
                children: [Text('10.0702', style: confirmTextCoin)],
              )
            ],
          ),
        ),
        //DOWN ARROW
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [Icon(Icons.arrow_downward, size: 15)],
              )
            ],
          ),
        ),
        //TO
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [Text('To', style: confirmText)],
              ),
              Row(children: [
                Column(children: [Text('~\$1,290.00', style: confirmText)]),
                Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Column(children: [
                      Text('(0.079%)', style: confirmTextPercent)
                    ]))
              ])
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'AX',
                    style: confirmTextCoin,
                  )
                ],
              ),
              Column(
                children: [Text('9.1000', style: confirmTextCoin)],
              )
            ],
          ),
        ),
        //PRICE
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Price',
                    style: confirmText,
                  )
                ],
              ),
              Column(
                children: [
                  Text('1 AX = .00589 ETH', style: confirmTextOtherBold)
                ],
              )
            ],
          ),
        ),
        //OTHER INFO
        Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Liquidity Provider Fee',
                    style: confirmTextOther,
                  )
                ],
              ),
              Column(
                children: [Text('0.000824 ETH', style: confirmTextOtherBold)],
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Price Impact',
                    style: confirmTextOther,
                  )
                ],
              ),
              Column(
                children: [Text('-0.03%', style: confirmTextOtherBold)],
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Maximum sent',
                    style: confirmTextOther,
                  )
                ],
              ),
              Column(
                children: [Text('0.289529 ETH', style: confirmTextOtherBold)],
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Slippage tolerance',
                    style: confirmTextOther,
                  )
                ],
              ),
              Column(
                children: [Text('0.05%', style: confirmTextOtherBold)],
              )
            ],
          ),
        ),
        //CONFIRMATION BUTTON
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () {},
                  style: confirmSwap,
                  child: Text('Confirm Swap'))
            ],
          ),
        ),
      ],
    ),
  );
}

class _ExplorePageState extends State<ExplorePage> {
  double lgTxSize = 52;
  double headerTx = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        decoration: new BoxDecoration(
          color: const Color(0xff7c94b6),
          image: new DecorationImage(
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(.9), BlendMode.darken),
            image: AssetImage("assets/images/background.jpeg"),
          ),
        ),
      ),
      Column(children: <Widget>[
        Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Image(
                width: 80,
                height: 80,
                image: AssetImage("assets/images/x.png"),
              ),
            )),
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text("EXPLORE",
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: lgTxSize,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              )),
        ),
        Container(
            width: MediaQuery.of(context).size.width - 250,
            height: MediaQuery.of(context).size.height * .675,
            padding: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[900],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text("Athlete Tokens",
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                            ))),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: ConstrainedBox(
                        constraints: BoxConstraints.tight(Size(250, 60)),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              fillColor: Colors.grey[800],
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: (Colors.grey[900])!,
                                  width: 3.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: (Colors.grey[900])!,
                                  width: 3.0,
                                ),
                              ),
                              border: UnderlineInputBorder(),
                              hintText: 'Search for an Athlete',
                              hintStyle: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * .45,
                        width: MediaQuery.of(context).size.width / 2 - 350,
                        child: AllAthletesList())
                  ],
                ),
              ],
            )),
      ]),
    ]));
  }
}

/*
Explore Page
My Team
Generate Key
*/

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
