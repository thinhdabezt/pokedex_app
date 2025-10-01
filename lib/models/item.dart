class Item {
  final int id;
  final String name;
  final int cost;
  final String category;
  final String? effect;
  final String imageUrl;

  Item({
    required this.id,
    required this.name,
    required this.cost,
    required this.category,
    this.effect,
    required this.imageUrl,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json["id"],
      name: json["name"],
      cost: json["cost"],
      category: json["category"]["name"],
      effect: (json["effect_entries"] as List).isNotEmpty
          ? json["effect_entries"][0]["short_effect"]
          : null,
      imageUrl: json["sprites"]["default"] ??
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/unknown.png",
    );
  }
}
