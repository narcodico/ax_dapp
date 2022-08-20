@TestOn('browser')
import 'package:ax_dapp/my_liquidity/my_liquidity.dart';
import 'package:ax_dapp/repositories/usecases/get_all_liquidity_info_use_case.dart';
import 'package:config_repository/config_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wallet_repository/wallet_repository.dart';

import 'my_liquidity_bloc_test.mocks.dart';

@GenerateMocks([GetAllLiquidityInfoUseCase, WalletRepository, ConfigRepository])
void main() {
  late GetAllLiquidityInfoUseCase mockRepoUseCase;
  late WalletRepository mockWalletRepository;
  late ConfigRepository mockConfigRepository;

  late MyLiquidityBloc subject;

  const testWalletAddress = 'testWalletAddress';
  const testWallet = Wallet(
    status: WalletStatus.connected,
    address: testWalletAddress,
    chain: EthereumChain.polygonMainnet,
  );
  final testMyLiquidityItemInfo = <LiquidityPositionInfo>[
    const LiquidityPositionInfo(
      token0Name: 'testToken0Name',
      token1Name: 'testToken1Name',
      token0Symbol: 'testToken0Symbol',
      token1Symbol: 'testToken1Symbol',
      token0Address: 'testToken0Address',
      token1Address: 'testToken1Address',
      lpTokenPairAddress: 'testLpTokenPairAddress',
      lpTokenPairBalance: 'testLpTokenPairBalance',
      token0LpAmount: 'testToken0LpAmount',
      token1LpAmount: 'testToken1LpAmount',
      shareOfPool: 'testShareOfPool',
      apy: 'testApy',
    )
  ];

  MyLiquidityBloc createSubject() => MyLiquidityBloc(
        walletRepository: mockWalletRepository,
        configRepository: mockConfigRepository,
        repo: mockRepoUseCase,
      );

  group('MyLiquidityBloc', () {
    setUp(() {
      mockRepoUseCase = MockGetAllLiquidityInfoUseCase();
      mockWalletRepository = MockWalletRepository();
      mockConfigRepository = MockConfigRepository();

      when(mockWalletRepository.currentWallet).thenReturn(testWallet);
      when(
        mockRepoUseCase.fetchAllLiquidityPositions(
          walletAddress: testWalletAddress,
        ),
      ).thenAnswer((_) async => Either.left(Success(testMyLiquidityItemInfo)));

      subject = createSubject();
    });

    test('Should update MyLiquidity State successfully ', () async {
      subject.add(const FetchAllLiquidityPositionsRequested());
      await expectLater(
        subject.stream,
        emitsInOrder([
          isA<MyLiquidityState>(),
          predicate<MyLiquidityState>(
            (state) => state.cards == testMyLiquidityItemInfo,
          )
        ]),
      );
    });
  });
}
