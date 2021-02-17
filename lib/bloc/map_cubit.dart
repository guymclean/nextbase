import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nextbase/bloc/map_states.dart';
import 'package:nextbase/data/metadata_repo.dart';
import 'package:nextbase/models/journey_snapshot.dart';
import 'package:nextbase/models/map_data.dart';

class MapCubit extends Cubit<MapState> {
  final MetadataRepo _metadataRepo;

  MapCubit({
    @required MetadataRepo metadataRepo,
  })  : _metadataRepo = metadataRepo,
        super(MapLoading()) {
    _loadMap();
  }

  _loadMap() async {
    try {
      final List<JourneySnapshot> snapshots =
          await _metadataRepo.getJourneyMetadata();
      final MapData mapData = MapData(
        snapshots
            .map((JourneySnapshot snapshot) => LatLng(
                  snapshot.lat,
                  snapshot.lon,
                ))
            .toList(),
      );
      emit(MapLoaded(mapData));
    } catch (exception) {
      emit(MapError("Error getting map data"));
    }
  }
}
