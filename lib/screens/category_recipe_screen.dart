import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryRecipeScreen extends StatefulWidget {

  static final routName = '/category-recipe';

  final List<Meal> availableMeals;

  CategoryRecipeScreen(this.availableMeals);

  @override
  State<CategoryRecipeScreen> createState() => _CategoryRecipeScreenState();
}

class _CategoryRecipeScreenState extends State<CategoryRecipeScreen> {
  String categoryTitle;
  List<Meal> categoryMeals;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(!_loadedInitData){
      final routeArgs = ModalRoute.of(context).settings.arguments as Map;
      final String categoryId = routeArgs['id'];
      categoryTitle = routeArgs['title'];
      categoryMeals = widget.availableMeals.where((element) {
        return element.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeId(String mealId){
    setState(() {
      categoryMeals.removeWhere((element) => element.id == mealId);
    });
  }

  // final String id;z
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
          itemCount: categoryMeals.length,
          itemBuilder: (ctx, index) {
            return MealItem(
              id: categoryMeals[index].id,
              title: categoryMeals[index].title,
              imageUrl: categoryMeals[index].imageUrl,
              duration: categoryMeals[index].duration,
              affordability: categoryMeals[index].affordability,
              complexity: categoryMeals[index].complexity,
              //removeId: _removeId,
            );
          },
      ),
    );
  }
}
