import 'package:ax_dapp/blocs/scout/AthleteScoutModel.dart';
import 'package:ax_dapp/repositories/MlbRepo.dart';
import 'package:ax_dapp/service/SupportedAthletes/SupportedMLBAthletes.dart';
import 'package:ax_dapp/service/athleteModels/MLBAthlete.dart';

class ScoutPageBloc {
  final MLBRepo _mlbRepo;

  ScoutPageBloc(this._mlbRepo);

  Future<List<MLBAthlete>> _fetchSupportedMLBAthletes() async {
    final supportedAthletes = SupportedMLBAthletes().getSupportedAthletesList();
    return _mlbRepo.getPlayersById(supportedAthletes);
  }

  Future<List<AthleteScoutModel>> getAthleteScoutData() async {
    final List<AthleteScoutModel> scoutData = [];
    final List<MLBAthlete> mlbAthletes = await _fetchSupportedMLBAthletes();
    //     final List<NFLAthlete> nflAthletes = await _fetchSupportedMLBAthletes();

    mlbAthletes.forEach((athlete) {
      scoutData.add(AthleteScoutModel(athlete.id, athlete.name,
          athlete.position, athlete.team, athlete.price, Sport.MLB));
    });

    return scoutData;
  }
}