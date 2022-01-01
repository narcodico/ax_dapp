import 'package:ax_dapp/contracts/APTRouter.g.dart';
import 'package:ax_dapp/contracts/Dex.g.dart';
import 'package:ax_dapp/service/Controller/AXT.dart';
import 'package:ax_dapp/service/Controller/Controller.dart';
import 'package:ax_dapp/service/Controller/Token.dart';
import 'AXT.dart';
import 'package:get/get.dart';
import 'package:ax_dapp/contracts/ERC20.g.dart';
import 'package:web3dart/contracts/erc20.dart';
import 'package:web3dart/web3dart.dart';

class SwapController extends GetxController {
  Controller controller = Get.find();
  var activeTkn1 = Token("Empty Token", "ET").obs,
      activeTkn2 = Token("Empty Token", "ET").obs;
  var address1 = "".obs, address2 = "".obs;
  var amount1 = 0.0.obs, amount2 = 0.0.obs;
  var price = 0.0.obs;
  final EthereumAddress dexAddress =
      EthereumAddress.fromHex("0x778EF52b9c18dBCbc6B4A8a58B424eA6cEa5a551");
  final EthereumAddress dexPolygonAddress =
      EthereumAddress.fromHex("0xe06DC83e310807BAcF2e1776925bC19Fa3659D78");
  final EthereumAddress routerAddress =
      EthereumAddress.fromHex("0x7EFc361e568d0038cfB200dF9d9Be27943e19017");
  final EthereumAddress AXTAddress =
      EthereumAddress.fromHex("0x76d9a6e4cdefc840a47069b71824ad8ff4819e85");
  // Deadline is two minutes from 'now'
  final BigInt twoMinuteDeadline = BigInt.from(
      DateTime.now().add(const Duration(minutes: 2)).millisecondsSinceEpoch);
  var deadline = BigInt.zero.obs;
  late Dex _dex;
  late APTRouter _aptRouter;
  BigInt amountOutMin = BigInt.zero;
  double x = 0.0, y = 0.0, k = 0.0;

  SwapController() {
    _dex = Dex(address: dexAddress, client: controller.client.value);
    _aptRouter =
        APTRouter(address: routerAddress, client: controller.client.value);
  }

  // Actionables
  Future<void> swap() async {
    print(
        "Before the actual swap - print EVERYTHING: \n tknAAddr - $address1.value | tknBAddr = $address2.value \n tknAAmount - $amount1.value | tknBAmount - $amount2.value");
      
    EthereumAddress tokenAAddress = EthereumAddress.fromHex("$address1");
    EthereumAddress tokenBAddress = EthereumAddress.fromHex("$address2");
    BigInt tokenAAmount = BigInt.from(amount1.value);
    BigInt tokenBAmount = BigInt.from(amount2.value);
    ERC20 tokenA =
        ERC20(address: tokenAAddress, client: controller.client.value);
    ERC20 tokenB =
        ERC20(address: tokenBAddress, client: controller.client.value);

    List<EthereumAddress> path = [tokenAAddress, tokenBAddress];
    EthereumAddress to = await controller.credentials.extractAddress();
    String txString = "";

    try {
      txString = await tokenA.approve(dexAddress, tokenAAmount,
          credentials: controller.credentials);
      txString = await tokenB.approve(dexAddress, tokenBAmount,
          credentials: controller.credentials);
      txString = await _aptRouter.swapExactTokensForTokens(
          tokenAAmount, amountOutMin, path, to, deadline.value,
          credentials: controller.credentials);
    } catch (e) {
      print(
          "[Console] Unable to swap [$tokenAAddress, $tokenBAddress] tokens \n $e");
    }
    controller.updateTxString(txString);
  }

  Future<void> createPair() async {
    String txString;
    EthereumAddress tknA = EthereumAddress.fromHex("$address1");
    EthereumAddress tknB = EthereumAddress.fromHex("$address2");
    try {
      txString = await _dex.createPair(tknA, tknB,
          credentials: controller.credentials);
    } catch (e) {
      print("[Console] Unable to create pair /n $e");
      txString = await _dex.createPair(tknA, tknB,
          credentials: controller.credentials);
    }

    controller.updateTxString(txString);
  }

  Future<void> swapforAX() async {
    EthereumAddress tknA = EthereumAddress.fromHex("$address1.value");
    BigInt amountIn = BigInt.from(amount1.value);
    EthereumAddress to = await controller.credentials.extractAddress();
    List<EthereumAddress> path = [tknA, AXTAddress];
    String txString = await _aptRouter.swapExactTokensForAVAX(
        amountIn, BigInt.one, path, to, deadline.value,
        credentials: controller.credentials);
    controller.updateTxString(txString);
  }

  Future<void> swapFromAX() async {
    EthereumAddress tknA = EthereumAddress.fromHex("$address1.value");
    BigInt amountIn = BigInt.from(amount1.value);

    List<EthereumAddress> path = [tknA, AXTAddress];
    EthereumAddress to = await controller.credentials.extractAddress();
    String txString = await _aptRouter.swapExactAVAXForTokens(
        amountOutMin, path, to, deadline.value,
        credentials: controller.credentials);
    controller.updateTxString(txString);
  }

  void updateAmount1(double newAmount) {
    amount1.value = newAmount;
    update();
  }

  void updateAmount2(double newAmount) {
    amount2.value = newAmount;
    update();
  }

  void updateAddress1(String newAddress) {
    address1.value = newAddress;
    update();
  }

  void updateAddress2(String newAddress) {
    address2.value = newAddress;
    update();
  }

  void updatePrice() {
    price.value = amount1.value * amount2.value;
    update();
  }

  void updateToken1(Token tkn1) {
    activeTkn1.value = tkn1;
    update();
  }

  void updateToken2(Token tkn2) {
    activeTkn2.value = tkn2;
    update();
  }
}