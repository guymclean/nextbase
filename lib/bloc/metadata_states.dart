import 'package:equatable/equatable.dart';
import 'package:nextbase/models/journey_snapshot.dart';

abstract class MetadataState extends Equatable {
  @override
  List<Object> get props => [];
}

class MetadataLoading extends MetadataState {}

class MetadataLoaded extends MetadataState {
  final List<JourneySnapshot> snapshots;

  MetadataLoaded(this.snapshots);

  @override
  List<Object> get props => [snapshots];
}

class MetadataError extends MetadataState {
  final String message;

  MetadataError(this.message);

  @override
  List<Object> get props => [message];
}
