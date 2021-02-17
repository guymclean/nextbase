import 'package:flutter/foundation.dart';

class ChartData {
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
}
