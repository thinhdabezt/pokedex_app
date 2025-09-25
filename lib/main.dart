import 'package:flutter/material.dart';
import 'package:pokedex_app/providers/pokemon_list_providers.dart';
import 'package:pokedex_app/screens/home_screen.dart';
import 'package:pokedex_app/services/poke_api_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PokemonListProviders(PokeApiService())..initialize(),
        ),
      ],
      child: MaterialApp(
        title: 'Pokedex App',
        theme: ThemeData(primarySwatch: Colors.red),
        home: const HomeScreen(),
      ),
    );
  }
}