import 'package:config_repository/config_repository.dart';
import 'package:shared/shared.dart';
import 'package:tokens_repository/tokens_repository.dart';
import 'package:use_cases/src/stream_app_data_changes/models/models.dart';
import 'package:wallet_repository/wallet_repository.dart';

/// {@template stream_app_data_changes_use_case}
/// Use case that stream changes to app data.
/// {@endtemplate}
class StreamAppDataChangesUseCase {
  /// {@macro stream_app_data_changes_use_case}
  StreamAppDataChangesUseCase({
    required WalletRepository walletRepository,
    required TokensRepository tokensRepository,
    required ConfigRepository configRepository,
  })  : _walletRepository = walletRepository,
        _tokensRepository = tokensRepository,
        _configRepository = configRepository;

  final WalletRepository _walletRepository;
  final TokensRepository _tokensRepository;
  final ConfigRepository _configRepository;

  /// Allows listening to when all app data has finished changing as a result
  /// of chain switching.
  ///
  /// This is particularly useful when we need to make sure the wallet, tokens
  /// and dependencies have finished changing before refetching information.
  Stream<AppData> get appDataChanges =>
      ZipStream.zip3<Wallet, List<Token>, void, AppData>(
        _walletRepository.walletChanges,
        _tokensRepository.tokensChanges,
        _configRepository.dependenciesChanges,
        (wallet, tokens, _) => AppData(
          chain: wallet.chain,
          walletStatus: wallet.status,
          walletAddress: wallet.address,
          tokens: tokens,
        ),
      );
}
