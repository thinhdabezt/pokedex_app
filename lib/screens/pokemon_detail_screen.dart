import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon_detail.dart';
import 'package:pokedex_app/models/pokemon_list_item.dart';
import 'package:pokedex_app/services/poke_api_service.dart';

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
    _loadDetail();
    super.initState();
  }

  Future<void> _loadDetail() async {
    try {
      final d = await api.fetchPokemonDetail(widget.pokemon.id);
      setState(() {
        detail = d;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.pokemon.name.toUpperCase())),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.redAccent),
            )
          : detail == null
          ? const Center(child: Text("Failed to load data :("))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: "pokemon-${widget.pokemon.id}",
                    child: Image.network(
                      detail!.imageUrl,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "#${detail!.id} - ${detail!.name.toUpperCase()}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Wrap(
                    spacing: 8,
                    children: detail!.types
                        .map(
                          (t) => Chip(
                            label: Text(t.toUpperCase()),
                            backgroundColor: Colors.red.shade100,
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    "Stats",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: detail!.stats.entries.map((e) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(e.key.toUpperCase()),
                          Text(e.value.toString()),
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    "Abilities",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: detail!.abilities
                        .map(
                          (a) => Chip(
                            label: Text(a),
                            backgroundColor: Colors.blue.shade100,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
    );
  }
}
