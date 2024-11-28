import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import 'recipe_detail_screen.dart';

class MealPlanScreen extends StatefulWidget {
  @override
  _MealPlanScreenState createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  @override
  void initState() {
    super.initState();
    _loadMealPlan();
  }

  void _loadMealPlan() {
    final provider = Provider.of<RecipeProvider>(context, listen: false);
    provider.fetchDailyMealPlan('vegetarian'); // Fetch daily meal plan only
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RecipeProvider>(context);
    final mealPlan = provider.dailyMealPlan;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Meal Planning",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background gradient matching HomeScreen
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Color(0xFFFFD6D6)], // White to light red
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          mealPlan == null
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 100),

                        // Nutritional Breakdown Section
                        if (mealPlan['nutrients'] != null) ...[
                        
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildNutrientCard(
                                  "Calories",
                                  "${mealPlan['nutrients']['calories']} kcal",
                                  Icons.local_fire_department,
                                  Colors.redAccent,
                                ),
                                _buildNutrientCard(
                                  "Protein",
                                  "${mealPlan['nutrients']['protein']} g",
                                  Icons.fitness_center,
                                  Colors.blueAccent,
                                ),
                                _buildNutrientCard(
                                  "Carbs",
                                  "${mealPlan['nutrients']['carbohydrates']} g",
                                  Icons.bubble_chart,
                                  Colors.orange,
                                ),
                                _buildNutrientCard(
                                  "Fats",
                                  "${mealPlan['nutrients']['fat']} g",
                                  Icons.restaurant,
                                  Colors.green,
                                ),
                              ],
                            ),
                          ),
                        ],

                        const SizedBox(height: 20),

                        // Regenerate Button
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              _loadMealPlan(); // Regenerate meal plan
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              "Regenerate Plan",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Meals Section Title
                       
                        // No Space After Meals Title
                        ...mealPlan['meals'].map<Widget>((meal) {
                          return Column(
                            children: [
                              _buildMealCard(
                                meal['id'],
                                meal['title'],
                                meal['readyInMinutes'],
                              ),
                              const SizedBox(height: 10), // Space between meals
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  // Nutrient Card Widget
  Widget _buildNutrientCard(String label, String value, IconData icon, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          radius: 25,
          child: Icon(icon, size: 30, color: color),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  // Meal Card Widget
  Widget _buildMealCard(int id, String title, int readyInMinutes) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            'https://spoonacular.com/recipeImages/$id-312x231.jpg',
            width: 70,
            height: 70,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.image_not_supported),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          'Ready in $readyInMinutes minutes',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.redAccent),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailScreen(recipeId: id),
            ),
          );
        },
      ),
    );
  }
}
