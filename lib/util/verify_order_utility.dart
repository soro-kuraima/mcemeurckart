import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

String url = 'https://sea-turtle-app-dw7mj.ondigitalocean.app/';

Future<http.Response> verifyOrder(
    String token, Map<String, dynamic> order) async {
  log(order.toString());
  final List products = order['products'];
  final response = await http.post(
      Uri.parse(url + 'verify-order')
          .replace(queryParameters: {'idToken': token}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Map<String, dynamic>>{
        'order': {
          'products': products,
        },
      }));

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception({
      'statusCode': response.statusCode,
      'body': response.body,
    });
  }
}
