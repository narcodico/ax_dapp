import 'dart:async';

import 'package:ax_dapp/app/app.dart';
import 'package:ax_dapp/bootstrap.dart';
import 'package:ax_dapp/firebase_options.dart';
import 'package:ax_dapp/repositories/mlb_repo.dart';
import 'package:ax_dapp/repositories/nfl_repo.dart';
import 'package:ax_dapp/repositories/subgraph/sub_graph_repo.dart';
import 'package:ax_dapp/repositories/subgraph/usecases/get_buy_info_use_case.dart';
import 'package:ax_dapp/repositories/subgraph/usecases/get_pair_info_use_case.dart';
import 'package:ax_dapp/repositories/subgraph/usecases/get_pool_info_use_case.dart';
import 'package:ax_dapp/repositories/subgraph/usecases/get_sell_info_use_case.dart';
import 'package:ax_dapp/repositories/subgraph/usecases/get_swap_info_use_case.dart';
import 'package:ax_dapp/repositories/usecases/get_all_liquidity_info_use_case.dart';
import 'package:ax_dapp/service/api/mlb_athlete_api.dart';
import 'package:ax_dapp/service/api/nfl_athlete_api.dart';
import 'package:cache/cache.dart';
import 'package:config_repository/config_repository.dart';
import 'package:ethereum_api/config_api.dart';
import 'package:ethereum_api/gysr_api.dart';
import 'package:ethereum_api/tokens_api.dart';
import 'package:ethereum_api/wallet_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared/shared.dart';
import 'package:tokens_repository/tokens_repository.dart';
import 'package:tracking_repository/tracking_repository.dart';
import 'package:use_cases/stream_app_data_changes_use_case.dart';
import 'package:wallet_repository/wallet_repository.dart';

void main() async {
  const defaultChain = EthereumChain.polygonMainnet;

  final dio = Dio();
  final mlbApi = MLBAthleteAPI(dio);
  final nflApi = NFLAthleteAPI(dio);

  final cache = CacheClient();

  final httpClient = http.Client();

  await initHiveForFlutter();

  final configApiClient = ConfigApiClient(
    defaultChain: defaultChain,
    httpClient: httpClient,
  );
  final configRepository = ConfigRepository(configApiClient: configApiClient);
  final appConfig = configRepository.initializeAppConfig();

  final reactiveWeb3Client = appConfig.reactiveWeb3Client;
  final walletApiClient =
      EthereumWalletApiClient(reactiveWeb3Client: reactiveWeb3Client);
  final tokensApiClient = TokensApiClient(
    defaultChain: defaultChain,
    reactiveWeb3Client: reactiveWeb3Client,
  );

  final reactiveLspClient = appConfig.reactiveLspClient;

  final gysrApiClient =
      GysrApiClient(reactiveGysrClient: appConfig.reactiveGysrGqlClient);
  final subGraphRepo =
      SubGraphRepo(reactiveDexClient: appConfig.reactiveDexGqlClient);
  final getPairInfoUseCase = GetPairInfoUseCase(subGraphRepo);
  final getSwapInfoUseCase = GetSwapInfoUseCase(getPairInfoUseCase);

  unawaited(
    bootstrap(() async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (_) => WalletRepository(
              walletApiClient: walletApiClient,
              cache: cache,
              defaultChain: defaultChain,
            ),
          ),
          RepositoryProvider(
            create: (_) => TokensRepository(
              tokensApiClient: tokensApiClient,
              reactiveLspClient: reactiveLspClient,
            ),
          ),
          RepositoryProvider.value(value: gysrApiClient),
          RepositoryProvider.value(value: subGraphRepo),
          RepositoryProvider(
            create: (context) => MLBRepo(mlbApi),
          ),
          RepositoryProvider(
            create: (context) => NFLRepo(nflApi),
          ),
          RepositoryProvider(
            create: (context) => StreamAppDataChangesUseCase(
              walletRepository: context.read<WalletRepository>(),
              tokensRepository: context.read<TokensRepository>(),
              configRepository: configRepository,
            ),
          ),
          RepositoryProvider.value(value: getPairInfoUseCase),
          RepositoryProvider.value(value: getSwapInfoUseCase),
          RepositoryProvider(
            create: (context) => GetBuyInfoUseCase(
              tokensRepository: context.read<TokensRepository>(),
              repo: getSwapInfoUseCase,
            ),
          ),
          RepositoryProvider(
            create: (context) => GetSellInfoUseCase(
              tokensRepository: context.read<TokensRepository>(),
              repo: getSwapInfoUseCase,
            ),
          ),
          RepositoryProvider(
            create: (context) => GetPoolInfoUseCase(getPairInfoUseCase),
          ),
          RepositoryProvider(
            create: (context) => GetAllLiquidityInfoUseCase(subGraphRepo),
          ),
          RepositoryProvider(
            create: (context) => TrackingRepository(),
          ),
        ],
        child: App(configRepository: configRepository),
      );
    }),
  );
}
