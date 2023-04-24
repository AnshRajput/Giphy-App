import 'package:giphyapp/utils/constants.dart';
import 'package:http/http.dart' as http;

class APIService {
  static Future<dynamic> getApi(String endPoint, Map<String, String> headers,
      Map<String, dynamic> queryParams) {
    Uri url = Uri.parse(Constants.baseUrl + endPoint);
    Future<http.Response> response;
    try {
      print(url);
      response =
          http.get(url.replace(queryParameters: queryParams), headers: headers);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
}
