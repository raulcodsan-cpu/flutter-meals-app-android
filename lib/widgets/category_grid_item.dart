import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({required this.category, required this.onSelectCategory, super.key});
  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(                                     //To make a Widget tappable, you can also use GestureDetector(), but InkWell() gives visual feedback
      onTap: onSelectCategory,        
      splashColor: Theme.of(context).primaryColor,                
      borderRadius: BorderRadius.circular(16),          //To get rounded corners.
      child: Container(                                 //Container lets you choose many background options.
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),      //OnTap of InkWell() has a splashColor of rounded corners, so we match it
          gradient: LinearGradient(
            colors: [
              category.color.withValues(alpha: 0.55),
              category.color.withValues(alpha: 0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
