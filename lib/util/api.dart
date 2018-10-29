import "package:http/http.dart";
import 'dart:convert';

const BASE_URL = 'http://192.241.131.74:49179';
// const BASE_URL = 'http://localhost:8080';
const API_REFRESH_TOKEN_STORAGE_KEY = 'API_REFRESH_TOKEN';

String token;

Map<String, String> getHeaders() {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  if (token != null) headers['Authorization'] = 'Bearer ' + token;

  return headers;
}

Future<Response> apiPost(String uri, body) {
  return post(
    BASE_URL + uri,
    headers: getHeaders(),
    body: json.encode(body),
  );
}

Future<Response> apiGet(String uri) {
  return get(
    BASE_URL + uri,
    headers: getHeaders(),
  );
}

void setToken(String _token) {
  token = _token;
}
