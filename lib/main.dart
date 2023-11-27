import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:example/service/Service.dart';

import 'models/pokemon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Pokedex'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Service service = Service();

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        title: Text(widget.title, style: const TextStyle(
            color: Colors.black54
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: _screenSize.height,
        child: Column(
          children: [
            FutureBuilder (
              future: service.getPokemons(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if(snapshot.hasData) {
                  return SizedBox (
                    width: double.infinity,
                    height: _screenSize.height * 0.86,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: _pokemonItem(snapshot.data as List<Pokemon>),
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      )
    );
  }

  List<Widget> _pokemonItem(List<Pokemon> pokemons) {
    return pokemons.map((pokemon) {
      return Column (
        children: [
          Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              height: 150.0,
              child: Row (
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(pokemon.img),
                    radius: 50,
                  ),
                  Expanded(
                      child: Padding (
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(pokemon.idPokedex),
                            Text(pokemon.name)
                          ],
                        ),
                      )
                  )
                ],
              ),
            ),
          )
        ],
      );
    }).toList();
  }
}
