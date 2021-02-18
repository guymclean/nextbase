import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nextbase/data/metadata_api.dart';
import 'package:nextbase/data/metadata_repo.dart';
import 'package:nextbase/models/journey_snapshot.dart';
import 'package:nextbase/models/metadata_response.dart';

class MockMetadataApi extends Mock implements MetadataApi {}

List<JourneySnapshot> snapshotsForPage0 = [
  JourneySnapshot(
    bearing: 1,
    datetime: DateTime(2021),
    distanceFromLast: 1,
    gpsStatus: "A",
    lat: 1,
    lon: 1,
    speed: 1,
    xAcc: 1,
    yAcc: 1,
    zAcc: 1,
  ),
];

List<JourneySnapshot> snapshotsForPage1 = [
  JourneySnapshot(
    bearing: 2,
    datetime: DateTime(2022),
    distanceFromLast: 2,
    gpsStatus: "B",
    lat: 2,
    lon: 2,
    speed: 2,
    xAcc: 2,
    yAcc: 2,
    zAcc: 2,
  ),
];

void main() {
  MetadataApi metadataApi;
  MetadataRepo metadataRepo;

  group('MetadataRepo tests', () {
    setUp(() {
      metadataApi = MockMetadataApi();
      metadataRepo = MetadataRepoImpl(metadataApi: metadataApi);
    });

    test(
      'journeyMetadata correctly returns combined MetadataApi responses',
      () async {
        when(metadataApi.getJourneyMetadata(page: 0)).thenAnswer(
          (_) async => MetadataResponse(
            data: snapshotsForPage0,
            hasMore: true,
          ),
        );
        when(metadataApi.getJourneyMetadata(page: 1)).thenAnswer(
          (_) async => MetadataResponse(
            data: snapshotsForPage1,
            hasMore: false,
          ),
        );

        final List<JourneySnapshot> actual = await metadataRepo.journeyMetadata;
        final List<JourneySnapshot> expected =
            snapshotsForPage0 + snapshotsForPage1;

        expect(actual, expected);
      },
    );
  });
}
