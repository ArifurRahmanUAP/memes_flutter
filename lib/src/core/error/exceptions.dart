class ServerException implements Exception {
  String? message;

  ServerException({this.message});
}

class NoMessageFoundException implements Exception {
  String? message;

  NoMessageFoundException({this.message});
}

class CacheException implements Exception {}
