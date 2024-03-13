import 'dart:convert';
import 'dart:developer';

import 'package:flutter_table/services/network_response.dart';
import 'package:http/http.dart';


class NetworkCaller {
  ///----------------------------------->> get request method <<----------------------------------
  static Future<NetworkResponse> getRequest(String url) async {
    String authToken = "264ae90790a4275c27829533c55800f05301e308";
    try {
      Response response = await get(Uri.parse(url),headers: {'Authorization': 'Token $authToken'},);

      log("getRequest statusCode ==> ${response.statusCode}");
      log("getRequest body ==> ${response.body}");
     // log("length: ${response.body!.length}");

      if (response.statusCode == 200) {
        return NetworkResponse(isSuccess: true,
            statusCode: response.statusCode,
            body: jsonDecode(response.body));
      } else {
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode, body: null);
      }
    } catch (e) {
      log(e.toString());
    }
    return NetworkResponse(isSuccess: false, statusCode: -1, body: null);
  }
}