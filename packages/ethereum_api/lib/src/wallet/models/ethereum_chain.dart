import 'package:ethereum_api/src/config/config.dart';
import 'package:ethereum_api/src/tokens/tokens.dart';
import 'package:ethereum_api/src/wallet/models/ethereum_currency.dart';
import 'package:shared/shared.dart';

// TODO(Pearlson): confirm info
/// {@template ethereum_chain}
/// Represents an `Ethereum` blockchain network.
/// {@endtemplate}
enum EthereumChain {
  /// Represents no network.
  none(
    chainId: 0,
    chainName: '__none__',
    currency: EthereumCurrency.none,
    rpcUrls: [],
    blockExplorerUrls: [],
  ),

  /// Represents an unsupported network.
  unsupported(
    chainId: -1,
    chainName: '__unsupported__',
    currency: EthereumCurrency.none,
    rpcUrls: [],
    blockExplorerUrls: [],
  ),

  /// Polygon main network.
  polygonMainnet(
    chainId: 137,
    chainName: 'Polygon Mainnet',
    currency: EthereumCurrency.matic,
    rpcUrls: ['https://rpc-mainnet.matic.quiknode.pro'],
    blockExplorerUrls: ['https://polygonscan.com/'],
  ),

  /// Polygon test network.
  polygonTestnet(
    chainId: 80001,
    chainName: 'Polygon Testnet',
    currency: EthereumCurrency.matic,
    rpcUrls: ['https://matic-mumbai.chainstacklabs.com/'],
    blockExplorerUrls: ['https://polygonscan.com/'],
  ),

  /// SX main network.
  sxMainnet(
    chainId: 416,
    chainName: 'SX Mainnet',
    currency: EthereumCurrency.sx,
    rpcUrls: ['https://rpc.sx.technology'],
    blockExplorerUrls: ['https://explorer.sx.technology/'],
  ),

  /// SX test network.
  sxTestnet(
    chainId: 647,
    chainName: 'SX Testnet',
    currency: EthereumCurrency.sx,
    rpcUrls: ['https://rpc.toronto.sx.technology'],
    blockExplorerUrls: ['https://explorer.toronto.sx.technology/'],
  );

  /// {@macro ethereum_chain}
  const EthereumChain({
    required this.chainId,
    required this.chainName,
    required this.currency,
    required this.rpcUrls,
    this.blockExplorerUrls,
  });

  /// Factory constructor that allows creating an `EthereumChain` from a given
  /// [chainId]. If the [chainId] is not supported then it will return an
  /// [EthereumChain.unsupported].
  factory EthereumChain.fromChainId(int chainId) =>
      EthereumChain.values.firstWhere(
        (chain) => chain.chainId == chainId,
        orElse: () => EthereumChain.unsupported,
      );

  /// Uniquely identifies an `Ethereum` chain.
  final int chainId;

  /// The chain's name.
  final String chainName;

  /// Holds data about the native currency.
  final EthereumCurrency currency;

  /// List of RPC urls used by this [chainId].
  final List<String> rpcUrls;

  /// List of block explorer urls used by this [chainId].
  final List<String>? blockExplorerUrls;

  /// Returns a list of supported [EthereumChain]s.
  static List<EthereumChain> get supportedValues =>
      values.where((chain) => chain.isSupported).toList();
}

/// [EthereumChain] extensions.
extension ChainX on EthereumChain {
  /// Returns whether this [EthereumChain] is supported.
  bool get isSupported =>
      this != EthereumChain.none && this != EthereumChain.unsupported;
}

/// [EthereumChain] configuration.
extension ChainConfigX on EthereumChain {
  /// Returns the RPC URL used to initialize a [Web3Client].
  String get rpcUrl => rpcUrls.firstOrNull ?? '';

  /// Generates a list of all available [Token]s for this [EthereumChain].
  List<Token> createTokens() => [
        Token.ax(this),
        Token.sx(this),
        Token.matic(this),
        Token.weth(this),
        Token.usdc(this),
        ...createApts(),
      ];

  /// Generates the list of [Apt]'s for this [EthereumChain]. Composed based on
  /// a list of [AptConfig]s.
  List<Token> createApts() => AptConfig.values
      .expand(
        (aptConfig) => [
          Token.longAp(this, aptConfig: aptConfig),
          Token.shortAp(this, aptConfig: aptConfig),
        ],
      )
      .toList();
}
