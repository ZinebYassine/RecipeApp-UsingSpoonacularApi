import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';
import '../utils/constants.dart';

class ApiService {
  // Fetch random recipes
  static Future<List<Recipe>> fetchRandomRecipes() async {
    final url = Uri.parse(
        'https://api.spoonacular.com/recipes/random?number=10&apiKey=$spoonacularApiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['recipes'] as List)
          .map((recipe) => Recipe.fromJson(recipe))
          .toList();
    } else {
      throw Exception('Failed to load random recipes');
    }
  }

  // Fetch recipes by category
  static Future<List<Recipe>> fetchRecipesByCategory(String category) async {
    final url = Uri.parse(
        'https://api.spoonacular.com/recipes/complexSearch?diet=$category&apiKey=$spoonacularApiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List)
          .map((recipe) => Recipe.fromJson(recipe))
          .toList();
    } else {
      throw Exception('Failed to load recipes by category');
    }
  }

  // Fetch recipes by ingredients
  static Future<List<Recipe>> fetchRecipesByIngredients(
      String ingredients) async {
    final url = Uri.parse(
        'https://api.spoonacular.com/recipes/findByIngredients?ingredients=$ingredients&apiKey=$spoonacularApiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data as List).map((recipe) => Recipe.fromJson(recipe)).toList();
    } else {
      throw Exception('Failed to load recipes by ingredients');
    }
  }

  // Fetch details of a single recipe
  static Future<Recipe> fetchRecipeDetails(int id) async {
    final url = Uri.parse(
        'https://api.spoonacular.com/recipes/$id/information?apiKey=$spoonacularApiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Recipe.fromJson(data);
    } else {
      throw Exception('Failed to load recipe details');
    }
  }

  // Fetch a meal plan for a day
  static Future<Map<String, dynamic>> fetchDailyMealPlan(String diet) async {
    final url = Uri.parse(
        'https://api.spoonacular.com/mealplanner/generate?timeFrame=day&diet=$diet&apiKey=$spoonacularApiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data; // Contains meals and nutrients
    } else {
      throw Exception('Failed to fetch daily meal plan');
    }
  }

  // Fetch a meal plan for a week
  static Future<Map<String, dynamic>> fetchWeeklyMealPlan(String diet) async {
    final url = Uri.parse(
        'https://api.spoonacular.com/mealplanner/generate?timeFrame=week&diet=$diet&apiKey=$spoonacularApiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data; // Contains meals and nutrients
    } else {
      throw Exception('Failed to fetch weekly meal plan');
    }
  }
}
