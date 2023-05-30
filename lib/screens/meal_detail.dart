import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetails extends StatelessWidget {
  //const MealDetails({Key? key}) : super(key: key);
  static final routeName = '/Meal-Details';

  final Function toggleFavorite;
  final Function isFavorite;

  MealDetails(this.toggleFavorite, this.isFavorite);

  Widget buildTitleSection(BuildContext context, String text){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
  Widget buildContainer({Widget child}){
    return Container(
        decoration: BoxDecoration(
        color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 280,
              margin: EdgeInsets.only(right: 10, left: 10),
              width: double.infinity,
              child:  DropShadowImage(
                image: Image.network(selectedMeal.imageUrl, fit: BoxFit.cover),
                borderRadius: 5,
                blurRadius: 3,
                offset: Offset(5,5),
                scale: 1,
              ),

            ),
            buildTitleSection(context, 'Ingredients: '),
            buildContainer(
              child: ListView.builder(
                  itemCount: selectedMeal.ingredients.length,
                  itemBuilder: (ctx, index) => Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(selectedMeal.ingredients[index],),
                    ),
                  )
              ),
            ),
            buildTitleSection(context, 'Steps: '),
            buildContainer(
              child: ListView.builder(
                  itemCount: selectedMeal.steps.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('# ${index + 1}'),
                        ),
                        title: Text(
                          selectedMeal.steps[index],
                        ),
                      ),
                      Divider()
                    ],
                  ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
            isFavorite(mealId) ? Icons.star : Icons.star_border
        ),
        onPressed: () => toggleFavorite(mealId),
      ),
    );
  }
}