import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/mealScrenn.dart';
import 'package:meal_app/widgets/category_grid_item.dart';

class Categoriesscrenn extends StatelessWidget {
  const Categoriesscrenn(
      {super.key,
      required this.ontoggleMealFavortie,
      required this.availibleMeals});
  final void Function(Meal meal) ontoggleMealFavortie;
  final List<Meal> availibleMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availibleMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Mealscrenn(
          title: category.title,
          meals: filteredMeals,
          ontoggleMealFavortie: ontoggleMealFavortie,
        ),
      ),
    ); // Navigator.push(context, route)
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onselectcategorie: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}
