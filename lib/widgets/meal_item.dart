import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import '../models/enums/enums.dart';
import '../models/meal.dart';
import '../screens/meal_detail.dart';


class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  MealItem({
  @required this.id,
  @required this.title,
  @required this.imageUrl,
  @required this.duration,
  @required this.complexity,
  @required this.affordability,
  });
  //const MealItem({Key? key}) : super(key: key);
  String get complexityText{
    switch(complexity){
      case Complexity.Simple:
        return 'simple';
        break;
      case Complexity.Challenging:
        return 'challenging';
        break;
      case Complexity.Hard:
        return 'hard';
        break;
    }
  }
  String get affordabilityText{
    switch(affordability){
      case Affordability.Affordable:
        return 'affordable';
        break;
      case Affordability.Pricey:
        return 'pricey';
        break;
      case Affordability.Luxurious:
        return 'luxurious';
        break;
    }
  }

  void toDetailedScreen(BuildContext context){
    Navigator.of(context).pushNamed(
        MealDetails.routeName,
        arguments: id,
    ).then((value) {
      if(value != null){
        //removeId(value);
        print(value);
      }
    });
  }

  Widget buildRow(IconData iconData, String text){
    return Row(
      children: [
        Icon(iconData, color: Colors.white,),
        SizedBox(width: 5,),
        Text(text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => toDetailedScreen(context),
      child: Card(
        color: Colors.pink,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(imageUrl, height: 250, width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: Container(
                    width: 250,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      title, style: TextStyle(color: Colors.white, fontSize: 26,fontWeight: FontWeight.bold,),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),

              ],
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildRow(Icons.schedule, '${duration} min'),
                    buildRow(Icons.work, '${complexityText}'),
                    buildRow(Icons.attach_money, '${affordabilityText}'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


