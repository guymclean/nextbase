import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nextbase/models/chart_data.dart';

class JourneyAccelerationChart extends StatelessWidget {
  final List<ChartData> data;

  JourneyAccelerationChart(this.data);

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

  List<charts.Series<ChartData, DateTime>> _createDataSet() {
    return [
      _createSeries(
        label: 'xAcc',
        dataToAcceleration: (ChartData data) => data.xAcc,
        color: Colors.red,
      ),
      _createSeries(
        label: 'yAcc',
        dataToAcceleration: (ChartData data) => data.yAcc,
        color: Colors.blue,
      ),
      _createSeries(
        label: 'zAcc',
        dataToAcceleration: (ChartData data) => data.zAcc,
        color: Colors.yellow,
      ),
    ];
  }

  charts.Series<ChartData, DateTime> _createSeries({
    @required label,
    @required num Function(ChartData) dataToAcceleration,
    @required Color color,
  }) {
    return charts.Series<ChartData, DateTime>(
      id: label,
      domainFn: (ChartData data, _) => data.datetime,
      measureFn: (ChartData data, _) => dataToAcceleration(data),
      data: data,
      colorFn: (_, __) => charts.ColorUtil.fromDartColor(color),
      strokeWidthPxFn: (_, __) => 1,
    );
  }
}
