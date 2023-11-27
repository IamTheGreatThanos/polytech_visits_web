import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:polytech_visits_web/utils/const.dart';

import 'auth_repository.dart';

class NetworkService {
  final String baseUrl = AppConstants.baseUrl;
  final Map<String, String> baseHeader = {
    "Access-Control-Allow-Origin": "*",
    "Accept": "application/json",
    "Content-Type": "application/json; charset=UTF-8",
  };

  Future<dynamic> login(String login, String password) async {
    final response = await http.post(
      Uri.parse('${baseUrl}users/login/'),
      headers: {
        // "Access-Control-Allow-Origin": "*",
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode({'username': login, 'password': password}),
      encoding: Encoding.getByName("utf-8"),
    );

    var responseJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return responseJson;
    } else {
      throw Exception(responseJson);
    }
  }

  Future<dynamic> checkSchedule(String number) async {
    final response = await http.post(
      Uri.parse('${baseUrl}schedule/check/'),
      headers: {
        // "Access-Control-Allow-Origin": "*",
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Token ${await AuthRepository().getUserToken()}"
      },
      body: jsonEncode({'number': number}),
    );

    var responseJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return responseJson;
    } else {
      throw Exception(responseJson);
    }
  }

  Future<dynamic> getEntryHistory() async {
    final response = await http.get(
      Uri.parse('${baseUrl}users/history/'),
      headers: {
        // "Access-Control-Allow-Origin": "*",
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Token ${await AuthRepository().getUserToken()}"
      },
    );

    var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    // print(responseJson);

    if (response.statusCode == 200) {
      return responseJson;
    } else {
      throw Exception(responseJson);
    }
  }
}
