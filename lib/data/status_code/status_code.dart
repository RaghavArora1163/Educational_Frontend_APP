import 'dart:convert';


class StatusCode{

  ///Check Status Code
  static returnResponse(response){
    switch(response.statusCode){

    /// OK
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

    /// CREATE
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

    /// Bad Request
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

    /// Unauthorized
      case 401:
        dynamic responseJson = jsonDecode(response.body);

        return responseJson;

    /// Payment Required
      case 402:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

    /// Forbidden
      case 403:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

    /// Not Found
      case 404:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

    /// Method Not Allowed
      case 405:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

    ///Server TimeOut
      case 408:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

    /// No Response
      case 444:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

    /// Internal Server Error
      case 500:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

    /// Bad Gateway
      case 502:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

    /// Gateway Timeout
      case 504:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      default:
        dynamic responseJson = jsonDecode(response.body);
        throw responseJson;
    }

  }

}