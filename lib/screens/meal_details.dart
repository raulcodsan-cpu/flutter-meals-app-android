import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favourites_provider.dart';

class MealDetails extends ConsumerWidget {
  //Change from Stateless- to Consumer- to use Provider for FavouriteMeals
  const MealDetails({
    required this.selectedMeal,
    super.key /* required this.onToggleFavourite, */,
  });
  final Meal selectedMeal;
  //final void Function(Meal meal) onToggleFavourite;  --> Changed to Provider

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //For StatelessWidgets we need to add WidgetRef to builder.
    //In StatefulWidgets we have the ConsumerState<state> to handle this.

    final favouriteMeals = ref.watch(
      favouriteMealsProvider,
    ); //We asign to local value the current state from Provider.

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favouriteMealsProvider.notifier)
                  .toggleMealFavouriteState(
                    selectedMeal,
                  ); //Calling provider.notifier lets us call the methods defined in the class.
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    wasAdded ? 'Favourite Added' : 'Favourite Deleted',
                  ),
                ),
              );
            },
            icon: Icon(
              favouriteMeals.contains(
                    selectedMeal,
                  ) //We are calling a Provider to check state of FavouriteMeals
                  ? Icons.star
                  : Icons.star_border,
            ),
          ), //We dont use .watch but .read to read only once as it is an Stateless Widget
        ],
      ),
      body: SingleChildScrollView(
        //Another option for ListView (NOT .builder())
        child: Column(
          children: [
            Image.network(
              //when the image is loaded, it doenst just pop up, it loads fading in.
              selectedMeal.imageUrl,
              fit: BoxFit
                  .cover, //This adjusts image size to be as small as possible while still covering the box it is included.
              height: 300,
              width: double
                  .infinity, //The image will use as much width as possible, without being distorted thanks to BoxFit.cover,
            ),
            const SizedBox(height: 14),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 14),
            for (final ingredients in selectedMeal.ingredients)
              Text(
                ingredients,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 24),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            for (final steps in selectedMeal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 8,
                ),
                child: Text(
                  steps,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
