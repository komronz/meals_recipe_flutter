// ignore_for_file: missing_return

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './dummy_data.dart';
import '../screens/filtersScreen.dart';
import '../screens/meal_detail.dart';
import '../screens/tabs_screen.dart';
import 'models/meal.dart';


import 'screens/category_recipe_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten' : false,
    'vegan' : false,
    'vegetarian' : false,
    'lactose' : false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where(
              (meal) {
                if(_filters['gluten'] && !meal.isGlutenFree){
                  return false;
                }if(_filters['vegan'] && !meal.isVegan){
                  return false;
                }if(_filters['vegetarian'] && !meal.isVegetarian){
                  return false;
                }if(_filters['lactose'] && !meal.isLactoseFree){
                  return false;
                }
                return true;
              }).toList();
    });
  }

  Future<void> _toggleFavorite(String mealId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if(existingIndex >= 0){
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }else {
      setState(() async {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
        await prefs.setStringList('favorite_meals', _favoriteMeals.map((e) => e.toString()));
      });
    }
    setState(() {
      _favoriteMeals = prefs.getStringList('favorite_meals') as List<Meal>;
    });
    
  }


  bool _isMealFavorite(String id)  {


    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )
        )
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => TabsScreen(_favoriteMeals),
        FiltersScreen.routeName : (context) => FiltersScreen(_filters,_setFilters),
        CategoryRecipeScreen.routName : (context) => CategoryRecipeScreen(_availableMeals),
        MealDetails.routeName : (context) => MealDetails(_toggleFavorite,_isMealFavorite),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoryRecipeScreen(_availableMeals),);
      },
    );
  }
}