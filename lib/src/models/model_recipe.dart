class RecipeModel {
  String name;
  String imageUrl;
  List<String> ingredients;
  List<String> steps;
  String ytLink;
  bool isliked;
  String category;
  String description;
  String cookingTime;
  RecipeModel(
      {required this.name,
      required this.imageUrl,
      required this.ingredients,
      required this.steps,
      required this.ytLink,
      this.isliked = false,
      required this.description,
      required this.cookingTime,
      required this.category});

  factory RecipeModel.fromFirestore(Map<String, dynamic>? data) {
    if (data == null) {
      // Handle if there's no data or it's null
      return RecipeModel(
        name: '',
        imageUrl: '',
        ingredients: [],
        steps: [],
        ytLink: '',
        description: '',
        cookingTime: '',
        category: '',
      );
    }

    return RecipeModel(
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      ingredients: List<String>.from(data['ingredients'] ?? []),
      steps: List<String>.from(data['steps'] ?? []),
      ytLink: data['ytLink'] ?? '',
      description: data['description'] ?? '',
      cookingTime: data['cookingTime'] ?? '',
      category: data['category'] ?? '',
    );
  }
}
