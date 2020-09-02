import 'package:flutter/material.dart';
import 'package:meal_chooser/dummy_data.dart';
import 'package:meal_chooser/models/meal.dart';

import 'package:meal_chooser/screens/category_meals_screen.dart';
import 'package:meal_chooser/screens/filters_screen.dart';
import 'package:meal_chooser/screens/meal_detail_screen.dart';
import 'package:meal_chooser/screens/tabs_bottom_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'Gluten-free': false,
    'Lactose-free': false,
    'Vegetarian': false,
    'Vegan': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(BuildContext context) {
    setState(() {
      // _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if ((_filters['Gluten-free'] && !meal.isGlutenFree) ||
            (_filters['Lactose-free'] && !meal.isLactoseFree) ||
            (_filters['Vegetarian'] && !meal.isVegetarian) ||
            (_filters['Vegan'] && !meal.isVegan)) {
          return false;
        }
        return true;
      }).toList();
    });
    Navigator.of(context).popAndPushNamed('/');
  }

  void _toggleFavorite(String mealId) {
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex == -1) {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    } else {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }
  }

  bool _isFavoriteMeal(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
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
              bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (ctx) => TabsBottomScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_isFavoriteMeal, _toggleFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      // return null;
      // return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => TabsBottomScreen(_favoriteMeals));
      },
    );
  }
}
