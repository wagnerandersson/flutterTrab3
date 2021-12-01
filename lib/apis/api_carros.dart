import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:revenda/classes/carro.dart';

class ApiCarros {
  final String url = 'http://ad68-177-22-162-62.ngrok.io/stock';

// A function that converts a response body into a List<Carro>.
  List<Carro> parseStock(String responseBody) {
    print("parsed");
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    print("parsed");
    print(parsed);

    return parsed.map<Carro>((json) => Carro.fromJson(json)).toList();
  }

  Future<List<Carro>> obterProduct(http.Client client) async {
    print("CAIU");

    final response = await client.get(Uri.parse(url));
    // print(await compute(parseStock, response.body));
    print(response.body);
    // Use the compute function to run parseCarros in a separate isolate.
    return compute(parseStock, response.body);

  }

  Future<http.Response> deleteProduct(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('$url/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to delete album.');
    }
  }

  Future<String> createProduct(
      String product_name, int amount, String tag, String image) async {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'product_name': product_name,
        'amount': amount,
        'tag': tag,
        'image': image,

      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // return Carro.fromJson(jsonDecode(response.body));
      return "Ok! Produto Inserido com Sucesso";
    } else {
      throw Exception('Fail.');
    }
  }
}
