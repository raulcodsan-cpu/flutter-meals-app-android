import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:meals/providers/favourites_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/providers/filters_provider.dart';

Map<Filter, bool> kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  //we add the "Consumer-" to the class inheritance type to add functionality to reach to the provider
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    //Add Consumer - State...
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  //Add Consumer - State...
  int _selectedPageIndex = 0;
  //final List<Meal> _favouriteMeals = [];           //Unnecessary since we have created a Provider for the List<Meal> favourites
  /* Map<Filter,bool> _selectedFilters = {    --> removed so we can use Provider
    Filter.glutenFree : false,
    Filter.lactoseFree : false,
    Filter.vegetarian : false,
    Filter.vegan : false,
  }; */

  /* void _showInfoMessage(String message) {                   --> Method moved to meal_details.dart to work together with Provider.
    ScaffoldMessenger.of(context).clearSnackBars();                             //Function for showing bottom-popping snackbar                            
            ScaffoldMessenger.of(context,).showSnackBar(SnackBar(content: Text(message)));
  } */

  // void _toggleMealFavouriteStatus(Meal meal) {               --> This method is rendered useless since we have created a Provider with the same functionality
  //   final isExisting = _favouriteMeals.contains(meal);
  //   if (isExisting) {
  //     setState(() {
  //       _favouriteMeals.remove(meal);
  //       _showInfoMessage('Favourite removed');
  //     });
  //   } else {
  //     setState(() {
  //       _favouriteMeals.add(meal);
  //       _showInfoMessage('Favourite added');
  //     });
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    //async is used in order to used the data returned from .push(), included with await (l51) witch doesnt evaluate until the data is returned.
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      /* final result = */
      await Navigator.of(context).push<
        Map<Filter, bool>
      > //.push<value?>() is a generic method, where the returned value? is optional to set.
      (
        MaterialPageRoute(
          builder: (ctx) =>
              const FiltersScreen(/* currentFilters: _selectedFilters, */),
        ),
      ); //.push actually returns Future<> value as the data only returns after the user interacts with the pushed screen.

      /* setState(() {
        _selectedFilters = result??kInitialFilters;         //[??] operator checks if null, and returns the next value if true.
      }); */ //                         --> deleted to use Provider
    }
  }

  @override
  Widget build(BuildContext context) {
    /* final selectedFilters = ref.watch(filtersProvider);      --> availableMeals(filtered meals) moved to Provider
    //We call the provider to bring the selected filters

    final meals = ref.watch(mealsProvider);                 //ref. is similar to widget.    example of utilities: ref.read()[read only once] & ref.watch() [continuously listen for changes and most recommended]
                                                            //ref.watch() return the data type from the provider.
    final availableMeals = meals.where((meal){
    if(selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree){
      return false;
    }
    if(selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
      return false;
    }
    if(selectedFilters[Filter.vegetarian]! && !meal.isVegetarian){
      return false;
    }
    if(selectedFilters[Filter.vegan]! && !meal.isVegan){
      return false;
    }
    return true;
  }).toList(); */

    final availableMeals = ref.watch(filteredMealsProvider).toList();

    Widget activePage = CategoriesScreen(
      //onToggleFavourite: _toggleMealFavouriteStatus,     --> Change to Provider
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(
        favouriteMealsProvider,
      ); //We set a watcher to reach to the Provider (it is neccesary to declare ConsumerState [l18]) and returns its type (now List<Meal>)
      activePage = MealsScreen(
        meals: favouriteMeals,
        //onToggleFavourite: _toggleMealFavouriteStatus,        --> Removed as we are using a Provider
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
            _selectedPageIndex, //bottomNavigationBar needs to know which Index has been selected so it can highlight the selection.
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
