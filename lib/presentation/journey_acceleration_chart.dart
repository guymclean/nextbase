import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nextbase/models/journey_snapshot.dart';

class JourneyAccelerationChart extends StatelessWidget {
  final List<JourneySnapshot> snapshots;

  JourneyAccelerationChart(this.snapshots);

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      _createDataSet(),
      defaultInteractions: false,
      behaviors: [
        charts.SeriesLegend(
          position: charts.BehaviorPosition.inside,
          insideJustification: charts.InsideJustification.topEnd,
          horizontalFirst: false,
        )
      ],
      domainAxis: charts.DateTimeAxisSpec(),
      primaryMeasureAxis: charts.NumericAxisSpec(),
      animate: false,
      dateTimeFactory: charts.LocalDateTimeFactory(),
    );
  }

  List<charts.Series<JourneySnapshot, DateTime>> _createDataSet() {
    return [
      _createSeries(
        label: 'xAcc',
        snapshotToAcceleration: (JourneySnapshot snapshot) => snapshot.xAcc,
        color: Colors.red,
      ),
      _createSeries(
        label: 'yAcc',
        snapshotToAcceleration: (JourneySnapshot snapshot) => snapshot.yAcc,
        color: Colors.blue,
      ),
      _createSeries(
        label: 'zAcc',
        snapshotToAcceleration: (JourneySnapshot snapshot) => snapshot.zAcc,
        color: Colors.yellow,
      ),
    ];
  }

  charts.Series<JourneySnapshot, DateTime> _createSeries({
    @required label,
    @required num Function(JourneySnapshot) snapshotToAcceleration,
    @required Color color,
  }) {
    return charts.Series<JourneySnapshot, DateTime>(
      id: label,
      domainFn: (JourneySnapshot snapshot, _) => snapshot.datetime,
      measureFn: (JourneySnapshot snapshot, _) =>
          snapshotToAcceleration(snapshot),
      data: snapshots,
      colorFn: (_, __) => charts.ColorUtil.fromDartColor(color),
      strokeWidthPxFn: (_, __) => 1,
    );
  }
}
