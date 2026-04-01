import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({required this.meal,required this.onSelectMeal, super.key});
  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  String get complexityText{
    return meal.complexity.name[0].toUpperCase() + meal.complexity.name.substring(1);
  }

  String get affordabilityText{
    return meal.affordability.name[0].toUpperCase() + meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),    //It adds separation between cards, in this case the list.
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8)),
      clipBehavior: Clip.hardEdge,        //As the RoundedBorder is ignored by the Stack(), this ensures all borders surpasing the shape are cut off.
      elevation: 2,
      child: 
        InkWell(                //We are using InkWell to recreate the effect from the CategoryScreen.
          onTap: (){onSelectMeal(meal);},
          child: Stack(                          //With Stack(), we can position widgets directly on top of eachother (like an image and text right in front of it).
            children: [                         //1st widget will be at the bottom of the stack.
                FadeInImage(                                           //when the image is loaded, it doenst just pop up, it loads fading in.
                  placeholder: MemoryImage(kTransparentImage),       //MemoryImage loads an image from memory? Used to load transparentImages from package: transparent_images.
                  image: NetworkImage(meal.imageUrl),      
                  fit: BoxFit.cover,                                //This adjusts image size to be as small as possible while still covering the box it is included.
                  height: 200,                                     //This is to avoid the "jump" that happens when the image loads and occupies space.
                  width: double.infinity,                         //The image will use as much width as possible, without being distorted thanks to BoxFit.cover,
                  ),  
                Positioned(
                  bottom: 0,   //distance to the border of the bottom widget. bottom: 0  is 0 distance to the bottom border.
                  left: 0,    //In this case, we are bounding the Container() to 0 distance to bottom, left & right border.
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 40),
                    color: Colors.black54,      //Color black with some transparency.
                    child: Column(                //We are displaying the title and under it the metadata
                      children: [
                        Text(
                          meal.title,
                          maxLines: 2, 
                          textAlign: TextAlign.center,
                          softWrap: true,                    //WTF is wrapping?
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 12,),
                              MealItemTrait(icon: Icons.schedule, label: '${meal.duration} min'),     //This widget is a Row() Inside a Row(), but it is constrained by Positioned() so it works.
                              const SizedBox(width: 12,),
                              MealItemTrait(icon: Icons.work, label: complexityText),
                              const SizedBox(width: 12,),
                              MealItemTrait(icon: Icons.attach_money, label: affordabilityText),
                            ],
                          )
                        ],
                    ),
                  ),
                  ),
            ],
          ),
      )
      );
  }
}
