import 'package:ax_dapp/service/athleteModels/MLBAthlete.dart';
import 'package:ax_dapp/service/athlete_api/MLBAthleteAPI.dart';
import 'package:ax_dapp/service/athlete_api/models/PlayerIds.dart';

class MLBRepo {
  final MLBAthleteAPI _api;

  MLBRepo(this._api,);

  Future<List<MLBAthlete>> getAllPlayers() async {
    return _api.getAllPlayers();
  }

  Future<List<MLBAthlete>> getPlayersById(List<int> ids) async {
    return _api.getPlayersById(PlayerIds(ids));
  }
}
