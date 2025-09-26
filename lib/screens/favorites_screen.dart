import 'package:flutter/material.dart';
import 'package:pokedex_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/pokemon_list_provider.dart';
import '../widgets/pokemon_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavoritesProvider>(context);
    final listProvider = Provider.of<PokemonListProvider>(context);

    final favPokemons = listProvider.allPokemons
        .where((p) => favProvider.favoriteIds.contains(p.id))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).translate("favorites-title"))),
      body: favPokemons.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context).translate("favorites-empty"),
                  ),
                  Icon(Icons.favorite_sharp, color: Colors.red),
                ],
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              padding: const EdgeInsets.all(8),
              itemCount: favPokemons.length,
              itemBuilder: (context, index) {
                return PokemonCard(pokemon: favPokemons[index]);
              },
            ),
    );
  }
}
