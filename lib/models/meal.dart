import 'package:flutter/foundation.dart';

import 'enums/enums.dart';


 class Meal{
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final bool isGlutenFree;
  final bool isVegan;
  final bool isVegetarian;
  final bool isLactoseFree;
  final Complexity complexity;
  final Affordability affordability;


  const Meal({
    @required this.id,
    @required this.affordability,
    @required this.complexity,
    @required this.categories,
    @required this.title,
    @required this.duration,
    @required this.imageUrl,
    @required this.ingredients,
    @required this.isGlutenFree,
    @required this.isLactoseFree,
    @required this.isVegan,
    @required this.isVegetarian,
    @required this.steps
  });


 }