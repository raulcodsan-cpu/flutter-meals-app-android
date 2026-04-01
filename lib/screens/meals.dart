import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({required this.meals,required this.onToggleFavourite ,this.title, super.key});

  final String? title;   //We are making it optional because when MealsScreen is accessed through bottomNavigationBar, there are 2 Appbars.
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavourite;

  void _selectMeal(BuildContext context, Meal selectedMeal) {//A context argument is necessary for Navigator.
    Navigator.of(context).push(/*route*/     //Alternative: Navigator.push(context, route);
      MaterialPageRoute(
        builder: (ctx) => MealDetails(selectedMeal: selectedMeal,onToggleFavourite: onToggleFavourite,)
        ),
    );
  }


  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: meals.length,
      itemBuilder: (ctx, index) => MealItem(meal: meals[index],onSelectMeal: (meal){_selectMeal(context, meal);},)
        );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'No meals',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Select another category',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      );
    }

    if (title == null) {   //We are cheking if Title has been passed or not (access through the bottomNavigationBar yields no title).
      return content;
    }
    return Scaffold(
      appBar: AppBar(title: Text(title!)),   //We are conditionally checking if null above, so we can add !.
      body: content,
    );
  }
}
