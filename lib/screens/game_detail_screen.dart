import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon_list_item.dart';
import 'package:pokedex_app/screens/pokemon_detail_screen.dart';
import '../services/poke_api_service.dart';
import '../models/game.dart';
import '../models/pokemon_entry.dart';

class GameDetailScreen extends StatefulWidget {
  final String gameName;
  const GameDetailScreen({super.key, required this.gameName});

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  final api = PokeApiService();
  Game? game;
  List<PokemonEntry> pokemons = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadGame();
  }

  Future<void> _loadGame() async {
    try {
      final g = await api.fetchGameDetail(widget.gameName);
      final pkmList = await api.fetchPokemonInGame(widget.gameName);
      setState(() {
        game = g;
        pokemons = pkmList;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (game == null) {
      return const Scaffold(body: Center(child: Text("Failed to load game")));
    }

    return Scaffold(
      appBar: AppBar(title: Text(game!.name.toUpperCase())),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ID: ${game!.id}", style: const TextStyle(fontSize: 16)),
            Text(
              "Version Group: ${game!.versionGroup}",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "Generation: ${game!.generation}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              "Versions in this group:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: game!.versions
                  .map((v) => Chip(label: Text(v.toUpperCase())))
                  .toList(),
            ),
            const SizedBox(height: 24),
            const Text(
              "Pokémon in this game:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: pokemons.length,
                itemBuilder: (context, index) {
                  final p = pokemons[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: Hero(
                        tag:
                            "pokemon_${p.id}", // Hero tag duy nhất cho mỗi Pokémon
                        child: Image.network(
                          p.imageUrl,
                          height: 50,
                          width: 50,
                          fit: BoxFit.contain,
                        ),
                      ),
                      title: Text(p.name.toUpperCase()),
                      subtitle: Text("Entry #${p.entryNumber}"),
                      onTap: () {
                        final pokemonItem = PokemonListItem(
                          id: p.id,
                          name: p.name,
                          url: "https://pokeapi.co/api/v2/pokemon/${p.id}/",
                          imageUrl: p.imageUrl,
                          types:
                              [], // types sẽ được load lại trong PokemonDetailScreen
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PokemonDetailScreen(
                              pokemon: pokemonItem,
                              heroTag:
                                  "pokemon_${p.id}", // truyền tag sang detail
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
