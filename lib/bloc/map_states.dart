import 'package:equatable/equatable.dart';
import 'package:nextbase/models/map_data.dart';

abstract class MapState extends Equatable {
  @override
  List<Object> get props => [];
}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final MapData data;

  MapLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class MapError extends MapState {
  final String message;

  MapError(this.message);

  @override
  List<Object> get props => [message];
}
