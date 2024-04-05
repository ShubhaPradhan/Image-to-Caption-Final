import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'dart:io';
// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../config/api_end_point.dart';

class ApiClient {
  final storage = GetStorage();

  Future<ApiResponse<T>> postApi<T>(
    String endPoint, {
    required Map<String, dynamic> requestBody,
    T Function(dynamic json)? responseType,
    required bool isTokenRequired,
    Map<String, dynamic>? imageBody,
    bool? isMultiPartRequest,
    String? token,
  }) async {
    var header = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    try {
      if (isMultiPartRequest ?? false) {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(ApiUrls.baseUrl + endPoint),
        );
        request.headers.addAll(header);
        requestBody.forEach((key, value) {
          request.fields[key] = value.toString();
        });

        imageBody!.forEach((key, value) async {
          log("KEY: $key, VALUE: $value");
          var file = await http.MultipartFile.fromPath(key, value);
          request.files.add(file);
        });
        log("REQUEST FOR POST FOR URL : ${ApiUrls.baseUrl + endPoint} IS : ${request.files}");
        final response = await request.send();

        if (response.statusCode == 200 || response.statusCode == 201) {
          final json = await response.stream.bytesToString();
          log("RESPONSE FOR POST FOR URL : ${ApiUrls.baseUrl + endPoint} IS : $json");
          final data = responseType != null
              ? responseType(jsonDecode(json))
              : jsonDecode(json) as T;
          return ApiResponse.completed(data);
        } else {
          final responseJson = await response.stream.bytesToString();
          log("RESPONSE FOR POST FOR URL : ${ApiUrls.baseUrl + endPoint} IS : $responseJson");
          String message = "";
          for (var key in jsonDecode(responseJson).keys) {
            for (var value in jsonDecode(responseJson)[key]) {
              // concatenate the value with comma separated
              message += value + ", ";
            }

            return ApiResponse.error(message);
          }

          return ApiResponse.error(message);
        }
      } else {
        final response = await http.post(
          Uri.parse(ApiUrls.baseUrl + endPoint),
          headers: header,
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 201 || response.statusCode == 200) {
          final json = jsonDecode(response.body);
          final data = responseType != null ? responseType(json) : json as T;
          return ApiResponse.completed(data);
        } else {
          String message = '';
          log("RESPONSE ERROR: ${response.body}");
          for (var key in jsonDecode(response.body).keys) {
            if (jsonDecode(response.body)[key] is List) {
              for (var value in jsonDecode(response.body)[key]) {
                message += "$value, ";
              }
            } else {
              message += jsonDecode(response.body)[key] + ", ";
            }
          }
          return ApiResponse.error(message);
        }
      }
    } on SocketException {
      return ApiResponse.error("No Internet Connection");
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse.error("Something went wrong. Please try again later");
    }
  }
}

class ApiResponse<T> {
  ApiStatus? status;
  T? response;
  String? message;

  ApiResponse.initial([this.message])
      : status = ApiStatus.INITIAL,
        response = null;

  ApiResponse.loading([this.message])
      : status = ApiStatus.LOADING,
        response = null;

  ApiResponse.completed(this.response)
      : status = ApiStatus.SUCCESS,
        message = null;

  ApiResponse.error(this.message)
      : status = ApiStatus.ERROR,
        response = null;

  @override
  String toString() {
    return "Status: $status \n Message: $message \n Response: $response";
  }
}

class ApiMessage {
  String getMessage(int statusCode) {
    switch (statusCode) {
      case 200:
        return "Success";
      case 400:
        return "Bad Request";
      case 401:
        return "Unauthorized";
      case 403:
        return "Forbidden";
      case 404:
        return "Not Found";
      case 500:
        return "Internal Server Error";
      default:
        return "Oops! Something went wrong. Error code: $statusCode";
    }
  }
}

enum ApiStatus {
  INITIAL,
  LOADING,
  SUCCESS,
  ERROR,
}
