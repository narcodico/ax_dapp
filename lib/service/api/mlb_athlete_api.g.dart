// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mlb_athlete_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _MLBAthleteAPI implements MLBAthleteAPI {
  _MLBAthleteAPI(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://db.athletex.io/mlb';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<MLBAthlete>> getAllPlayers() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<MLBAthlete>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/players',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => MLBAthlete.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<MLBAthlete>> getPlayersById(playerIds) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(playerIds.toJson());
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<MLBAthlete>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/players',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => MLBAthlete.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<MLBAthlete> getPlayer(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MLBAthlete>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/players/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MLBAthlete.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<MLBAthlete>> getPlayersByTeam(team) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'team': team};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<MLBAthlete>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/players',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => MLBAthlete.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<MLBAthlete>> getPlayersByPosition(position) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'position': position};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<MLBAthlete>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/players',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => MLBAthlete.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<MLBAthlete>> getPlayersByTeamAtPosition(team, position) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'team': team,
      r'position': position
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<MLBAthlete>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/players',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => MLBAthlete.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<MLBAthleteStats> getPlayerHistory(id, from, until) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'from': from, r'until': until};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MLBAthleteStats>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/players/${id}/history',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MLBAthleteStats.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<MLBAthleteStats>> getPlayersHistory(
      playerIds, from, until) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'from': from, r'until': until};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(playerIds.toJson());
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<MLBAthleteStats>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/players/history',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => MLBAthleteStats.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
