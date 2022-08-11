// ignore_for_file: avoid_dynamic_calls

import 'package:ax_dapp/service/controller/controller.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  late String axAddress;
  RxString axPrice = '-'.obs;
  RxString axCirculation = '-'.obs;
  RxString axTotalSupply = '-'.obs;
  RxString yourBalance = '-'.obs;
  RxDouble tokenPrice = 0.0.obs;
  Controller controller = Get.find();
}
