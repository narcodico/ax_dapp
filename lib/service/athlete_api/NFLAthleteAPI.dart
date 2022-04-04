import 'package:ax_dapp/service/athleteModels/NFLAthlete.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
part 'NFLAthleteAPI.g.dart';

@RestApi(baseUrl: "https://db.athletex.io/nfl")
abstract class NFLAthleteAPI {
  factory NFLAthleteAPI(Dio dio, {String baseUrl}) = _NFLAthleteAPI;

  @GET("/players")
  Future<List<NFLAthlete>> getAllPlayers();

  @POST("/players")
  Future<List<NFLAthlete>> getPlayersById(
      @Body() Map<String, List<int>> idsDict);
}
