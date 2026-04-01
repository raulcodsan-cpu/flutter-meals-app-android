import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:flutter/material.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

Map<Filter,bool> kInitialFilters = {
    Filter.glutenFree : false,
    Filter.lactoseFree : false,
    Filter.vegetarian : false,
    Filter.vegan : false,
  };

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favouriteMeals = [];
  Map<Filter,bool> _selectedFilters = {
    Filter.glutenFree : false,
    Filter.lactoseFree : false,
    Filter.vegetarian : false,
    Filter.vegan : false,
  };
  

  void _showInfoMessage(String message) {  //Function for showing bottom-popping snackbar
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
       context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavouriteStatus(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favouriteMeals.remove(meal);
        _showInfoMessage('Favourite removed');
      });
    } else {
      setState(() {
        _favouriteMeals.add(meal);
        _showInfoMessage('Favourite added');
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {    //async is used in order to used the data returned from .push(), included with await (l51) witch doesnt evaluate until the data is returned.
    Navigator.of(context).pop();
    if (identifier=='filters') {
      final result = await Navigator.of(context).push<Map<Filter,bool>>                 //.push<value?>() is a generic method, where the returned value? is optional to set.
      (MaterialPageRoute(builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters,)));   //.push actually returns Future<> value as the data only returns after the user interacts with the pushed screen.

      setState(() {
        _selectedFilters = result??kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final availableMeals = dummyMeals.where((meal){
    if(_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree){
      return false;
    }
    if(_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
      return false;
    }
    if(_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian){
      return false;
    }
    if(_selectedFilters[Filter.vegan]! && !meal.isVegan){
      return false;
    }
    return true;
  }).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavourite: _toggleMealFavouriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favouriteMeals,
        onToggleFavourite: _toggleMealFavouriteStatus,
      ); //We set the argument Title to optional so the appBar is not shown twice.
      activePageTitle = 'Your favourites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      drawer: MainDrawer(onSelectScreen: _setScreen),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex:
            _selectedPageIndex, //bottomNavigationBar needs to know which Index has bees selected so it can highlight the selection.
        items: [
          //List of objects to tap.
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites'),
        ],
      ),
    );
  }
}
