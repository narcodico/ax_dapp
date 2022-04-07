import 'package:ax_dapp/service/BlockchainModels/AptBuyInfo.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SubGraphRepo {
  final GraphQLClient _client;

  SubGraphRepo(this._client);

  Future<AptBuyInfo> getAptBuyInfo() async {
    throw UnimplementedError();
  }
}