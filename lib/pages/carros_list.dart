import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:revenda/classes/carro.dart';
import 'package:revenda/apis/api_carros.dart';
import 'package:http/http.dart' as http;

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
  print("CAIU PRODUCT");

  final response = await client.get(Uri.parse(url));
  // print(await compute(parseStock, response.body));
  print(response.body);
  // Use the compute function to run parseCarros in a separate isolate.
  return compute(parseStock, response.body);

}


class CarrosList extends StatefulWidget {
  //const CarrosList3({Key? key, required this.carros}) : super(key: key);
  CarrosList({Key? key, required this.carros}) : super(key: key);

//  final List<Carro> carros;
  List<Carro> carros;

  @override
  State<CarrosList> createState() => _CarrosListState();
}

class _CarrosListState extends State<CarrosList> {
  ApiCarros apiCarros = ApiCarros();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.carros.length,
      itemBuilder: (BuildContext context, int index) {
        Carro carro = widget.carros[index];
        print("carro");
        // print(carro.id);
        return appBodyImage(context, carro.product_name, carro.tag,
             carro.image);
      },
    );
  }

  ListTile appBodyImage(BuildContext context, String product_name,
      String tag, String image) {
    return (ListTile(
      leading: CircleAvatar(
        // backgroundImage: NetworkImage(
        //   image,
        // ),
      ),
      title: Text(product_name),
      subtitle: Text("S/N: " + tag),
      isThreeLine: true,
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Exclusão'),
              content: Text('Confirma a exclusão do $product_name?'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // exclui o registro a partir de uma chamada ao Web Services
                    // apiCarros.deleteProduct(id.toString());
                    // atualiza o estado, do array de carros, para refletir na listagem
                    setState(() {
                      // widget.carros = widget.carros
                      //     .where((carro) => carro.id != id)
                      //     .toList();
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Sim'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Não'),
                ),
              ],
            );
          },
        );
      },
    ));
  }
}
