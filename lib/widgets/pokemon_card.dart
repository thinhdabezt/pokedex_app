import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon_list_item.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PokemonCard extends StatelessWidget {
  final PokemonListItem pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: pokemon.imageUrl,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.red,
                ),
              ),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error_outline_rounded),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            pokemon.name[0].toUpperCase() + pokemon.name.substring(1),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
