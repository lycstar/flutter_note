import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_note/note.dart';

const baseUrl = "http://118.24.85.15:8080";

const registerAPI = "$baseUrl/register";
const loginAPI = "$baseUrl/login";
const insertAPI = "$baseUrl/insert";
const deleteAPI = "$baseUrl/delete";
const updateAPI = "$baseUrl/update";
const queryAPI = "$baseUrl/query";

Future<Map> register(String username, String password) async {
  var result = await Dio().get(
    registerAPI,
    queryParameters: {
      "username": username,
      "password": password,
    },
  );
  if (result.data.runtimeType == String) {
    return json.decode(result.data);
  }
  return result.data;
}

Future<Map> login(String username, String password) async {
  var result = await Dio().post(
    loginAPI,
    data: {
      "username": username,
      "password": password,
    },
  );
  if (result.data.runtimeType == String) {
    return json.decode(result.data);
  }
  return result.data;
}

Future<Map> queryNotes(String username, String token) async {
  var result = await Dio().get(
    queryAPI,
    queryParameters: {
      "username": username,
    },
    options: Options(
      headers: {
        'Authorization': token,
      },
    ),
  );
  if (result.data.runtimeType == String) {
    return json.decode(result.data);
  }
  return result.data;
}

Future<Map> insertNote(Note note, String token) async {
  var result = await Dio().get(
    insertAPI,
    queryParameters: {
      "username": note.username,
      "content": note.content,
      "time": note.time,
    },
    options: Options(
      headers: {
        'Authorization': token,
      },
    ),
  );
  if (result.data.runtimeType == String) {
    return json.decode(result.data);
  }
  return result.data;
}

Future<Map> deleteNote(note, String token) async {
  var result = await Dio().get(
    deleteAPI,
    queryParameters: {
      "id": note.id,
    },
    options: Options(
      headers: {
        'Authorization': token,
      },
    ),
  );
  if (result.data.runtimeType == String) {
    return json.decode(result.data);
  }
  return result.data;
}

Future<Map> updateNote(Note note, String token) async {
  var result = await Dio().get(
    updateAPI,
    queryParameters: {
      "id": note.id,
      "content": note.content,
      "time": note.time,
    },
    options: Options(
      headers: {
        'Authorization': token,
      },
    ),
  );
  if (result.data.runtimeType == String) {
    return json.decode(result.data);
  }
  return result.data;
}
