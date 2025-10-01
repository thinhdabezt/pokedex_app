import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../models/pokemon_list_item.dart';
import '../screens/pokemon_detail_screen.dart';
import '../providers/favorites_provider.dart';

class PokemonCard extends StatelessWidget {
  final PokemonListItem pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavoritesProvider>(context);
    final isFav = favProvider.isFavorite(pokemon.id);
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PokemonDetailScreen(pokemon: pokemon),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: theme.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(12),
          color: theme.cardColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pokemon image container
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                border: Border.all(
                  color: theme.primaryColor.withOpacity(0.3),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
                color: theme.scaffoldBackgroundColor,
              ),
              child: Hero(
                tag: 'pokemon-${pokemon.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    imageUrl: pokemon.imageUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Center(
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.catching_pokemon,
                      color: theme.primaryColor,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Pokemon name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                pokemon.name[0].toUpperCase() + pokemon.name.substring(1),
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            // Pokemon ID
            Text(
              '#${pokemon.id.toString().padLeft(3, '0')}',
              style: theme.textTheme.bodySmall?.copyWith(
                letterSpacing: 0.5,
              ),
            ),
            
            const SizedBox(height: 4),
            
            // Favorite button
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: theme.primaryColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: IconButton(
                onPressed: () {
                  favProvider.toggleFavorite(pokemon.id);
                },
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? theme.primaryColor : theme.iconTheme.color,
                  size: 20,
                ),
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
