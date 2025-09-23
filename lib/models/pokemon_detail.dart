class PokemonDetail {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final Map<String, int> stats;
  final List<String> abilities;

  PokemonDetail({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.stats,
    required this.abilities,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    final types = (json['types'] as List)
        .map((e) => e['type']['name'] as String)
        .toList();

    final stats = <String, int>{};
    for (var s in (json['stats'] as List)) {
      stats[s['stat']['name']] = s['base_stat'];
    }

    final abilities = (json['abilities'] as List)
        .map((e) => e['ability']['name'] as String)
        .toList();

    final id = json['id'];
    final imageUrl =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';

    return PokemonDetail(
      id: id,
      name: json['name'],
      imageUrl: imageUrl,
      types: types,
      stats: stats,
      abilities: abilities,
    );
  }
}
