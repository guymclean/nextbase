import 'package:flutter/foundation.dart';

class JourneySnapshot {
  final num bearing;
  final DateTime datetime;
  final num distanceFromLast;
  final String gpsStatus;
  final num lat;
  final num lon;
  final num speed;
  final num xAcc;
  final num yAcc;
  final num zAcc;

  const JourneySnapshot({
    @required this.bearing,
    @required this.datetime,
    @required this.distanceFromLast,
    @required this.gpsStatus,
    @required this.lat,
    @required this.lon,
    @required this.speed,
    @required this.xAcc,
    @required this.yAcc,
    @required this.zAcc,
  });

  factory JourneySnapshot.fromMap(Map<String, dynamic> map) {
    return JourneySnapshot(
      bearing: map['bearing'] as num,
      datetime: DateTime.parse(map['datetime']),
      distanceFromLast: map['distanceFromLast'] as num,
      gpsStatus: map['gpsStatus'] as String,
      lat: map['lat'] as num,
      lon: map['lon'] as num,
      speed: map['speed'] as num,
      xAcc: map['xAcc'] as num,
      yAcc: map['yAcc'] as num,
      zAcc: map['zAcc'] as num,
    );
  }
}
