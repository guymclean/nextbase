import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ChartData extends Equatable {
  final DateTime datetime;
  final num xAcc;
  final num yAcc;
  final num zAcc;

  const ChartData({
    @required this.datetime,
    @required this.xAcc,
    @required this.yAcc,
    @required this.zAcc,
  });

  @override
  List<Object> get props => [
        datetime,
        xAcc,
        yAcc,
        zAcc,
      ];

  @override
  bool get stringify => true;
}
