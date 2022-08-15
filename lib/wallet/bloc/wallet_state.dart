part of 'wallet_bloc.dart';

enum WalletStatus {
  disconnected,
  connected,
  unsupported;

  factory WalletStatus.fromChain(EthereumChain chain) {
    switch (chain) {
      case EthereumChain.none:
        return WalletStatus.disconnected;
      case EthereumChain.unsupported:
        return WalletStatus.unsupported;
      case EthereumChain.polygonMainnet:
      case EthereumChain.polygonTestnet:
      case EthereumChain.sxMainnet:
      case EthereumChain.sxTestnet:
        return WalletStatus.connected;
    }
  }
}

class WalletState extends Equatable {
  const WalletState({
    required this.status,
    required this.chain,
    this.walletAddress = kEmptyAddress,
    this.axData = AxData.empty,
    this.gasPrice = 0,
    this.failure = WalletFailure.none,
  });

  final WalletStatus status;
  final EthereumChain chain;
  final String walletAddress;
  final AxData axData;
  final double gasPrice;
  final WalletFailure failure;

  @override
  List<Object> get props => [status, chain, walletAddress, gasPrice, failure];

  WalletState copyWith({
    WalletStatus? status,
    EthereumChain? chain,
    String? walletAddress,
    AxData? axData,
    double? gasPrice,
    WalletFailure? failure,
  }) {
    return WalletState(
      status: status ?? this.status,
      chain: chain ?? this.chain,
      walletAddress: walletAddress ?? this.walletAddress,
      axData: axData ?? this.axData,
      gasPrice: gasPrice ?? this.gasPrice,
      failure: failure ?? this.failure,
    );
  }
}

extension WalletStateX on WalletState {
  bool get isWalletConnected => status == WalletStatus.connected;
  bool get isWalletUnsupported => status == WalletStatus.unsupported;
  bool get isWalletUnavailable => failure is WalletUnavailableFailure;
  bool get hasFailure => failure != WalletFailure.none;

  String get formattedWalletAddress => "'$walletAddress'";
}
