import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex_app/providers/favorites_provider.dart';
import 'package:pokedex_app/providers/pokemon_list_provider.dart';
import 'package:pokedex_app/screens/home_screen.dart';
import 'package:pokedex_app/services/poke_api_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox<int>('favorites');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PokemonListProvider(PokeApiService())..initialize(),
        ),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: MaterialApp(
        title: 'Pokedex App',
        theme: ThemeData(primarySwatch: Colors.red),
        home: const HomeScreen(),
      ),
    );
  }
}
