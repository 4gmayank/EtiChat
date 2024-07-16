import 'package:dio/dio.dart';
import 'package:eti_chat/feature/data/country_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'country_service_test.mocks.dart';


// Generate the mock class using the build_runner command
// flutter pub run build_runner build
@GenerateMocks([Dio])
void main() {
  group('CountryService', () {
    late CountryService countryService;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      countryService = CountryService(mockDio);
    });

    test('fetchCountries returns list of countries on success', () async {
      final mockResponse = Response(
        requestOptions: RequestOptions(path: 'https://restcountries.com/v3.1/all'),
        data: [
          {'name': {'common': 'Country1'}, 'region': 'Region1'},
          {'name': {'common': 'Country2'}, 'region': 'Region2'},
        ],
        statusCode: 200,
      );

      when(mockDio.get(any)).thenAnswer((_) async => mockResponse);

      final countries = await countryService.mockfetchCountries();

      expect(countries, isA<List<dynamic>>());
      expect(countries.length, 2);
      expect(countries[0]['name']['common'], 'Country1');
      expect(countries[1]['name']['common'], 'Country2');
    });

    test('fetchCountries throws exception on error', () async {
      when(mockDio.get(any)).thenThrow(DioError(
        requestOptions: RequestOptions(path: 'https://restcountries.com/v3.1/all'),
      ));

      expect(() => countryService.fetchCountries(), throwsA(isA<DioError>()));
    });
  });
}
