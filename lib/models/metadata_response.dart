import 'package:flutter/foundation.dart';
import 'package:nextbase/models/journey_snapshot.dart';

class MetadataResponse {
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
}
