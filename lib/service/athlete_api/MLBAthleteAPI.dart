import 'package:ax_dapp/service/athleteModels/MLBAthlete.dart';
import 'package:ax_dapp/service/athlete_api/models/PlayerIds.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
part 'MLBAthleteAPI.g.dart';

@RestApi(baseUrl: "https://db.athletex.io/mlb")
abstract class MLBAthleteAPI {
  factory MLBAthleteAPI(Dio dio, {String baseUrl}) = _MLBAthleteAPI;

  @GET("/players")
  Future<List<MLBAthlete>> getAllPlayers();

  @POST("/players")
  Future<List<MLBAthlete>> getPlayersById(
      @Body() PlayerIds playerIds);
}
