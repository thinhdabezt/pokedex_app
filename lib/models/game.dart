class Game {
  final int id;
  final String name;
  final String versionGroup;
  final String generation;
  final List<String> versions;

  Game({
    required this.id,
    required this.name,
    required this.versionGroup,
    required this.generation,
    required this.versions,
  });

  factory Game.fromJson(Map<String, dynamic> versionJson, Map<String, dynamic> groupJson) {
    return Game(
      id: versionJson["id"],
      name: versionJson["name"],
      versionGroup: versionJson["version_group"]["name"],
      generation: groupJson["generation"]["name"],
      versions: (groupJson["versions"] as List)
          .map((v) => v["name"].toString())
          .toList(),
    );
  }
}
