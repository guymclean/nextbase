import 'package:equatable/equatable.dart';
import 'package:nextbase/models/chart_data.dart';

abstract class ChartState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChartLoading extends ChartState {}

class ChartLoaded extends ChartState {
  final List<ChartData> data;

  ChartLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class ChartError extends ChartState {
  final String message;

  ChartError(this.message);

  @override
  List<Object> get props => [message];
}
