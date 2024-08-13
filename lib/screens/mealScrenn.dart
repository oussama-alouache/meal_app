import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/mealdetailsScreen.dart';
import 'package:meal_app/widgets/mealcard/meal_item.dart';

class Mealscrenn extends StatelessWidget {
  const Mealscrenn({
    super.key,
    this.title,
    required this.meals,
    required this.ontoggleMealFavortie,
  });
  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) ontoggleMealFavortie;
  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Mealdetailsscreen(
          meal: meal,
          ontoggleMealFavortie: ontoggleMealFavortie,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          onselecetmeal: (Meal meal) {
            selectMeal(context, meal);
          },
        ),
      );
    }
    if (title == null) {
      return content;
    }
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
