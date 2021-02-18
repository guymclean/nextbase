import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nextbase/data/metadata_api.dart';
import 'package:nextbase/models/journey_snapshot.dart';
import 'package:nextbase/models/metadata_response.dart';
import 'package:nextbase/util/web_service.dart';

class MockWebService extends Mock implements WebService {}

void main() {
  WebService webService;
  MetadataApi metadataApi;

  group('MetadataRepo tests', () {
    setUp(() {
      webService = MockWebService();
      metadataApi = MetadataApiImpl(webService: webService);
    });

    test(
      'getJourneyMetadata correctly deserializes WebService response',
      () async {
        when(webService.get("sampleData", parameters: {"page": 5})).thenAnswer(
          (_) async => {
            "data": [
              {
                "bearing": 241.360000610352,
                "datetime": "2018-02-22T09:39:46Z",
                "distanceFromLast": 0,
                "gpsStatus": "A",
                "lat": 51.571875,
                "lon": -3.20286661783854,
                "speed": 0.48332756917646,
                "xAcc": 0.0390625,
                "yAcc": -0.046875,
                "zAcc": 0.0234375,
              },
            ],
            "hasMore": true,
          },
        );

        final MetadataResponse actual =
            await metadataApi.getJourneyMetadata(page: 5);
        final MetadataResponse expected = MetadataResponse(
          data: [
            JourneySnapshot(
              bearing: 241.360000610352,
              datetime: DateTime.parse("2018-02-22T09:39:46Z"),
              distanceFromLast: 0,
              gpsStatus: "A",
              lat: 51.571875,
              lon: -3.20286661783854,
              speed: 0.48332756917646,
              xAcc: 0.0390625,
              yAcc: -0.046875,
              zAcc: 0.0234375,
            ),
          ],
          hasMore: true,
        );

        expect(actual, expected);
      },
    );
  });
}
