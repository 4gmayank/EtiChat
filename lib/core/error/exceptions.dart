import 'dart:developer';

/// Exception from remote server in Data Layer
class ServerException implements Exception {
  String message;

  ServerException({required this.message}) {
    log("Server Exception");
  }
}

/// CacheException from cache in Data Layer
class CacheException implements Exception {}
