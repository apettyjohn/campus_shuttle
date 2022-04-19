// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';

Uri makeUrl(String route) {
  String baseURL = "http://localhost:8000/";
  if (defaultTargetPlatform != TargetPlatform.windows) {
    baseURL = "http://10.0.2.2:8000/";
  }
  return Uri.parse(baseURL + route);
}

// GET
Future<Response> getRequest(String route) async {
  //encode Map to JSON
  try {
    var response = await get(makeUrl(route),
        headers: {"Content-Type": "application/json"});
    return response;
  } catch (e) {
    // print('Encountered get request error: $e');
    return Response('Error', 500);
  }
}

// POST
Future<Response> postRequest(String route, Map data) async {
  //encode Map to JSON
  var body = json.encode(data);
  try {
    var response = await post(makeUrl(route),
        headers: {"Content-Type": "application/json"}, body: body);
    return response;
  } catch (e) {
    // print('Encountered post request error: $e');
    return Response('Error', 500);
  }
}

Future<int> getWaitTime(int i) async {
  var response = await getRequest('waitTime');
  if (response.statusCode == 200) {
    var body = await jsonDecode(response.body);
    var list = body['times'] as List;
    if (i < list.length) {
      return list[i];
    } else {
      return -1;
    }
  } else {
    return -1;
  }
}

Future<int> getTimeToRide(int i) async {
  var response = await getRequest('waitTime');
  if (response.statusCode == 200) {
    var body = await jsonDecode(response.body);
    var list = body['times'] as List;
    int totalTime = 0;
    for (var j = 0; j < list.length; j++) {
      if (j <= i) {
        totalTime += list[j] as int;
      } else {
        break;
      }
    }
    return totalTime;
  } else {
    return -1;
  }
}

Future<int> getFullWaitTime() async {
  var response = await getRequest('waitTime');
  if (response.statusCode == 200) {
    var body = await jsonDecode(response.body);
    int totalTime = 0;
    for (var time in body['times']) {
      totalTime += time as int;
    }
    return totalTime;
  } else {
    return -1;
  }
}

Future<List> getRides() async {
  var response = await getRequest('rides');
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    return [
      {"passengers": 0}
    ];
  }
}
