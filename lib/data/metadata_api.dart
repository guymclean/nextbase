import 'package:flutter/foundation.dart';
import 'package:nextbase/models/metadata_response.dart';
import 'package:nextbase/util/web_service.dart';

abstract class MetadataApi {
  Future<MetadataResponse> getJourneyMetadata({int page});
}

class MetadataApiImpl implements MetadataApi {
  final WebService _webService;

  MetadataApiImpl({
    @required WebService webService,
  }) : _webService = webService;

  Future<MetadataResponse> getJourneyMetadata({int page = 0}) async {
    final Map<String, dynamic> response = await _webService.get(
      "sampleData",
      parameters: {"page": page},
    );
    return MetadataResponse.fromMap(response);
  }
}
