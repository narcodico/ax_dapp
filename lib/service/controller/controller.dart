// ignore_for_file: only_throw_errors

import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3dart/web3dart.dart';

//Comment this for Android
const kEmptyWalletId = '0x0000000000000000000000000000000000000000';

class Controller extends GetxController {
  Controller();

  /// VARIABLES
  late Credentials credentials;
  RxInt networkID = 0.obs;
  static String latestTx = '';
  bool walletConnected = false;
  Rx<EtherAmount> gas = EtherAmount.zero().obs;
  RxString gasString = '0'.obs;
  static const mainnetChainId = 137;
  static const testnetChainId = 80001;
  static const mainnetSXChainId = 416;
  static const supportedChains = {
    137: 'https://polygon-rpc.com',
    80001: 'https://matic-mumbai.chainstacklabs.com'
  };
  String mainRPCUrl = 'https://polygon-rpc.com';
  String testRPCUrl = 'https://matic-mumbai.chainstacklabs.com/';
  Rx<Web3Client> client = Web3Client('https://polygon-rpc.com', Client()).obs;
  Rx<EthereumAddress> publicAddress =
      EthereumAddress.fromHex(kEmptyWalletId).obs;

  // ignore: avoid_setters_without_getters
  set axTokenAddress(EthereumAddress tokenAddress) {
    axTokenAddress = EthereumAddress.fromHex(tokenAddress.hex);
  }

  //Comment this for Android
  // Connect the dapp to metamask and update relevant values

  // Connect the client + set credentials

  Future<void> getCurrentGas() async {
    final rawGasPrice = await client.value.getGasPrice();
    final gasPriceinGwei =
        rawGasPrice.getValueInUnit(EtherUnit.gwei).toStringAsFixed(2);

    gasString.value = gasPriceinGwei;
    log('Latest gas: $gasString');
    update();
  }

  // ignore: use_setters_to_change_properties
  void updateTxString(String tx) {
    latestTx = tx;
  }

  static Future<void> viewTx() async {
    var urlString = Uri.parse('');
    latestTx == ''
        ? urlString = Uri.parse('https://polygonscan.com')
        : urlString = Uri.parse('https://polygonscan.com/tx/$latestTx');
    await launchUrl(urlString);
  }
}
