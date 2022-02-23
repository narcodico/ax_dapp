// ignore_for_file: non_constant_identifier_names

import 'package:ax_dapp/service/Controller/APT.dart';
import 'package:get/get.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';
import '../../../contracts/LongShortPair.g.dart';
import 'package:web3dart/contracts/erc20.dart';
import 'package:http/http.dart';
import '../Controller.dart';

// --> Joe burrow
// --> Jamaar chase
// --> Matthew Stafford
// --> Cooper Kupp

class LSPController extends GetxController {
  Controller controller = Get.find();
  late LongShortPair genericLSP;
  late EthereumAddress lspAdress;
  var createAmt = 0.0.obs;
  var redeemAmt = 0.0.obs;
  // Hard address listing of all Athletes

  LSPController() {
    final tokenClient =
        Web3Client("https://matic-mumbai.chainstacklabs.com", new Client());
    lspAdress =
        EthereumAddress.fromHex("0x5531370bF547F005334C88A6B6b3Fe4Fe096232e");
    genericLSP = LongShortPair(address: lspAdress, client: tokenClient);
  }

  Future<void> mint() async {
    print("Attempting to MINT LSP");
    BigInt collateralAmount = await genericLSP.collateralPerPair();
    final theCredentials = controller.credentials;
    BigInt tokensToCreate = BigInt.from(createAmt.value) *
        BigInt.from(1000000000000000000); // for small 1000000000000000000

    // approve().then((value) async {
    // });
    approve().then((value) async {
      String txString =
          await genericLSP.create(tokensToCreate, credentials: theCredentials);
      controller.updateTxString(txString); //Sends tx to controller
    });
  }

  Future<void> approve() async {
    print("collaterall amount: ${await genericLSP.collateralPerPair()}");
    BigInt transferAmount = BigInt.parse("1000000000000000000000");
    BigInt amount = BigInt.from(createAmt.value) * transferAmount;
    print("[Console] Inside approve()");
    EthereumAddress axtaddress =
        EthereumAddress.fromHex("0x76d9a6e4cdefc840a47069b71824ad8ff4819e85");
    final tokenClient =
        Web3Client("https://matic-mumbai.chainstacklabs.com", Client());
    Erc20 axt = Erc20(address: axtaddress, client: tokenClient);
    try {
      print("[Console] Created a token variable.");
    } catch (error) {
      print(error);
    }
    EthereumAddress spender =
        EthereumAddress.fromHex("0x5531370bF547F005334C88A6B6b3Fe4Fe096232e");
    String txString = await axt.approve(lspAdress, amount,
        credentials: controller.credentials);
  }

  Future<void> redeem() async {
    final theCredentials = controller.credentials;
    BigInt tokensToRedeem = BigInt.from(redeemAmt.value);
    genericLSP.redeem(tokensToRedeem, credentials: theCredentials);
  }

  void updateCreateAmt(double newAmount) {
    createAmt.value = newAmount;
    print("creating lsps with collateral: $newAmount");
    update();
  }

  void updateRedeemAmt(double newAmount) {
    redeemAmt.value = newAmount;
    print("redeeming lsps with collateral: $newAmount");
    update();
  }

  Future<void> updateCollateralAmount() async {}
}
