import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/drawer_widget.dart';
import '../screens/categories_screen.dart';
import 'favourite_screen.dart';


class TabsScreen extends StatefulWidget {
 // const TabsSreen({Key? key}) : super(key: key);
  final List<Meal> favoriteMeals;

  TabsScreen(this.favoriteMeals);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}


class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _Pages;

  int _selectedPage = 0;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

    });

    _Pages = [
      {'page' : Categories_list(), 'title' : 'Categories'},
      {'page' : Favorites(widget.favoriteMeals), 'title' : 'My favorite'}
    ];
  }


  void _tabSelected(int index){
    setState(() {
      _selectedPage = index;
    });
    print(_selectedPage);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${_Pages[_selectedPage]['title']}'),
      ),
      drawer: MainDrawer(),
      body: _Pages[_selectedPage]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _tabSelected,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPage,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(backgroundColor: Theme.of(context).primaryColor, icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(backgroundColor: Theme.of(context).primaryColor, icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
