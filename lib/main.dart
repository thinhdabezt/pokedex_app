import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex_app/models/pokemon_list_item.dart';
import 'package:pokedex_app/screens/main_navigation.dart';
import 'package:pokedex_app/screens/pokemon_detail_screen.dart';
import 'package:pokedex_app/services/background_service.dart';
import 'package:pokedex_app/services/notification_service.dart';
import 'package:workmanager/workmanager.dart';
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

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final notif = NotificationService();
  await notif.init();

  void _navigateToPokemonDetail(String pokemonId) {
    final id = int.tryParse(pokemonId);
    if (id == null) return;

    final pokemon = PokemonListItem(
      id: id,
      name: "pokemon_$id", // tạm, sẽ load lại detail trong screen
      url: "https://pokeapi.co/api/v2/pokemon/$id/",
      imageUrl:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png",
      types: [],
    );

    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => PokemonDetailScreen(pokemon: pokemon)),
    );
  }

  notif.flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    ),
    onDidReceiveNotificationResponse: (response) {
      final payload = response.payload;
      if (payload != null && payload.isNotEmpty) {
        _navigateToPokemonDetail(payload);
      }
    },
  );

  // Temporarily disabled workmanager due to Kotlin compilation issues
  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true, // set false khi release
  );

  await Workmanager().registerPeriodicTask(
    "1",
    "dailyTask",
    frequency: const Duration(hours: 24),
    initialDelay: const Duration(seconds: 10),
  );

  await Hive.initFlutter();
  await Hive.openBox<int>('favorites');
  await Hive.openBox<Map>('pokemon_details');

  runApp(PokedexApp());
}

class PokedexApp extends StatelessWidget {
  PokedexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PokemonListProvider(PokeApiService())..initialize(),
        ),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(
          create: (_) => MoveListProvider(PokeApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => ItemListProvider(PokeApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => GameListProvider(PokeApiService()),
        ),
      ],
      child: MaterialApp(
        title: "Pokédex",
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        // supportedLocales: const [Locale('en'), Locale('vi')],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        navigatorKey: navigatorKey,
        home: const MainNavigation(),
      ),
    );
  }
}
