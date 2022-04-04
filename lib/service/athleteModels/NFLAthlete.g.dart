// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NFLAthlete.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NFLAthlete _$NFLAthleteFromJson(Map<String, dynamic> json) => NFLAthlete(
      name: json['name'] as String,
      id: json['id'] as int,
      team: json['team'] as String,
      position: json['position'] as String,
      passingYards: (json['passingYards'] as num).toDouble(),
      passingTouchDowns: (json['passingTouchDowns'] as num).toDouble(),
      reception: (json['reception'] as num).toDouble(),
      receiveYards: (json['receiveYards'] as num).toDouble(),
      receiveTouch: (json['receiveTouch'] as num).toDouble(),
      rushingYards: (json['rushingYards'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      timeStamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$NFLAthleteToJson(NFLAthlete instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'team': instance.team,
      'position': instance.position,
      'passingYards': instance.passingYards,
      'passingTouchDowns': instance.passingTouchDowns,
      'reception': instance.reception,
      'receiveYards': instance.receiveYards,
      'receiveTouch': instance.receiveTouch,
      'rushingYards': instance.rushingYards,
      'price': instance.price,
      'timestamp': instance.timeStamp,
    };
