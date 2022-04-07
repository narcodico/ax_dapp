import 'package:ax_dapp/contracts/StakingRewards.g.dart';
import 'package:ax_dapp/service/Controller/Controller.dart';
import 'package:web3dart/web3dart.dart';
import '../../../contracts/StakingRewards.g.dart';
import 'package:get/get.dart';
import 'package:web3dart/credentials.dart';

class FarmController extends GetxController {
  Controller controller = Get.find();
  late StakingRewards _stakingRewards;
  var amount1 = 0.0.obs, amount2 = 0.0.obs, stakedBalance = 0.0.obs;

  final EthereumAddress farmAddress = EthereumAddress.fromHex("hex");
  FarmController();

  void stake() async {
    // _stakingRewards = StakingRewards(address: address, client: client);
    final credentials = controller.credentials;
    final amount = BigInt.from(amount1.value);
    _stakingRewards.stake(amount, credentials: credentials);
  }

  void claimRewards() async {
    final credentials = controller.credentials;
    String txString = await _stakingRewards.getReward(credentials: credentials);
    controller.updateTxString(txString);
  }

  void unstakeLiquidity() async {
    final amount = BigInt.from(amount1.value);
  }

  void unstakeSingleSidedFarm() async {
    final amount = BigInt.from(amount1.value);
    final credentials = controller.credentials;

    _stakingRewards.withdraw(amount, credentials: credentials);
  }

  void updateAXInSingleSidedFarm() async {
    final account = controller.publicAddress.value;
    final balance = await _stakingRewards.balanceOf(account);
    stakedBalance.value = balance.toDouble();
    update();
  }

  void updateTVL() async {
    final credentials = controller.credentials;
    _stakingRewards.getReward(credentials: credentials);
  }

  void updateAmount(double newAmount) {
    amount1.value = newAmount;
    print("Updated amount");
    update();
  }
}
