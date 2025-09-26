class EvolutionStage {
  final String name;
  final int id;
  final String imageUrl;

  EvolutionStage({
    required this.name,
    required this.id,
    required this.imageUrl,
  });

  factory EvolutionStage.fromSpeciesUrl(String name, String url) {
    final parts = url.split('/');
    final id = int.parse(parts[parts.length - 2]);

    return EvolutionStage(
      name: name,
      id: id,
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
    );
  }
}

class EvolutionChain {
  final List<EvolutionStage> stages;

  EvolutionChain({required this.stages});

  factory EvolutionChain.fromJson(Map<String, dynamic> json) {
    final List<EvolutionStage> stages = [];

    void parseChain(Map<String, dynamic> chain) {
      final species = chain['species'];

      stages.add(
        EvolutionStage.fromSpeciesUrl(species['name'], species['url']),
      );

      final evolvesTo = chain['evolves_to'] as List?;
      if (evolvesTo != null && evolvesTo.isNotEmpty) {
        parseChain(evolvesTo[0]);
      } 
    }

    parseChain(json['chain']);
    return EvolutionChain(stages: stages);
  }
}
