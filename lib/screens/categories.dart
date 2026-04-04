import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({/* required this.onToggleFavourite, */required this.availableMeals,super.key});
  //final void Function(Meal meal) onToggleFavourite;  --> Changed to Provider
  final List<Meal> availableMeals;

  //Normally func. are for settings States in StatefulWigt, but we can use to set Navigator in Stateless as we are managing the Screen Stack not the Widget
  void _selectCategory(BuildContext context, Category category) {//A context argument is necessary for Navigator.

    final filteredMeals = availableMeals.where((meal) => meal.categories.contains(category.id)).toList();

    Navigator.of(context).push(/*route*/     //Alternative: Navigator.push(context, route);
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          meals: 
              filteredMeals,
          title: category.title,
          //onToggleFavourite: onToggleFavourite,      --> Changed to provider
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return /* Scaffold(
      appBar: AppBar(title: Text('Pick your category')),
      body: */ GridView(
        //GridView.builder() is useful when there are many items and they have to be rendered dinamically.
        padding: EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              2, //Set no of columns, in this case 2 columns next to eachother.
          childAspectRatio: 3 / 2, //Set size of child size e.g. 1.5
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category
              in availableCategories) //for loop is an alternative of availableCategories.map((category) => CategoryGridItem(category: category)).toList()
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            ),
        ],
    );
  }
}
