import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meal_app/providers/favorite_meal_provider_notifier.dart';
import 'package:meal_app/providers/filter_provider.dart';
import 'package:meal_app/providers/meals_provider.dart';
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

class Tapbar extends ConsumerStatefulWidget {
  const Tapbar({super.key});

  @override
  // ignore: no_logic_in_create_state
  ConsumerState<Tapbar> createState() {
    return _TapbarState();
  }
}

class _TapbarState extends ConsumerState<Tapbar> {
  // ignore: non_constant_identifier_names
  int _SelectedPageIndex = 0;

  void _selectedpage(int index) {
    setState(() {
      _SelectedPageIndex = index;
    });
  }

  void _setselectscreen(String idantifer) async {
    if (idantifer == "Filters") {
      Navigator.of(context).pop();
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => Filterscreen(),
        ),
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activeScrenn = Categoriesscrenn(
      availibleMeals: availableMeals,
    );
    var activeScrennTitle = 'categorie';
    if (_SelectedPageIndex == 1) {
      final favoritemeal = ref.watch(FavoriteMealProvider);
      activeScrenn = Mealscrenn(
        meals: favoritemeal,
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
              icon: Icon(Icons.set_meal),
              label: 'categories',
              activeIcon: Icon(
                Icons.set_meal,
                color: Colors.blue,
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Your favorites',
              activeIcon: Icon(
                Icons.star,
                color: Colors.blue,
              )),
        ],
      ),
    );
  }
}
