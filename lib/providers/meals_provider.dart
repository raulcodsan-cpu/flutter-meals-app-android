import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';

//This is a simple Provider where we return meals data.
final mealsProvider = Provider((ref) {
  //"Provides" a dynamic value that can listen to changes
  return dummyMeals; //Its generally used for dynamic data and cross-widget states
});
