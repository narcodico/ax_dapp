// ignore_for_file: avoid_dynamic_calls

import 'package:ax_dapp/pages/scout/models/athlete_scout_model.dart';
import 'package:ax_dapp/pages/scout/models/market_model.dart';
import 'package:ax_dapp/pages/scout/models/sports_model/mlb_athlete_scout_model.dart';
import 'package:ax_dapp/pages/scout/models/sports_model/nfl_athlete_scout_model.dart';
import 'package:ax_dapp/repositories/sports_repo.dart';
import 'package:ax_dapp/repositories/subgraph/sub_graph_repo.dart';
import 'package:ax_dapp/service/athlete_models/mlb/mlb_athlete.dart';
import 'package:ax_dapp/service/athlete_models/nfl/nfl_athlete.dart';
import 'package:ax_dapp/service/athlete_models/sport_athlete.dart';
import 'package:ax_dapp/service/blockchain_models/token_pair.dart';
import 'package:tokens_repository/tokens_repository.dart';

class GetScoutAthletesDataUseCase {
  GetScoutAthletesDataUseCase({
    required TokensRepository tokensRepository,
    required this.graphRepo,
    required List<SportsRepo<SportAthlete>> sportsRepos,
  }) : _tokensRepository = tokensRepository {
    for (final repo in sportsRepos) {
      _repos[repo.sport] = repo;
    }
  }

  final TokensRepository _tokensRepository;
  final SubGraphRepo graphRepo;
  final Map<SupportedSport, SportsRepo<SportAthlete>> _repos = {};

  List<TokenPair> allPairs = [];

  static const collateralizationMultiplier = 1000;
  static const collateralizationPerPair = 15;

  Future<List<AthleteScoutModel>> fetchSupportedAthletes(
    SupportedSport sportSelection,
  ) async {
    final currentAxt = _tokensRepository.currentAxt;
    allPairs = await fetchSpecificPairs(currentAxt);
    //fetching AX Price
    final axData = await _tokensRepository.getAxMarketData();
    final axPrice = axData.price ?? 0;

    /// If specific sport is selected return athletes from that specific repo
    if (sportSelection != SupportedSport.all) {
      final repo = _repos[sportSelection]!;
      final response = await repo.getSupportedPlayers();
      return _mapAthleteToScoutModel(
        response,
        repo,
        axPrice,
        scoutToken: currentAxt,
      );
    } else {
      /// if ALL sports is selected fetch for each sport and add athletes to a
      /// combined list
      final athletes = <AthleteScoutModel>[];
      final response = await Future.wait(
        _repos
            .map((key, repo) => MapEntry(key, repo.getSupportedPlayers()))
            .values,
      );
      response.asMap().forEach((key, response) {
        athletes.addAll(
          _mapAthleteToScoutModel(
            response,
            _repos.values.elementAt(key),
            axPrice,
            scoutToken: currentAxt,
          ),
        );
      });
      return athletes;
    }
  }

  Future<List<TokenPair>> fetchSpecificPairs(Token token) async {
    final response = await graphRepo.querySpecificPairs(token.ticker);
    if (!response.isLeft()) return List.empty();
    final prefixInfos =
        response.getLeft().toNullable()!['prefix'] as List<dynamic>;
    final suffixInfos =
        response.getLeft().toNullable()!['suffix'] as List<dynamic>;
    final prefixPairs = List<Map<String, dynamic>>.from(prefixInfos)
        .map(TokenPair.fromJson)
        .toList();
    final suffixPairs = List<Map<String, dynamic>>.from(suffixInfos)
        .map(TokenPair.fromJson)
        .toList();
    final pairs = [...prefixPairs, ...suffixPairs];
    return pairs;
  }

  MarketModel getMarketModel(
    String strTokenAddr,
    double bookPrice, {
    required Token scoutToken,
  }) {
    final strAXTAddr = scoutToken.address.toUpperCase();
    // Looking for a pair which has the same token name as strTokenAddr
    // (token address as uppercase)
    final index0 = allPairs.indexWhere(
      (pair) =>
          pair.token0.id.toUpperCase() == strTokenAddr &&
          pair.token1.id.toUpperCase() == strAXTAddr,
    );
    final index1 = allPairs.indexWhere(
      (pair) =>
          pair.token0.id.toUpperCase() == strAXTAddr &&
          pair.token1.id.toUpperCase() == strTokenAddr,
    );

    var marketPrice = 0.0;
    if (index0 >= 0) {
      marketPrice = double.parse(allPairs[index0].reserve1) /
          double.parse(allPairs[index0].reserve0);
    } else if (index1 >= 0) {
      marketPrice = double.parse(allPairs[index1].reserve0) /
          double.parse(allPairs[index1].reserve1);
    }

    var recentPrice = marketPrice;
    if (index0 >= 0 && allPairs[index0].pairHourData!.isNotEmpty) {
      recentPrice = double.parse(allPairs[index0].pairHourData![0].reserve1) /
          double.parse(allPairs[index0].pairHourData![0].reserve0);
    } else if (index1 >= 0 && allPairs[index1].pairHourData!.isNotEmpty) {
      recentPrice = double.parse(allPairs[index1].pairHourData![0].reserve0) /
          double.parse(allPairs[index1].pairHourData![0].reserve1);
    }
    return MarketModel(
      marketPrice: marketPrice,
      recentPrice: recentPrice,
      bookPrice: bookPrice * collateralizationMultiplier,
    );
  }

