import 'package:json_annotation/json_annotation.dart';

part 'NFLAthlete.g.dart';

@JsonSerializable()
class NFLAthlete {
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "team")
  final String team;
  @JsonKey(name: "position")
  final String position;
  @JsonKey(name: "passingYards")
  final double passingYards;
  @JsonKey(name: "passingTouchDowns")
  final double passingTouchDowns;
  @JsonKey(name: "reception")
  final double reception;
  @JsonKey(name: "receiveYards")
  final double receiveYards;
  @JsonKey(name: "receiveTouch")
  final double receiveTouch;
  @JsonKey(name: "rushingYards")
  final double rushingYards;
  @JsonKey(name: "price")
  final double price;
  @JsonKey(name: "timestamp")
  final String timeStamp;

  const NFLAthlete({
    required this.name,
    required this.id,
    required this.team,
    required this.position,
    required this.passingYards,
    required this.passingTouchDowns,
    required this.reception,
    required this.receiveYards,
    required this.receiveTouch,
    required this.rushingYards,
    required this.price,
    required this.timeStamp,
  });

  factory NFLAthlete.fromJson(Map<String, dynamic> json) =>
      _$NFLAthleteFromJson(json);

  //Delete later, this was the previous way of fetching API data for athletes
  static NFLAthlete fromJsonStatic(json) => NFLAthlete(
        name: json['name'],
        id: json['id'],
        team: json['team'],
        position: json['position'],
        passingYards: json['passingYards'],
        passingTouchDowns: json['passingTouchDowns'],
        reception: json['reception'],
        receiveYards: json['receiveYards'],
        receiveTouch: json['receiveTouch'],
        rushingYards: json['rushingYards'],
        timeStamp: json['timestamp'],
        price: json['price'],
      );

  Map<String, dynamic> toJson() => _$NFLAthleteToJson(this);
}
