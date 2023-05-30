import 'package:flutter/material.dart';
import '../screens/category_recipe_screen.dart';

class Category_item extends StatelessWidget {
  //const Category_item({Key? key}) : super(key: key);
  final String id;
  final String title;
  final String image;
  Category_item(this.id, this.title, this.image);

  void toRecipeScreen(BuildContext ctx){
    Navigator.of(ctx).pushNamed(
        CategoryRecipeScreen.routName, arguments: {
      'id' : id,
      'title' : title
    });
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => toRecipeScreen(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.pink.withOpacity(1),
                  spreadRadius: 4,
                  blurRadius: 6,
                  offset: Offset(4,4), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Image.asset('assets/images/${image}', height: 250, width: double.infinity, fit: BoxFit.cover),
              ),
              Positioned(
                left: 0,
                top: 20,
                child: Container(
                  width: 200,
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
        ),

      ),
    );
  }
}
