import 'package:ax_dapp/service/athlete_api/NFLAthleteAPI.dart';
import 'package:ax_dapp/service/athleteModels/NFLAthlete.dart';

class NFLRepo {
  final NFLAthleteAPI _api;
  static final int mStaffordId = 9038;
  static final int jChaseId = 22564;
  static final int jBurrowId = 21693;
  static final int cKuppId = 18882;

  static final Map<String, List<int>> athleteIdDict = {
    "ids": [mStaffordId, jChaseId, jBurrowId, cKuppId],
  };

  NFLRepo(this._api);

  Future<List<NFLAthlete>> getAllPlayers() async {
    return _api.getAllPlayers();
  }

  Future<List<NFLAthlete>> getPlayersById() async {
    return _api.getPlayersById(athleteIdDict);
  }
}
