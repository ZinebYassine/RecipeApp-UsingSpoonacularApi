import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/api_service.dart';

class RecipeProvider extends ChangeNotifier {
  List<Recipe> _recipes = [];
  List<Recipe> _randomRecipes = [];
  Recipe? _recipeDetails;

  Map<String, dynamic>? _dailyMealPlan;
  Map<String, dynamic>? _weeklyMealPlan;

  List<Recipe> get recipes => _recipes;
  List<Recipe> get randomRecipes => _randomRecipes;
  Recipe? get recipeDetails => _recipeDetails;

  Map<String, dynamic>? get dailyMealPlan => _dailyMealPlan;
  Map<String, dynamic>? get weeklyMealPlan => _weeklyMealPlan;

  // Fetch random recipes
  Future<void> fetchRandomRecipes() async {
    try {
      _randomRecipes = await ApiService.fetchRandomRecipes();
      notifyListeners();
    } catch (error) {
      print('Error fetching random recipes: $error');
    }
  }

  // Fetch recipes by category
  Future<void> fetchRecipesByCategory(String category) async {
    try {
      _recipes = await ApiService.fetchRecipesByCategory(category);
      notifyListeners();
    } catch (error) {
      print('Error fetching recipes by category: $error');
    }
  }

  // Fetch recipes by ingredients
  Future<void> fetchRecipes(String ingredients) async {
    try {
      _recipes = await ApiService.fetchRecipesByIngredients(ingredients);
      notifyListeners();
    } catch (error) {
      print('Error fetching recipes by ingredients: $error');
    }
  }

  // Fetch recipe details
  Future<void> fetchRecipeDetails(int recipeId) async {
    try {
      _recipeDetails = await ApiService.fetchRecipeDetails(recipeId);
      notifyListeners();
    } catch (error) {
      print('Error fetching recipe details: $error');
    }
  }

  // Fetch daily meal plan
  Future<void> fetchDailyMealPlan(String diet) async {
    try {
      _dailyMealPlan = await ApiService.fetchDailyMealPlan(diet);
      notifyListeners();
    } catch (error) {
      print('Error fetching daily meal plan: $error');
    }
  }

  // Fetch weekly meal plan
  Future<void> fetchWeeklyMealPlan(String diet) async {
    try {
      _weeklyMealPlan = await ApiService.fetchWeeklyMealPlan(diet);
      notifyListeners();
    } catch (error) {
      print('Error fetching weekly meal plan: $error');
    }
  }
}
