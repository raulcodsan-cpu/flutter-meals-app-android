import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
    : super({
        //Here we are passing the initial state to the parent class.
        Filter.glutenFree: false,
        Filter.lactoseFree: false,
        Filter.vegetarian: false,
        Filter.vegan: false,
      });

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state, //We are copying the values of state (super() l13) and spreading them, as well as overwriting the passed values.
      filter: isActive,
    };
  }

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  bool getFilter(Filter filter) {
    return state[filter]!;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>((ref) {
      return FiltersNotifier();
    });

//To listen to other Providers, we can use the reference from Provider ((ref){})
//An example of a Provider that depends on other providers.
final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(
    mealsProvider,
  ); //we set a watch (which updates after there is a change) to get updated state data.
  final selectedFilters = ref.watch(
    filtersProvider,
  ); //If there is any change in any of the dependencies of the watched Providers, there will be an update.

  return meals.where((meal) {
    if (selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (selectedFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  });
});
