import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/categoriesScrenn.dart';
import 'package:meal_app/screens/filterScreen.dart';
import 'package:meal_app/screens/mealScrenn.dart';
import 'package:meal_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class Tapbar extends StatefulWidget {
  const Tapbar({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<Tapbar> createState() {
    return _TapbarState();
  }
}

class _TapbarState extends State<Tapbar> {
  // ignore: non_constant_identifier_names
  int _SelectedPageIndex = 0;
  final List<Meal> _favoritemeal = [];
  Map<Filter, bool> _selectedFliters = kInitialFilters;
  void toggleMealFavoriteStatues(Meal meal) {
    final isexistind = _favoritemeal.contains(meal);
    if (isexistind) {
      setState(() {
        _favoritemeal.remove(meal);
      });
    } else {
      setState(() {
        _favoritemeal.add(meal);
      });
    }
    print(_favoritemeal);
  }

  void _selectedpage(int index) {
    setState(() {
      _SelectedPageIndex = index;
    });
  }

  void _setselectscreen(String idantifer) async {
    if (idantifer == "Filters") {
      Navigator.of(context).pop();
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => Filterscreen(
            currentFilters: _selectedFliters,
          ),
        ),
      );
      setState(() {
        _selectedFliters = result ?? kInitialFilters;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFliters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFliters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFliters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFliters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget activeScrenn = Categoriesscrenn(
      ontoggleMealFavortie: toggleMealFavoriteStatues,
      availibleMeals: availableMeals,
    );
    var activeScrennTitle = 'categorie';
    if (_SelectedPageIndex == 1) {
      activeScrenn = Mealscrenn(
        meals: _favoritemeal,
        ontoggleMealFavortie: toggleMealFavoriteStatues,
      );
      activeScrennTitle = 'your favorite';
    }
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(activeScrennTitle),
      ),
      drawer: MainDrawer(
        onselectscreen: _setselectscreen,
      ),
      body: activeScrenn,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _SelectedPageIndex,
        onTap: _selectedpage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.star), label: 'Your favorites'),
        ],
      ),
    );
  }
}
