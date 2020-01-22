import 'dart:io';

class ServerResponse implements HttpException {
  ServerResponse(String type, String header, String message) {
    this.type = type;
    this.header = header;
    this.message = message;
  }

  String type;
  String header;
  String message;

  @override
  Uri get uri => throw UnimplementedError();
}
