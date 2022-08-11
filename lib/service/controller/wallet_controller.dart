// ignore_for_file: avoid_dynamic_calls

import 'package:ax_dapp/service/controller/controller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class WalletController extends GetxController {
  late String axAddress;
  RxString axPrice = '-'.obs;
  RxString axCirculation = '-'.obs;
  RxString axTotalSupply = '-'.obs;
  RxString yourBalance = '-'.obs;
  RxDouble tokenPrice = 0.0.obs;
  Controller controller = Get.find();

  void buyAX() {
    // TODO(KevinKamto): Update this when we need sushiswap connection
    // String axEth =
    //     "https://app.sushi.com/swap?inputCurrency=0x5617604ba0a30e0ff1d2163ab94e50d8b6d0b0df&outputCurrency=0x7ceb23fd6bc0add59e62ac25578270cff1b9f619";
    const axEthUniswap = 'https://app.uniswap.org/#/swap?chain=polygon';

    launchUrl(Uri.parse(axEthUniswap));
  }
}
