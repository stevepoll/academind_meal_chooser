import 'package:flutter/material.dart';
import 'package:meal_chooser/models/meal.dart';
import 'package:meal_chooser/screens/categories_screen.dart';
import 'package:meal_chooser/screens/favorites_screen.dart';
import 'package:meal_chooser/widgets/main_drawer.dart';

class TabsBottomScreen extends StatefulWidget {
  final List<Meal> favorites;

  TabsBottomScreen(this.favorites);

  @override
  _TabsBottomScreenState createState() => _TabsBottomScreenState();
}

class _TabsBottomScreenState extends State<TabsBottomScreen> {
  final List<Map<String, dynamic>> _pages = [];

  int _selectedPageIndex = 0;

  _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages.add({'page': CategoriesScreen(), 'title': 'Categories'});
    _pages.add({'page': FavoritesScreen(widget.favorites), 'title': 'Faves'});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 80,
        title: Text('Meals - ${_pages[_selectedPageIndex]['title']}'),
        centerTitle: false,
      ),
      body: _pages[_selectedPageIndex]['page'],
      drawer: MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorites'),
          ),
        ],
      ),
    );
  }
}
