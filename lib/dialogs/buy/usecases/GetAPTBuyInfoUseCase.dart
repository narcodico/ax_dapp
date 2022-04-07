import 'package:ax_dapp/service/Api/SubGraphQueries.dart';
import 'package:ax_dapp/service/BlockchainModels/AptBuyInfo.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GetAPTBuyInfoUseCase {
  final GraphQLClient _client;

  GetAPTBuyInfoUseCase(this._client);

  Future<AptBuyInfo?> fetchAptBuyInfo(String tokenAddress) async {

   QueryResult result =  await _client.query(
     QueryOptions(document: gql(getAptPurchaseInfo(tokenAddress)))
   );
   if(!result.hasException){
     final data = result.data;
     if(data != null){
       List pairs = data["pairs"];
        return AptBuyInfo(pairs.first["reserve0"], pairs.first["reserve1"]);
      }
     return null;
   }else{
     return null;
   }
  }
}