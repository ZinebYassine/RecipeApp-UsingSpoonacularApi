class Recipe {
  final int id;
  final String title;
  final String image;
  final String instructions; // Add instructions field

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.instructions,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      instructions: json['instructions'] ?? 'No instructions available.', // Parse instructions
    );
  }
}
