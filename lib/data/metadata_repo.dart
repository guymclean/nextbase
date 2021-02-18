import 'package:flutter/foundation.dart';
import 'package:nextbase/models/journey_snapshot.dart';
import 'package:nextbase/models/metadata_response.dart';

import 'metadata_api.dart';

abstract class MetadataRepo {
  Future<List<JourneySnapshot>> get journeyMetadata;
}

class MetadataRepoImpl implements MetadataRepo {
  final MetadataApi _metadataApi;

  List<JourneySnapshot> _journeyMetadata;

  MetadataRepoImpl({
    @required MetadataApi metadataApi,
  }) : _metadataApi = metadataApi;

  @override
  Future<List<JourneySnapshot>> get journeyMetadata async {
    if (_journeyMetadata == null) {
      final List<JourneySnapshot> journey = List();
      bool moreDataNeedsFetched = true;
      int currentPage = 0;

      while (moreDataNeedsFetched) {
        final MetadataResponse response =
            await _metadataApi.getJourneyMetadata(page: currentPage);
        journey.addAll(response.data);
        currentPage++;
        moreDataNeedsFetched = response.hasMore;
      }

      _journeyMetadata = journey;
    }

    return _journeyMetadata;
  }
}
