import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nextbase/bloc/chart_states.dart';
import 'package:nextbase/data/metadata_repo.dart';
import 'package:nextbase/models/chart_data.dart';
import 'package:nextbase/models/journey_snapshot.dart';

class ChartCubit extends Cubit<ChartState> {
  final MetadataRepo _metadataRepo;

  ChartCubit({
    @required MetadataRepo metadataRepo,
  })  : _metadataRepo = metadataRepo,
        super(ChartLoading()) {
    _loadJourneyMetadata();
  }

  _loadJourneyMetadata() async {
    try {
      final List<JourneySnapshot> snapshots =
          await _metadataRepo.journeyMetadata;
      final List<ChartData> chartData = snapshots
          .map((JourneySnapshot snapshot) => ChartData(
                datetime: snapshot.datetime,
                xAcc: snapshot.xAcc,
                yAcc: snapshot.yAcc,
                zAcc: snapshot.zAcc,
              ))
          .toList();
      emit(ChartLoaded(chartData));
    } catch (exception) {
      emit(ChartError("Error getting chart data"));
    }
  }
}
