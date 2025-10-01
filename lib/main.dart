import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex_app/screens/main_navigation.dart';
import 'theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'services/poke_api_service.dart';
import 'providers/pokemon_list_provider.dart';
import 'providers/favorites_provider.dart';
import 'providers/move_list_provider.dart';
import 'providers/item_list_provider.dart';
import 'providers/game_list_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox<int>('favorites');
  await Hive.openBox<Map>('pokemon_details');

  runApp(const PokedexApp());
}

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PokemonListProvider(PokeApiService())..initialize(),
        ),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => MoveListProvider(PokeApiService())),
        ChangeNotifierProvider(create: (_) => ItemListProvider(PokeApiService())),
        ChangeNotifierProvider(create: (_) => GameListProvider(PokeApiService())),
      ],
      child: MaterialApp(
        title: "Pokédex",
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        supportedLocales: const [Locale('en'), Locale('vi')],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const MainNavigation(),
      ),
    );
  }
}