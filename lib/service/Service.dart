import 'dart:convert';
import 'dart:io';

import 'package:example/models/pokemon.dart';
import 'package:example/service/IService.dart';
import 'package:dio/dio.dart';

class Service extends IService {
  var urlDevServer = "http://demetrio-pk-api.jdemetriodc.com/pokemon";

  @override
  Future<List<Pokemon>> getPokemons() async {
    try {
      var client = Dio();
      var response = await client.get(urlDevServer);

      Iterable iterable = json.decode(json.encode(response.data));
      List<Pokemon> pokemons = iterable.map((e) => Pokemon.fromJson(e)).toList();

      return pokemons;
    } on SocketException {
      throw const SocketException('No estas conectado a internet');
    } catch (e) {
      throw Exception(e);
    }
  }
}