import 'package:flutter/material.dart';
import '../services/poke_api_service.dart';
import '../models/pokemon_detail.dart';
import '../models/pokemon_list_item.dart';
import '../utils/type_colors.dart';

class PokemonDetailScreen extends StatefulWidget {
  final PokemonListItem pokemon;

  const PokemonDetailScreen({super.key, required this.pokemon});

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  final api = PokeApiService();
  PokemonDetail? detail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDetail();
  }

  Future<void> _loadDetail() async {
    try {
      final d = await api.fetchPokemonDetail(widget.pokemon.id);
      setState(() {
        detail = d;
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
    if (detail == null) {
      return const Scaffold(
        body: Center(child: Text("Failed to load Pokémon")),
      );
    }

    final colors = detail!.types
        .map((t) => typeColors[t] ?? Colors.grey)
        .toList();

    if (colors.length == 1) {
      colors.add(colors.first);
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  detail!.name.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Hero(
                  tag: 'pokemon-${widget.pokemon.id}',
                  child: Image.network(detail!.imageUrl, fit: BoxFit.contain),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Wrap(
                      spacing: 8,
                      children: detail!.types
                          .map(
                            (t) => Chip(
                              label: Text(
                                t.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: typeColors[t] ?? Colors.grey,
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      "Stats",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Column(
                      children: detail!.stats.entries.map((e) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 80,
                                child: Text(e.key.toUpperCase()),
                              ),
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: e.value / 200.0,
                                  backgroundColor: Colors.grey.shade300,
                                  color: colors[0],
                                  minHeight: 8,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text("${e.value}"),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      "Abilities",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: detail!.abilities
                          .map(
                            (a) => Chip(
                              label: Text(
                                a,
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: colors[0].withOpacity(0.8),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
