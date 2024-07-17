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


  // /// Send a new [RemoteMessage] to the FCM server. Android only.
  // Future<void> sendMessage({
  //   String? to,
  //   Map<String, String>? data,
  //   String? collapseKey,
  //   String? messageId,
  //   String? messageType,
  //   int? ttl,
  // }) {
  //   if (ttl != null) {
  //     assert(ttl >= 0);
  //   }
  //   return _delegate.sendMessage(
  //     to: to ?? '${app.options.messagingSenderId}@fcm.googleapis.com',
  //     data: data,
  //     collapseKey: collapseKey,
  //     messageId: messageId,
  //     messageType: messageType,
  //     ttl: ttl,
  //   );
  // }
}
