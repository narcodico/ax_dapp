import 'package:ax_dapp/service/athleteModels/mlb/MLBPAthleteStats.dart';
import 'package:ax_dapp/util/chart/extensions/graphData.dart';
import 'package:equatable/equatable.dart';
import 'package:ax_dapp/util/BlocStatus.dart';
import 'package:fl_chart/fl_chart.dart';

class AthletePageState extends Equatable {
  final List<GraphData> stats;
  final BlocStatus status;
  AthletePageState({
    required this.stats,
    required this.status,
  });

  // const AthletePageState(
  //     {this.status = BlocStatus.initial, MLBAthleteStats? stats})
  //     : this.stats = stats ??
  //           const MLBAthleteStats(
  //               id: 0, name: "", team: "", position: "", statHistory: []);

  factory AthletePageState.initial() {
    return AthletePageState(stats: [], status: BlocStatus.initial);
  }

  AthletePageState copyWith({
    List<GraphData>? stats,
    BlocStatus? status,
  }) {
    return AthletePageState(
      stats: stats ?? this.stats,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status, stats];

  @override
  String toString() => 'AthletePageState(stats: $stats, status: $status)';
}
