import 'package:ae_dapp/service/Athlete.dart';
import 'package:ae_dapp/service/AthleteApi.dart';
import 'package:ae_dapp/style/Style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:html';
import 'package:ae_dapp/service/Controller.dart';
import 'package:web3dart/browser.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3dart/web3dart.dart';

class ScoutPage extends StatefulWidget {
  const ScoutPage({Key? key}) : super(key: key);

  @override
  _ScoutPageState createState() => _ScoutPageState();
}

_launchURL(String $url) async {
  if (await canLaunch($url)) {
    await launch($url);
  } else {
    throw 'Could not launch ${$url}';
  }
}

Controller _controller = Controller();

Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    backgroundColor: Colors.grey[900],
    title: Text('Connect to a wallet',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey[400],
          fontSize: 20,
          fontFamily: 'OpenSans',
        )),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: ElevatedButton(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Text('Install Metamask'),
              ),
            ),
            onPressed: () async {
              _launchURL("https://metamask.io");
            },
            style: walletButton,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: ElevatedButton(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Text('WalletConnect'),
              ),
            ),
            onPressed: () async {
              _launchURL("https://walletconnect.org");
            },
            style: walletButton,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: ElevatedButton(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Text('Coinbase Wallet'),
              ),
            ),
            onPressed: () {
              _launchURL("https://wallet.coinbase.com");
            },
            style: walletButton,
          ),
        ),
      ],
    ),
  );
}

class _ScoutPageState extends State<ScoutPage> {
  bool walletConnected = false;
  void initState() {
    super.initState();
    walletConnected = true;
  }

  Widget addressConnect(BuildContext context) {
    Widget child;
    if (walletConnected) {
      child = Container(
          decoration: BoxDecoration(
              border: Border.all(color: (Colors.amber[600])!, width: 2),
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          width: 150,
          height: 20,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Center(
                child: Text(
              ('0x' + ('208g8d84n90vsdksk8asdfjklaskdf').toUpperCase()),
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.white.withOpacity(0.6),
                  fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            )),
          ));
    } else {
      child = Container(
          decoration: BoxDecoration(
              border: Border.all(color: (Colors.grey[800])!, width: 2),
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          width: 150,
          height: 20,
          child: ElevatedButton(
            child: Text(
              'Connect Wallet',
              style: TextStyle(color: Colors.white.withOpacity(0.6)),
            ),
            onPressed: () async {
              if (window.ethereum == null) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialog(context),
                );
              } else {
                checkMetamask();
              }
            },
            style: connectButton,
          ));
    }
    return child;
  }

  Future<void> checkMetamask() async {
    final eth = window.ethereum;
    if (eth != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Connected to the decentralized web!"),
        backgroundColor: Colors.green,
      ));
      // Immediately
      final client = Web3Client.custom(eth.asRpcService());
      final credentials = await eth.requestAccount();
      _controller.updateClient(client);
      _controller.updateCredentials(credentials);
      setState(() {
        walletConnected = true;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            // Portrait widget returns
            if (MediaQuery.of(context).orientation == Orientation.portrait) {
              // Mobile/tablet in portrait mode
              if (constraints.maxWidth < 900) {
                return Text('Mobile');
              }
            }
            // Landscape widget returns
            else {
              // Landscape and smaller than 900px width
              if (constraints.maxWidth < 900) {
                return Text('Landscape Mobile/Tablet');
              }
              // Landscape and larger than 900px width
              else {
                return Text('Landscape Desktop');
              }
            }
            return Text('Nothing');
          },
        ),
        appBar: (MediaQuery.of(context).orientation == Orientation.portrait)
            ? null
            : AppBar(
                title: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Image.asset('assets/images/x.png',
                          fit: BoxFit.cover, height: 40.0, width: 50.0),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: TextButton(
                        style: navButton,
                        child: Text('SCOUT'),
                        onPressed: () {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: TextButton(
                        style: navButton,
                        child: Text('DEX'),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                actions: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: addressConnect(context))
                ],
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false));
  }
}
