class PokemonEntry {
  final int entryNumber;
  final String name;
  final int id;
  final String imageUrl;

  PokemonEntry({
    required this.entryNumber,
    required this.name,
    required this.id,
    required this.imageUrl,
  });

  factory PokemonEntry.fromJson(Map<String, dynamic> json) {
    final name = json["pokemon_species"]["name"];
    final url = json["pokemon_species"]["url"]; 
    // URL có dạng: https://pokeapi.co/api/v2/pokemon-species/1/
    final parts = url.split('/');
    final id = int.parse(parts[parts.length - 2]);

    return PokemonEntry(
      entryNumber: json["entry_number"],
      name: name,
      id: id,
      imageUrl:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png",
    );
  }
}
