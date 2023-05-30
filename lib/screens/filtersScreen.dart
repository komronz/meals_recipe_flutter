import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart';

class FiltersScreen extends StatefulWidget {
  //const FiltersScreen({Key? key}) : super(key: key);
  static final routeName = '/FiltersScreen';
  final Function _setFilters;
  final Map<String, bool> currentFilters;
  FiltersScreen(this.currentFilters, this._setFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool isGlutenFree = false;
  bool isVegan = false;
  bool isVegetarian = false;
  bool isLactoseFree = false;


  @override
  void initState() {
    isGlutenFree = widget.currentFilters['gluten'];
    isVegan = widget.currentFilters['vegan'];
    isVegetarian = widget.currentFilters['vegetarian'];
    isLactoseFree = widget.currentFilters['lactose'];
    super.initState();
  }


  Widget buildSwitchTile(
      String title,
      String subtitle,
      bool currentValue,
      Function updateValue,
      ){
    return SwitchListTile(
        title: Text(title),
        //Text('Gulten-free'),
        subtitle: Text(subtitle),
        //Text('Only include gulten-free meals.'),
        value: currentValue,
        onChanged: updateValue,

    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Filters'),
        actions: [
          IconButton(
              onPressed: () {
                final selectedFilters = {
                  'gluten' : isGlutenFree,
                  'vegan' : isVegan,
                  'vegetarian' : isVegetarian,
                  'lactose' : isLactoseFree,
                };
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Saved...', textAlign: TextAlign.center, style: TextStyle(color: Color.fromRGBO(255, 254, 229, 1)),),
                    duration: Duration(seconds: 1),
                  ),
                );
                widget._setFilters(selectedFilters);
              }, icon: Icon(Icons.save))
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text('Adjust your meal selection.',
            style: Theme.of(context).textTheme.headline6,),
          ),
          Expanded(child: ListView(
            children: [
              buildSwitchTile('Gulten-free', 'Only include gulten-free meals.', isGlutenFree, (result) {
                setState(() {
                  isGlutenFree = result;
                });
              }),
              buildSwitchTile('Lactose-free', 'Only include Lactose-free meals.', isLactoseFree, (result) {
                setState(() {
                  isLactoseFree = result;
                });
              }),
              buildSwitchTile('Vegan', 'Only include vega meals.', isVegan, (result) {
                setState(() {
                  isVegan = result;
                });
              }),
              buildSwitchTile('Vegetarian', 'Only include vegetarian meals.', isVegetarian, (result) {
                setState(() {
                  isVegetarian = result;
                });
              }),
            ],
          ))
        ],
      ),
    );
  }
}
