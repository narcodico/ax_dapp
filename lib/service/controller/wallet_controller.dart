// ignore_for_file: avoid_dynamic_calls

import 'package:ax_dapp/service/controller/controller.dart';
import 'package:ax_dapp/util/user_input_info.dart';
import 'package:erc20/erc20.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3dart/web3dart.dart';

class WalletController extends GetxController {
  late String axAddress;
  RxString axPrice = '-'.obs;
  RxString axCirculation = '-'.obs;
  RxString axTotalSupply = '-'.obs;
  RxString yourBalance = '-'.obs;
  RxDouble tokenPrice = 0.0.obs;
  Controller controller = Get.find();

  Future<UserInputInfo> getTokenBalanceAsInfo(
    String tokenAddress,
    int tokenDecimals,
  ) async {
    final walletAddress = controller.publicAddress.value;
    String? rpcUrl;
    if (Controller.supportedChains.containsKey(controller.networkID.value)) {
      rpcUrl = Controller.supportedChains[controller.networkID.value];
    } else {
      throw ArgumentError('Unsupported RPC url');
    }
    final rpcClient = Web3Client(rpcUrl!, Client());
    final token = ERC20(
      address: EthereumAddress.fromHex(tokenAddress),
      client: rpcClient,
    );
    var rawAmount = BigInt.zero;
    try {
      rawAmount = await token.balanceOf(walletAddress);
    } catch (_) {}
    update();
    final balance = UserInputInfo.fromBalance(
      rawAmount: rawAmount,
      decimals: tokenDecimals,
    );
    return balance;
  }

  void buyAX() {
    // TODO(KevinKamto): Update this when we need sushiswap connection
    // String axEth =
    //     "https://app.sushi.com/swap?inputCurrency=0x5617604ba0a30e0ff1d2163ab94e50d8b6d0b0df&outputCurrency=0x7ceb23fd6bc0add59e62ac25578270cff1b9f619";
    const axEthUniswap = 'https://app.uniswap.org/#/swap?chain=polygon';

    launchUrl(Uri.parse(axEthUniswap));
  }
}
