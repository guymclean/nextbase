import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nextbase/bloc/chart_cubit.dart';
import 'package:nextbase/bloc/chart_states.dart';
import 'package:nextbase/data/metadata_repo.dart';
import 'package:nextbase/models/chart_data.dart';
import 'package:nextbase/models/journey_snapshot.dart';

class MockMetadataRepo extends Mock implements MetadataRepo {}

List<JourneySnapshot> stubbedJourneyMetadata = [
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

List<ChartData> expectedChartData = [
  ChartData(datetime: DateTime(2021), xAcc: 1, yAcc: 1, zAcc: 1),
  ChartData(datetime: DateTime(2022), xAcc: 2, yAcc: 2, zAcc: 2),
];

void main() {
  MetadataRepo metadataRepo;

  group('ChartCubit tests', () {
    setUp(() {
      metadataRepo = MockMetadataRepo();
    });

    blocTest(
      'ChartCubit successfully loads data on creation',
      build: () {
        when(metadataRepo.journeyMetadata)
            .thenAnswer((_) async => stubbedJourneyMetadata);
        return ChartCubit(metadataRepo: metadataRepo);
      },
      expect: [ChartLoaded(expectedChartData)],
    );

    blocTest(
      'ChartCubit unsuccessfully loads data on creation',
      build: () {
        when(metadataRepo.journeyMetadata)
            .thenAnswer((_) async => throw Exception());
        return ChartCubit(metadataRepo: metadataRepo);
      },
      expect: [ChartError("Error getting chart data")],
    );
  });
}
