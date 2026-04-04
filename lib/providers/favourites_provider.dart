import 'package:meals/models/meal.dart';
import 'package:flutter_riverpod/legacy.dart';

//This is a more complex provider, made a class to add functions.
class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  //An StateNotifier is required to instanciate an SateNotifierProvider().
  FavouriteMealsNotifier() : super([]);
  //We initialize the class with an inizialitation list, and with super() we call the parent class with the inital state of data of same type as SateNotifier<dataType>
  //We are not allowed to reach to the data in super(data), so we can not call .add() or .remove()

  bool toggleMealFavouriteState(Meal meal) {
    //We return bool for the bottom snackbar message to change depending if added or not.

    final mealIsFavourite = state.contains(
      meal,
    ); //.contains() doesnt change the [state] but only reads it.

    if (mealIsFavourite) {
      //[state] is a property made available by StateNotifier, which helps us replace the data in super(data), as we are not able to change it only to replace it.
      /* If the argument meal is already fav., we pass every meal which is not
      the same as the argument (element.id != meal.id) to remove it from the list */
      state = state
          .where((element) => element.id != meal.id)
          .toList(); //.where() creates a new filtered list based on the first one, so it is allowed.
      return false;
      //In this case, as declared in StateNotifier<List<Meal>>, the data type of [state] is List<Meal>.
    } else {
      state = [
        ...state,
        meal,
      ]; //we are creating an anonymous list [] and spreading (...) inside all elements of the list [state] and addind meal at the end.
      return true;
    }
  }
}

//For static data, [Provider()] (like in meals_provider.dart) is very useful, but in case of complex dynamic data it is better the StateNotifierProvider().
final favouriteMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>((ref) {
      //It is necessary to declary the types for the generic funtion <Notifier, ReturnType>.
      return FavouriteMealsNotifier();
    });
//Every time favouriteMealsProvider is called from this declaration, the class FavouriteMealsNotifier gets returned to GET or SET data.
