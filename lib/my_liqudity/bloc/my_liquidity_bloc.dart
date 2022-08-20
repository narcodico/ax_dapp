import 'dart:async';

import 'package:ax_dapp/my_liqudity/models/models.dart';
import 'package:ax_dapp/repositories/usecases/get_all_liquidity_info_use_case.dart';
import 'package:ax_dapp/util/bloc_status.dart';
import 'package:config_repository/config_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_repository/wallet_repository.dart';

part 'my_liquidity_event.dart';
part 'my_liquidity_state.dart';

class MyLiquidityBloc extends Bloc<MyLiquidityEvent, MyLiquidityState> {
  MyLiquidityBloc({
    required WalletRepository walletRepository,
    required ConfigRepository configRepository,
    required this.repo,
  })  : _walletRepository = walletRepository,
        _configRepository = configRepository,
        super(MyLiquidityState.initial()) {
    on<WatchDependenciesChangesStarted>(_onWatchDependenciesChangesStarted);
    on<FetchAllLiquidityPositionsRequested>(
      _onFetchAllLiquidityPositionsRequested,
    );
    on<SearchTermChanged>(_onSearchTermChanged);

    add(const FetchAllLiquidityPositionsRequested());
  }

  final WalletRepository _walletRepository;
  final ConfigRepository _configRepository;
  final GetAllLiquidityInfoUseCase repo;

  FutureOr<void> _onWatchDependenciesChangesStarted(
    WatchDependenciesChangesStarted event,
    Emitter<MyLiquidityState> emit,
  ) async {
    await emit.onEach<void>(
      _configRepository.dependenciesChanges,
      onData: (_) => add(const FetchAllLiquidityPositionsRequested()),
    );
  }

  Future<void> _onFetchAllLiquidityPositionsRequested(
    FetchAllLiquidityPositionsRequested event,
    Emitter<MyLiquidityState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));
    final currentWallet = _walletRepository.currentWallet;
    final isWalletConnected = _walletRepository.currentWallet.isConnected;
    try {
      if (isWalletConnected) {
        final response = await repo.fetchAllLiquidityPositions(
          walletAddress: currentWallet.address,
        );
        final isSuccess = response.isLeft();
        if (isSuccess) {
          final liquidityPositionsList =
              response.getLeft().toNullable()!.liquidityPositionsList;
          if (liquidityPositionsList != null) {
            emit(
              state.copyWith(
                cards: liquidityPositionsList,
                filteredCards: liquidityPositionsList,
                status: BlocStatus.success,
              ),
            );
          } else {
            emit(state.copyWith(status: BlocStatus.noData));
          }
        } else {
          // TODO(anyone): Create User facing error messages
          emit(state.copyWith(status: BlocStatus.error));
        }
      } else {
        emit(state.copyWith(status: BlocStatus.noWallet));
      }
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.error));
    }
  }

  Future<void> _onSearchTermChanged(
    SearchTermChanged event,
    Emitter<MyLiquidityState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));
    final parsedInput = event.searchTerm.trim().toLowerCase();
    final filteredList = state.cards
        .where(
          (liquidityPosition) =>
              liquidityPosition.token0Name
                  .toLowerCase()
                  .contains(parsedInput) ||
              liquidityPosition.token1Name
                  .toLowerCase()
                  .contains(parsedInput) ||
              liquidityPosition.token0Symbol
                  .toLowerCase()
                  .contains(parsedInput) ||
              liquidityPosition.token1Symbol
                  .toLowerCase()
                  .contains(parsedInput),
        )
        .toList();
    emit(
      state.copyWith(
        status: BlocStatus.success,
        filteredCards: filteredList,
      ),
    );
  }
}
