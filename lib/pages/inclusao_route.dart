import 'dart:async';
//import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:revenda/apis/api_carros.dart';
import 'package:revenda/apis/api_marcas.dart';
import 'package:revenda/classes/marca.dart';

class InclusaoRoute extends StatefulWidget {
  const InclusaoRoute({Key? key}) : super(key: key);

  @override
  _InclusaoRouteState createState() => _InclusaoRouteState();
}

class _InclusaoRouteState extends State<InclusaoRoute> {
  final _edName = TextEditingController();
  final _edAmount = TextEditingController();
  final _edTag = TextEditingController();
  final _edImage = TextEditingController();


  ApiMarcas apiMarcas = ApiMarcas();
  ApiCarros apiCarros = ApiCarros();

  late List<Marca> marcas;

  FutureOr carregaMarcas() async {
    marcas = await apiMarcas.obterMarcas(http.Client());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    carregaMarcas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inclusão de Produtos'),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        tooltip: 'Voltar',
        child: const Icon(Icons.arrow_back),
      ),
    );
  }

  Container _body() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _edName,
            keyboardType: TextInputType.name,
            style: const TextStyle(
              fontSize: 20,
            ),
            decoration: const InputDecoration(
              labelText: "Produto",
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  controller: _edAmount,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Quantidade",
                  ),
                ),
              ),
            ],
          ),
          TextFormField(
            controller: _edTag,
            keyboardType: TextInputType.name,
            style: const TextStyle(
              fontSize: 20,
            ),
            decoration: const InputDecoration(
              labelText: "Serial Number",
            ),
          ),
          TextFormField(
            controller: _edImage,
            keyboardType: TextInputType.url,
            style: const TextStyle(
              fontSize: 20,
            ),
            decoration: const InputDecoration(
              labelText: "URL da Imagem",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ElevatedButton(
              onPressed: _gravaDados,
              child: const Text("Incluir",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _gravaDados() async {
    if (_edName.text == "" ||
        _edAmount.text == "" ||
        _edTag.text == "" ||
        _edImage.text == "") {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Atenção'),
              content: const Text('Por favor, preencha todos os campos'),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok')),
              ],
            );
          });
      return;
    }

    String novo = await apiCarros.createProduct(
      _edName.text,
      int.parse(_edAmount.text),
      _edTag.text,
      _edImage.text,

    );

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Cadastrado Concluído!'),
            content: Text(novo),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok')),
            ],
          );
        });

    _edName.text = "";
    _edTag.text = "";
    _edAmount.text = "";
    _edImage.text = "";

  }
}
