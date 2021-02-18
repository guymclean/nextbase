import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:nextbase/models/journey_snapshot.dart';

class MetadataResponse extends Equatable {
  final List<JourneySnapshot> data;
  final bool hasMore;

  const MetadataResponse({
    @required this.data,
    @required this.hasMore,
  });

  factory MetadataResponse.fromMap(Map<String, dynamic> map) {
    return MetadataResponse(
      data: map['data']
          .map<JourneySnapshot>((snapshot) => JourneySnapshot.fromMap(snapshot))
          .toList() as List<JourneySnapshot>,
      hasMore: map['hasMore'] as bool,
    );
  }

  @override
  List<Object> get props => [
        data,
        hasMore,
      ];

  @override
  bool get stringify => true;
}
