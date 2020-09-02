import 'package:flutter/material.dart';
import 'package:meal_chooser/screens/categories_screen.dart';
import 'package:meal_chooser/screens/favorites_screen.dart';

class TabsTopScreen extends StatefulWidget {
  @override
  _TabsTopScreenState createState() => _TabsTopScreenState();
}

class _TabsTopScreenState extends State<TabsTopScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: Text('Meals'),
          bottom: TabBar(tabs: [
            Tab(
              child: Row(
                children: [
                  Icon(Icons.category),
                  SizedBox(width: 15),
                  Text('Categories'),
                ],
              ),
              // icon: Icon(Icons.category),
              // text: 'Categories',
            ),
            Tab(
              child: Row(
                children: [
                  Icon(Icons.star),
                  SizedBox(width: 15),
                  Text('Favorites'),
                ],
              ),
              // icon: Icon(Icons.star),
              // text: 'Favorites',
            ),
          ]),
        ),
        body: TabBarView(children: [
          CategoriesScreen(),
          FavoritesScreen(null),
        ]),
      ),
    );
  }
}
