import 'dart:ffi';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/filter_provider.dart';
import 'package:meal_app/providers/meals_provider.dart';

class FavoriteMealProviderNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealProviderNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealsFavorite = state.contains(meal);
    if (mealsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final FavoriteMealProvider =
    StateNotifierProvider<FavoriteMealProviderNotifier, List<Meal>>(
  (ref) {
    return FavoriteMealProviderNotifier();
  },
);

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealprovider);
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
