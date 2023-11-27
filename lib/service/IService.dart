import '../models/pokemon.dart';

abstract class IService {
  Future<List<Pokemon>> getPokemons();
}