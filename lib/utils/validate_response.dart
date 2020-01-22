import 'package:http/http.dart';
import 'package:open_weather_app/models/server_response.dart';

class ValidateResponse {
  static ServerResponse generateException(Response response) {
    switch (response.statusCode) {
      case 400:
        return _badRequest(response);
      case 401:
        return _accessTokenExpired(response);
      case 404:
        return _resourceNotFound(response);
      case 500:
        return _serverError(response);
      default:
        return _unknowError(response);
    }
  }

  static ServerResponse _badRequest(Response response) {
    return ServerResponse(
      "BadRequest",
      "Bad Request",
      response.body != null ? response.body : "",
    );
  }

  static ServerResponse _accessTokenExpired(Response response) {
    return ServerResponse(
      "AccessTokenExpired",
      "Access Token Expired",
      response.body != null ? response.body : "Your session has expired",
    );
  }

  static ServerResponse _resourceNotFound(Response response) {
    return ServerResponse(
      "ResourceNotFound",
      "Resource Not Found",
      response.body != null ? response.body : "The requested resource was not found.",
    );
  }

  static ServerResponse _serverError(Response response) {
    return ServerResponse(
      "ServerError",
      "Server Error",
      response.body != null ? response.body : "A Server Error occured, please try again later.",
    );
  }

  static ServerResponse _unknowError(Response response) {
    return ServerResponse(
      "UnknowError",
      "Unknow Error",
      response.body != null ? response.body : "An Unknow Error occured, please try again later.",
    );
  }
}
