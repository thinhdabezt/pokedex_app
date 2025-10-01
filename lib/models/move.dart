class Move {
  final int id;
  final String name;
  final int? power;
  final int? pp;
  final int? accuracy;
  final String type;
  final String damageClass;
  final String? effect;

  Move({
    required this.id,
    required this.name,
    this.power,
    this.pp,
    this.accuracy,
    required this.type,
    required this.damageClass,
    this.effect,
  });

  factory Move.fromJson(Map<String, dynamic> json) {
    return Move(
      id: json["id"],
      name: json["name"],
      power: json["power"],
      pp: json["pp"],
      accuracy: json["accuracy"],
      type: json["type"]["name"],
      damageClass: json["damage_class"]["name"],
      effect: (json["effect_entries"] as List).isNotEmpty
          ? json["effect_entries"][0]["short_effect"]
          : null,
    );
  }
}