  List<AthleteScoutModel> _mapAthleteToScoutModel(
    List<SportAthlete> athletes,
    SportsRepo<SportAthlete> repo,
    double axPrice, {
    required Token scoutToken,
  }) {
    final mappedAthletes = <AthleteScoutModel>[];
    for (final athlete in athletes) {
      final aptPair = _tokensRepository.currentAptPair(athlete.id);
      final longAptAddress = aptPair.longApt.address;
      final shortAptAddress = aptPair.shortApt.address;
      final longToken =
          getMarketModel(longAptAddress, athlete.price, scoutToken: scoutToken);
      final shortToken = getMarketModel(
        shortAptAddress,
        collateralizationPerPair - athlete.price,
        scoutToken: scoutToken,
      );
      AthleteScoutModel athleteScoutModel;
      switch (repo.sport) {
        case SupportedSport.MLB:
          {
            final mlbAthlete = athlete as MLBAthlete;
            athleteScoutModel = MLBAthleteScoutModel(
              id: mlbAthlete.id,
              name: mlbAthlete.name,
              position: mlbAthlete.position,
              team: mlbAthlete.team,
              longTokenBookPrice: longToken.bookPrice,
              longTokenBookPriceUsd: longToken.bookPrice * axPrice,
              shortTokenBookPrice: shortToken.bookPrice,
              shortTokenBookPriceUsd: shortToken.bookPrice * axPrice,
              sport: repo.sport,
              time: mlbAthlete.timeStamp,
              longTokenPrice: longToken.marketPrice,
              shortTokenPrice: shortToken.marketPrice,
              longTokenPriceUsd: longToken.marketPrice * axPrice,
              shortTokenPriceUsd: shortToken.marketPrice * axPrice,
              longTokenPercentage: longToken.percentage,
              shortTokenPercentage: shortToken.percentage,
              homeRuns: mlbAthlete.homeRuns,
              strikeOuts: mlbAthlete.strikeOuts,
              saves: mlbAthlete.saves,
              stolenBases: mlbAthlete.stolenBases,
              atBats: mlbAthlete.atBats,
              weightedOnBasePercentage: mlbAthlete.weightedOnBasePercentage,
              errors: mlbAthlete.errors,
              inningsPlayed: mlbAthlete.inningsPlayed,
            );
          }
          break;
        case SupportedSport.NFL:
          {
            final nflAthlete = athlete as NFLAthlete;
            athleteScoutModel = NFLAthleteScoutModel(
              id: nflAthlete.id,
              name: nflAthlete.name,
              position: nflAthlete.position,
              team: nflAthlete.team,
              longTokenBookPrice: longToken.bookPrice,
              longTokenBookPriceUsd: longToken.bookPrice * axPrice,
              shortTokenBookPrice: shortToken.bookPrice,
              shortTokenBookPriceUsd: shortToken.bookPrice * axPrice,
              sport: repo.sport,
              time: nflAthlete.timeStamp,
              longTokenPrice: longToken.marketPrice,
              shortTokenPrice: shortToken.marketPrice,
              longTokenPercentage: longToken.percentage,
              shortTokenPercentage: shortToken.percentage,
              longTokenPriceUsd: longToken.marketPrice * axPrice,
              shortTokenPriceUsd: shortToken.marketPrice * axPrice,
              passingYards: nflAthlete.passingYards,
              passingTouchDowns: nflAthlete.passingTouchDowns,
              reception: nflAthlete.reception,
              receiveYards: nflAthlete.receiveYards,
              receiveTouch: nflAthlete.receiveTouch,
              rushingYards: nflAthlete.rushingYards,
              offensiveSnapsPlayed: nflAthlete.offensiveSnapsPlayed,
              defensiveSnapsPlayed: nflAthlete.defensiveSnapsPlayed,
            );
          }
          break;
        // ignore: no_default_cases
        default:
          {
            athleteScoutModel = AthleteScoutModel(
              id: athlete.id,
              name: athlete.name,
              position: athlete.position,
              team: athlete.team,
              longTokenBookPrice: longToken.bookPrice,
              longTokenBookPriceUsd: longToken.bookPrice * axPrice,
              shortTokenBookPrice: shortToken.bookPrice,
              shortTokenBookPriceUsd: shortToken.bookPrice * axPrice,
              // TODO(anyone): check for sport
              sport: repo.sport,
              time: athlete.timeStamp,
              longTokenPrice: longToken.marketPrice,
              shortTokenPrice: shortToken.marketPrice,
              longTokenPercentage: longToken.percentage,
              shortTokenPercentage: shortToken.percentage,
              longTokenPriceUsd: longToken.marketPrice * axPrice,
              shortTokenPriceUsd: shortToken.marketPrice * axPrice,
            );
          }
      }
      mappedAthletes.add(athleteScoutModel);
    }
    return mappedAthletes;
  }
}
