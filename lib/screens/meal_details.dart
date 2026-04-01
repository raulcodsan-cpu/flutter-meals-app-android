import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class MealDetails extends StatelessWidget {
  const MealDetails({required this.selectedMeal,required this.onToggleFavourite,super.key});
  final Meal selectedMeal;
  final void Function(Meal meal) onToggleFavourite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
        actions: [
          IconButton(onPressed: (){onToggleFavourite(selectedMeal);}, icon: Icon(Icons.star))
        ],
        ),
      body: SingleChildScrollView( //Another option for ListView (NOT .builder())
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
                padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 8),
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
