import 'dart:convert';

import 'package:http/http.dart' as http;

String url = 'https://sea-turtle-app-dw7mj.ondigitalocean.app/';

Future<http.Response> sendAuthRequest(dynamic user) async {
  final response = await http.post(Uri.parse(url + 'request-auth'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': user['email'],
        'password': user['password'],
        'rank': user['rank'],
        'name': user['name'],
        'groceryCardNo': user['groceryCardNo'],
        'address': user['address'],
      }));

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception(response.body);
  }
}
