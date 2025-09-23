class PokemonListItem {
  final String name;
  final String url;
  final int id;
  final String imageUrl;

  PokemonListItem({
    required this.name,
    required this.url,
    required this.id,
    required this.imageUrl,
  });

  factory PokemonListItem.fromJson(Map<String, dynamic> json) {
    final url = json['url'] as String;

    final parts = url.split('/');
    final id = int.parse(parts[parts.length - 2]);

    final imageUrl =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';

    return PokemonListItem(
      name: json['name'],
      url: url,
      id: id,
      imageUrl: imageUrl,
    );
  }
}
