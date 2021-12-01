import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:revenda/classes/cliente.dart';

class ApiLogin {
  final String url = 'http://ad68-177-22-162-62.ngrok.io/login';

  getLoginCliente(String email, String pass) async {
    print('GETLOGIN');
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'pass': pass,
      }),
    );

    if (response.statusCode == 200) {
      print("STATUS 200");
      var lista = json.decode(response.body);

         print(lista);
      //   print(lista["userId"]);
      //   print(lista["user"]);

      if (lista["id"] == null) {
        return null;
      } else {
        return Cliente(
            id: lista["id"], name: lista["name"], token: lista["token"]);
      }
    } else {
      throw Exception('Erro ao conectar com WebService');
    }
  }
}
