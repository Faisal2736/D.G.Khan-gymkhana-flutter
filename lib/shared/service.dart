import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../extras/constants.dart';

class ApiService {
  Future<http.Response> get(String url) async {
    var apiUrl = Uri.parse("${Constants.apiUrl}$url");
    debugPrint(apiUrl.toString());
    try {
      var response = await http.get(apiUrl);
      var responseBody = jsonDecode(response.body);
      debugPrint(response.body.toString());
      // var isSuccess = responseBody["isSuccess"] ?? false;
      // if (!isSuccess) {
      //   var errorMsg = responseBody["message"] ?? "Something went wrong";
      //   throw Exception(errorMsg);
      // }
      if (response.statusCode != 200) {
        throw Exception("Something went wrong");
      }
      return response;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Something went wrong");
    }
  }

  Future<http.Response> post(String url, Map body) async {
    var apiUrl = Uri.parse("${Constants.apiUrl}$url");
    debugPrint(apiUrl.toString());
    try {
      var response = await http.post(apiUrl, body: jsonEncode(body), headers: {
        'Content-Type': 'application/json',
      });
      debugPrint(response.body.toString());
      var responseBody = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw Exception("Something went wrong");
      }
      return response;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Something went wrong");
    }
  }

  Future<http.Response> delete(String url) async {
    var apiUrl = Uri.parse("${Constants.apiUrl}$url");
    debugPrint(apiUrl.toString());
    try {
      var response = await http.delete(apiUrl, headers: {
        'Content-Type': 'application/json',
      });
      debugPrint(response.body.toString());
      var responseBody = jsonDecode(response.body);
      var isSuccess = responseBody["isSuccess"] ?? false;
      if (!isSuccess) {
        var errorMsg = responseBody["message"] ?? "Something went wrong";
        throw Exception(errorMsg);
      }
      if (response.statusCode != 200) {
        throw Exception("Something went wrong");
      }
      return response;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Something went wrong");
    }
  }

  Future<http.Response> put(String url, Map body) async {
    var apiUrl = Uri.parse("${Constants.apiUrl}$url");
    debugPrint(apiUrl.toString());
    try {
      var response = await http.put(apiUrl,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body));
      debugPrint(response.body.toString());
      var responseBody = jsonDecode(response.body);
      var isSuccess = responseBody["isSuccess"] ?? false;
      if (!isSuccess) {
        var errorMsg = responseBody["message"] ?? "Something went wrong";
        throw Exception(errorMsg);
        throw Exception("Something went wrong");
      }
      if (response.statusCode != 200) {
        throw Exception("Something went wrong");
      }
      return response;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Something went wrong");
    }
  }

  Future<http.Response> postV2(String url, Map body) async {
    var apiUrl = Uri.parse("${Constants.apiUrl}$url");
    debugPrint(apiUrl.toString());
    try {
      var response = await http.post(apiUrl, body: jsonEncode(body), headers: {
        'Content-Type': 'application/json',
      });
      debugPrint(response.body.toString());
      var responseBody = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw Exception("Something went wrong");
      }
      return response;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Something went wrong");
    }
  }

  Future<http.Response> deleteV2(String url) async {
    var apiUrl = Uri.parse("${Constants.apiUrl}$url");
    debugPrint(apiUrl.toString());
    try {
      var response = await http.delete(apiUrl, headers: {
        'Content-Type': 'application/json',
      });
      debugPrint(response.body.toString());
      var responseBody = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw Exception("Something went wrong");
      }
      return response;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Something went wrong");
    }
  }
}
