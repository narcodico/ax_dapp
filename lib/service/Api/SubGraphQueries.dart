
String getAptPurchaseInfo(String tokenId) => """
query pairs(where: {token0: "$tokenId", 
    token1: "0x76d9a6e4cdefc840a47069b71824ad8ff4819e85"}) {
    reserve0 
    reserve1 
  }
""";