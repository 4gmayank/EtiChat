import 'package:dio/dio.dart';

class CountryService {
  final Dio _dio = Dio();
  Dio? mock;


  CountryService([Dio? dio]) : mock = dio ?? Dio();

  Future<List<dynamic>> fetchCountries() async {
    try {
      final response = await _dio.get('https://restcountries.com/v3.1/all');
      return response.data;
    } catch (e) {
      print('Error fetching countries: $e');
      throw e;
    }
  }
  Future<List<dynamic>> mockfetchCountries() async {
    try {
      final response = await mock!.get('https://restcountries.com/v3.1/all');
      return response.data;
    } catch (e) {
      print('Error fetching countries: $e');
      throw e;
    }
  }
}
