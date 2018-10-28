import "package:http/http.dart";
import 'dart:convert';

const BASE_URL = 'http://10.0.0.225:8080';
const HEADERS = {
  'Content-Type': 'application/json',
};

Future<Response> apiPost(String uri, body) {
  return post(
    BASE_URL + uri,
    headers: HEADERS,
    body: json.encode(body),
  );
}
