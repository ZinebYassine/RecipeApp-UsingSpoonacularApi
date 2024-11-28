class MealPlan {
  final String id;
  final String name;
  final List<MealPlanItem> items; // List of recipes or meals

  MealPlan({required this.id, required this.name, required this.items});
}

class MealPlanItem {
  final String recipeId;
  final String mealType; // Breakfast, Lunch, Dinner, etc.
  final DateTime date;

  MealPlanItem({required this.recipeId, required this.mealType, required this.date});
}
