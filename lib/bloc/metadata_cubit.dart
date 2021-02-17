import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nextbase/bloc/metadata_states.dart';
import 'package:nextbase/data/metadata_repo.dart';
import 'package:nextbase/models/journey_snapshot.dart';

class MetadataCubit extends Cubit<MetadataState> {
  final MetadataRepo _metadataRepo;

  MetadataCubit({
    @required MetadataRepo metadataRepo,
  })  : _metadataRepo = metadataRepo,
        super(MetadataLoading()) {
    _loadJourneyMetadata();
  }

  _loadJourneyMetadata() async {
    try {
      final List<JourneySnapshot> snapshots =
          await _metadataRepo.getJourneyMetadata();
      emit(MetadataLoaded(snapshots));
    } catch (exception) {
      emit(MetadataError("Error getting journey metadata"));
    }
  }
}
