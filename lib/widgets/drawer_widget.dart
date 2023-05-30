import 'package:flutter/material.dart';

import '../screens/filtersScreen.dart';

class MainDrawer extends StatelessWidget {
  //const MainDrawer({Key? key}) : super(key: key);


  Widget buildListTile(String title, IconData icon, Function selectScreen){
    return ListTile(
      leading: Icon(icon, size: 26,),
      title: Text(title, style: TextStyle(
        fontSize: 24,
        fontFamily: 'RobotoCondensed',
        fontWeight: FontWeight.bold,
      ),),
      onTap: selectScreen,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).accentColor,
            alignment: Alignment.bottomLeft,
            child: Row(children: [
              Icon(Icons.food_bank_outlined, size: 35, color: Colors.green),
              SizedBox(width: 5,),
              Text('Cooking Up', style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 26,
                  color: Theme.of(context).primaryColor
              ),),
            ],)
          ),
          SizedBox(height: 20,),
          buildListTile(
              'Meal',
              Icons.restaurant, () {
                Navigator.of(context).pushReplacementNamed('/');
          }
          ),
          buildListTile(
              'Filters',
              Icons.settings, () {
                Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          }
          ),

        ],
      ),
    );
  }
}
